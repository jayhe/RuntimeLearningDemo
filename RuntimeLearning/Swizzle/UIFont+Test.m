//
//  UIFont+Test.m
//  RuntimeLearning
//
//  Created by hechao on 2019/4/10.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "UIFont+Test.h"
#import <objc/runtime.h>

@implementation UIFont (Test)

+ (void)initialize {
    
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getClassMethod(self, @selector(fontWithName:size:));
        Method replacementMethod = class_getClassMethod(self, @selector(hc_fontWithName:size:));
        // 这里add会add成功，类的类方法替换需要注意点就是替换的时候要替换类的isa，通过object_getClass(self)获得
//        if (class_addMethod(object_getClass(self), @selector(fontWithName:size:), method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))) {
        if (class_addMethod(self, @selector(fontWithName:size:), method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))) {
            class_replaceMethod(self, @selector(hc_fontWithName:size:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, replacementMethod);
        }
    });
}

+ (instancetype)hc_fontWithName:(NSString *)name size:(CGFloat)size {
    return [UIFont systemFontOfSize:size];
}

@end
