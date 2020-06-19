//
//  HookMethodInInitialize.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/16.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "HookMethodInInitialize.h"
#import "MethodSwizzleUtil.h"
#import "NSObject+Utility.h"
#import <objc/runtime.h>
/*
libobjc.A.dylib`CALLING_SOME_+initialize_METHOD:
    0x7fff513fc0f2 <+0>:  pushq  %rbp
    0x7fff513fc0f3 <+1>:  movq   %rsp, %rbp
    0x7fff513fc0f6 <+4>:  movq   0x38a0a3cb(%rip), %rsi    ; "initialize"
    0x7fff513fc0fd <+11>: callq  *0x3663a18d(%rip)         ; (void *)0x00007fff513f7780: objc_msgSend
->  0x7fff513fc103 <+17>: popq   %rbp
    0x7fff513fc104 <+18>: retq
*/

@implementation SuperHookMethodInInitialize
/*
 NSObject.m中定义的
 + (id)self {
     return (id)self;
 }

 - (id)self {
     return self;
 }
 */

+ (void)initialize {
    if (self == [SuperHookMethodInInitialize self]) { // 这个玩意能防止子类没有实现调用父类的，why?这里返回的是self，也就是类本身，假设是子类调用那么左边的self就是子类，而表达式右边则是本类，比较两个不相等则表示不是一个Class
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(methodToBeHooked) replacementSel:@selector(hookedMethodInSuper)];
        });
    }
}

- (void)methodToBeHooked; {
    NSLog(@"%s", __FUNCTION__);
}

- (void)hookedMethodInSuper {
    [self hookedMethodInSuper];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation HookMethodInInitialize

+ (void)initialize {
    if (self == [HookMethodInInitialize self]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(methodToBeHooked) replacementSel:@selector(hookedMethodInMine)];
        });
    }
}

- (void)hookedMethodInMine {
    [self hookedMethodInMine];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation SubHookMethodInInitialize

+ (void)initialize {
    if (self == [SubHookMethodInInitialize self]) {
        Method currentMethod = class_getClassMethod(self, _cmd);
        IMP currentMethodImp = method_getImplementation(currentMethod);
        callClassMethods(self, @selector(initialize), currentMethodImp);
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(methodToBeHooked) replacementSel:@selector(hookedMethodInSubclass)];
        });
    }
}

- (void)hookedMethodInSubclass {
    [self hookedMethodInSubclass];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation HookMethodInInitialize(CategoryA)

+ (void)initialize {
    if (self == [HookMethodInInitialize self]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(methodToBeHooked) replacementSel:@selector(hookedMethodInCategoryA)];
        });
    }
}

- (void)hookedMethodInCategoryA {
    [self hookedMethodInCategoryA];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation HookMethodInInitialize(CategoryB)

+ (void)initialize {
    if (self == [HookMethodInInitialize self]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(methodToBeHooked) replacementSel:@selector(hookedMethodInCategoryB)];
        });
    }
}

- (void)hookedMethodInCategoryB {
    [self hookedMethodInCategoryB];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation HookMethodInInitialize(CategoryC)

+ (void)initialize {
    if (self == [HookMethodInInitialize self]) {
        Method currentMethod = class_getClassMethod(self, _cmd);
        IMP currentMethodImp = method_getImplementation(currentMethod);
        callClassMethods(self, @selector(initialize), currentMethodImp);
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(methodToBeHooked) replacementSel:@selector(hookedMethodInCategoryC)];
        });
    }
}

- (void)hookedMethodInCategoryC {
    [self hookedMethodInCategoryC];
    NSLog(@"%s", __FUNCTION__);
}

@end
