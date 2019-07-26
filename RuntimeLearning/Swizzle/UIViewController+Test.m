//
//  UIViewController+Test.m
//  RuntimeLearning
//
//  Created by hechao on 2019/4/10.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "UIViewController+Test.h"
#import <objc/runtime.h>

@implementation UIViewController (Test)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method replacementMethod = class_getInstanceMethod(self, @selector(hc_viewWillAppear:));
        if (class_addMethod(self, @selector(viewWillAppear:), method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))) {
            class_replaceMethod(self, @selector(hc_viewWillAppear:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, replacementMethod);
        }
    });
}

- (void)hc_viewWillAppear:(BOOL)animated {
    [self hc_viewWillAppear:animated];
}

@end
