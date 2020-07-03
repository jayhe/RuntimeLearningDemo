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

static RLUnrecognizedSelectorExceptionHandler *RLUSEHandler = NULL;
NSString const *RLUnrecognizedSelectorMessageKey = @"UnrecognizedSelectorKey";

RLUnrecognizedSelectorExceptionHandler * _Nullable RLGetUnrecognizedSelectorExceptionHandler(void) {
    return RLUSEHandler;
}

void RLSetUnrecognizedSelectorExceptionHandler(RLUnrecognizedSelectorExceptionHandler * _Nullable handler) {
    RLUSEHandler = handler;
}

@implementation NSObject (RLSafe)
//#define CATCH_CRASH 1
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
    BOOL shouldCatch = YES;
    if ([self conformsToProtocol:@protocol(RLCatchUnrecognizedSelectorProtocol)] && [self respondsToSelector:@selector(shouldCatch)]) {
        shouldCatch = [(id<RLCatchUnrecognizedSelectorProtocol>)self shouldCatch];
    }
    if (shouldCatch) {
        NSMethodSignature *signature = [self rl_methodSignatureForSelector:selector];
        if (signature == nil) {
            signature = [self methodSignatureForSelector:@selector(nilMessage)];
        }
        
        return signature;
    } else {
        return [self rl_methodSignatureForSelector:selector];
    }
#endif
    return [self rl_methodSignatureForSelector:selector];
}

- (void)rl_forwardInvocation:(NSInvocation *)anInvocation {
#if CATCH_CRASH
    if (![self respondsToSelector:anInvocation.selector]) {
        if (RLUSEHandler) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            NSString *message = [NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance %p", NSStringFromClass(((NSObject *)anInvocation.target).class), NSStringFromSelector(anInvocation.selector), anInvocation.target];
            [userInfo setObject:message forKey:RLUnrecognizedSelectorMessageKey];
            
            RLUSEHandler(userInfo);
        }
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
