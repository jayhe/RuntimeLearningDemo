//
//  MethodSwizzleUtil.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/19.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "MethodSwizzleUtil.h"
#import <objc/runtime.h>

@implementation MethodSwizzleUtil

+ (void)swizzleInstanceMethodWithClass:(Class)clazz originalSel:(SEL)original replacementSel:(SEL)replacement {
    /*
     struct objc_method {
     SEL _Nonnull method_name                                 OBJC2_UNAVAILABLE;
     char * _Nullable method_types                            OBJC2_UNAVAILABLE;
     IMP _Nonnull method_imp                                  OBJC2_UNAVAILABLE;
     }
     */
//    clazz = object_getClass(clazz);
    Method originalMethod = class_getInstanceMethod(clazz, original);// Note that this function searches superclasses for implementations, whereas class_copyMethodList does not!!如果子类没有实现该方法则返回的是父类的方法
    Method replacementMethod = class_getInstanceMethod(clazz, replacement);
    if (class_addMethod(clazz, original, method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))) {
        class_replaceMethod(clazz, replacement, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, replacementMethod);
    }
}

+ (void)swizzleClassMethodWithClass:(Class)clazz originalSel:(SEL)original replacementSel:(SEL)replacement {
    Class hookClass = object_getClass(clazz); // 类方法是在meta-class中，所以需要去获取到类的isa --> 指向的是meta-class
    Method originalMethod = class_getClassMethod(hookClass, original);
    Method replacementMethod = class_getClassMethod(hookClass, replacement);
    if (class_addMethod(hookClass, original, method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))) {
        class_replaceMethod(hookClass, replacement, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, replacementMethod);
    }
}

@end
