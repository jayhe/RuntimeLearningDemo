//
//  NSObject+Safe.m
//  RuntimeLearning
//
//  Created by hechao on 2019/1/29.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "NSObject+RLSafe.h"
#import "MethodSwizzleUtil.h"
#import <objc/runtime.h>

@implementation NSObject (RLSafe)

+ (void)load {
#if CATCH_CRASH
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MethodSwizzleUtil swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(forwardInvocation:) replacementSel:@selector(rl_forwardInvocation:)];
        [MethodSwizzleUtil swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(methodSignatureForSelector:) replacementSel:@selector(rl_methodSignatureForSelector:)];
    });
#endif
}

- (NSMethodSignature *)rl_methodSignatureForSelector:(SEL)selector {
#if CATCH_CRASH
    NSMethodSignature *signature = [self rl_methodSignatureForSelector:selector];
    if (signature == nil) {
        signature = [self methodSignatureForSelector:@selector(nilMessage)];
    }
    
    return signature;
#endif
    return [self rl_methodSignatureForSelector:selector];
}

- (void)rl_forwardInvocation:(NSInvocation *)anInvocation {
#if CATCH_CRASH
    if (![self respondsToSelector:anInvocation.selector]) {
        NSLog(@"unrecognized selector: %@ send to class: %@", NSStringFromSelector(anInvocation.selector), NSStringFromClass(((NSObject *)anInvocation.target).class));
        anInvocation.selector = @selector(nilMessage);
        [anInvocation invokeWithTarget:self];
        return;
    }
#endif
    [self rl_forwardInvocation:anInvocation];
}

- (id)nilMessage {
    return nil;
}

@end
