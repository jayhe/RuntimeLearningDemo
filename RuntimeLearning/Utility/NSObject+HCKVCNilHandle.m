//
//  NSObject+HCKVCNilHandle.m
//  RuntimeLearning
//
//  Created by 贺超 on 2021/1/12.
//  Copyright © 2021 hechao. All rights reserved.
//

#import "NSObject+HCKVCNilHandle.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSObject (HCKVCNilHandle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod(self.class, @selector(setNilValueForKey:));
        Method hookMethod = class_getInstanceMethod(self.class, @selector(hc_setNilValueForKey:));
        method_exchangeImplementations(originMethod, hookMethod);
    });
}

- (nullable Ivar)hc_getIvarByKey:(NSString *)key {
    if (![key isKindOfClass:[NSString class]] || key.length <= 0) {
        return nil;
    }
    // 按照_key _isKey key isKey的方式去获取ivar
    NSString *firstCharacter = [key substringToIndex:1];
    NSString *upperFirstKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
    
    NSString *_keyName = [NSString stringWithFormat:@"_%@", key];
    NSString *_isKeyName = [NSString stringWithFormat:@"_is%@", upperFirstKey];
    NSString *keyName = key;
    NSString *isKeyName = [NSString stringWithFormat:@"is%@", upperFirstKey];
    Ivar ivar;
    if ((ivar = [self hc_getIvarByIvarName:_keyName])
        || (ivar = [self hc_getIvarByIvarName:_isKeyName])
        || (ivar = [self hc_getIvarByIvarName:keyName])
        || (ivar = [self hc_getIvarByIvarName:isKeyName])) {
        return ivar;
    }
    return nil;
}

- (nullable Ivar)hc_getIvarByIvarName:(NSString *)ivarNameString {
    const char *ivarName = [ivarNameString cStringUsingEncoding:NSUTF8StringEncoding];
    Ivar ivar = class_getInstanceVariable(self.class, ivarName);
    return ivar;
}

- (nullable Method)hc_getMethodByKey:(NSString *)key {
    if (![key isKindOfClass:[NSString class]] || key.length <= 0) {
        return nil;
    }
    NSString *firstCharacter = [key substringToIndex:1];
    NSString *upperFirstKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
    NSString *setKeyName = [NSString stringWithFormat:@"set%@:", upperFirstKey];
    NSString *_setKeyName = [NSString stringWithFormat:@"_set%@:", upperFirstKey];
    NSString *setIsKeyName = [NSString stringWithFormat:@"setIs%@:", upperFirstKey];
    Method method;
#define METHOD_BY_NAME(selName) class_getInstanceMethod(self.class, NSSelectorFromString(selName))
    if ((method = METHOD_BY_NAME(setKeyName))
        || (method = METHOD_BY_NAME(_setKeyName))
        || (method = METHOD_BY_NAME(setIsKeyName))) {
        return method;
    }
    return nil;
}

- (void)hc_setNilValueForKey:(NSString *)key {
    // 获取是否有set方法
    Method method = [self hc_getMethodByKey:key];
    const char *typeEncoding = NULL;
    if (method != nil) {
        typeEncoding = method_copyArgumentType(method, 2); // 获取参数的encoding信息，method有2个缺省参数 self _cmd 所以这里是2
    } else if ([self.class accessInstanceVariablesDirectly]) {
        // 获取ivar
        Ivar ivar = [self hc_getIvarByKey:key];
        if (ivar != nil) {
            typeEncoding = ivar_getTypeEncoding(ivar);
        }
    }
    if (typeEncoding == NULL) {
        [self hc_setNilValueForKey:key];
        return;
    }
    // 遍历出所有的number、value类型的encoding，针对性的处理
    // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
    /*
     Printing description of typeEncoding:
     (const char *) typeEncoding = 0x000000010f4c5c7a "{_NSRange=\"location\"Q\"length\"Q}"
     (lldb) po @encode(NSRange)
     "{_NSRange=QQ}"
     */
    switch (typeEncoding[0]) {
            // NSNumber scalar type
        case 'q': // longlong
        case 'Q': // unsigned longlong
        case 'i': // int
        case 'I': // unsigned int
        case 'l': // long
        case 'L': // unsigned long
        case 's': // short
        case 'S': // unsigned short
        case 'd': // double
        case 'f': // float
            [self setValue:@(0) forKey:key];
            break;
        case '{': {
            char* idx = index(typeEncoding, '='); // 获取'='字符串中第一个出现的参数'=' 地址，然后将该字符出现的地址返回
            /*
             eg："0x000000010bac7c7a {_NSRange=\"location\"Q\"length\"Q}" idx则为 0x000000010bac7c83 "=\"location\"Q\"length\"Q}"
             
             Printing description of idx:
             (char *) idx = 0x000000010bac7c83 "=\"location\"Q\"length\"Q}"
             Printing description of typeEncoding:
             (const char *) typeEncoding = 0x000000010bac7c7a "{_NSRange=\"location\"Q\"length\"Q}"
             */
            if (idx == NULL) { // 如果为空则表示没有找到'='，此时走原来的流程
                [self hc_setNilValueForKey:key];
            }
            // 处理NSValue的一些场景：比如NSRange、CGRect、CGPoint、CGSize；也就是NSValue structure type
            /*
             int strncmp(const char *str1, const char *str2, size_t n) 把 str1 和 str2 进行比较，最多比较前 n 个字节
             如果返回值 < 0，则表示 str1 小于 str2。
             如果返回值 > 0，则表示 str2 小于 str1。
             如果返回值 = 0，则表示 str1 等于 str2。
             */
            NSValue *value;
            long cmpLength = idx - typeEncoding;
#define SAME_ENCODE(name) (strncmp(typeEncoding, @encode(name), cmpLength) == 0)
            if (SAME_ENCODE(NSRange)) {
                value = [NSValue valueWithRange:NSMakeRange(0, 0)];
            } else if (SAME_ENCODE(CGPoint)) {
                value = [NSValue valueWithCGPoint:CGPointZero];
            } else if (SAME_ENCODE(CGSize)) {
                value = [NSValue valueWithCGSize:CGSizeZero];
            } else if (SAME_ENCODE(CGRect)) {
                value = [NSValue valueWithCGRect:CGRectZero];
            } else if (SAME_ENCODE(CGVector)) {
                value = [NSValue valueWithCGVector:CGVectorMake(0, 0)];
            } else if (SAME_ENCODE(UIEdgeInsets)) {
                value = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
            } else if (SAME_ENCODE(UIOffset)) {
                value = [NSValue valueWithUIOffset:UIOffsetZero];
            } else if (SAME_ENCODE(CGAffineTransform)) {
                value = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
            }
#ifndef FOUNDATION_HAS_DIRECTIONAL_GEOMETRY
            else if (@available(iOS 11.0, *)) {
                if (SAME_ENCODE(NSDirectionalEdgeInsets)) {
                    value = [NSValue valueWithDirectionalEdgeInsets:NSDirectionalEdgeInsetsZero];
                }
            } else {
                // Fallback on earlier versions
            }
#endif
            if (value != nil) {
                [self setValue:value forKey:key];
            } else {
                [self hc_setNilValueForKey:key];
            }
        }
            break;
        default:
            [self hc_setNilValueForKey:key];
            break;
    }
}

@end
