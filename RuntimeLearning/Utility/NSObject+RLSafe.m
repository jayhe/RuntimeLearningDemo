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
NSString const *RLUnrecognizedSelectorMessageKey = @"RLUnrecognizedSelectorMessageKey";
NSString const *RLForwardTargetMessageKey = @"RLForwardTargetMessageKey";

RLUnrecognizedSelectorExceptionHandler * _Nullable RLGetUnrecognizedSelectorExceptionHandler(void) {
    return RLUSEHandler;
}

void RLSetUnrecognizedSelectorExceptionHandler(RLUnrecognizedSelectorExceptionHandler * _Nullable handler) {
    RLUSEHandler = handler;
}

@implementation NSObject (RLSafe)
#define CATCH_CRASH 1
+ (void)load {
#if CATCH_CRASH
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MethodSwizzleUtil swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(forwardInvocation:) replacementSel:@selector(rl_forwardInvocation:)];
        [MethodSwizzleUtil swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(methodSignatureForSelector:) replacementSel:@selector(rl_methodSignatureForSelector:)];
        [MethodSwizzleUtil swizzleInstanceMethodWithClass:[NSObject class] originalSel:@selector(forwardingTargetForSelector:) replacementSel:@selector(rl_forwardingTargetForSelector:)];
    });
#endif
}

- (id)rl_forwardingTargetForSelector:(SEL)aSelector {
#if CATCH_CRASH
    NSArray<NSObject *> *targets;
    if ([self conformsToProtocol:@protocol(RLCatchUnrecognizedSelectorProtocol)] && [self respondsToSelector:@selector(targetsToForward)]) {
        targets = [(id<RLCatchUnrecognizedSelectorProtocol>)self targetsToForward];
    } else {
        targets = [self commonDataTargetsToForward]; // 默认的转发，只处理部分基础数据的
    }
    if (targets) {
        __block NSObject *targetToForward = nil;
        [targets enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:aSelector]) {
                targetToForward = obj;
                *stop = YES;
            }
        }];
        if (targetToForward && RLUSEHandler) {
            NSString *info = [NSString stringWithFormat:@"instance %p -[%@ %@] forward target to %@", self, self.class, NSStringFromSelector(aSelector), targetToForward.class];
            NSDictionary *userInfo = @{
                RLForwardTargetMessageKey : info
            };
            RLUSEHandler(userInfo);
        }
        return targetToForward;
    } else {
        return [self rl_forwardingTargetForSelector:aSelector];
    }
#else
    return [self rl_forwardingTargetForSelector:aSelector];
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
#else
    return [self rl_methodSignatureForSelector:selector];
#endif
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
#else
    [self rl_forwardInvocation:anInvocation];
#endif
}

#pragma mark - Private Method

- (id)nilMessage {
    return nil;
}

- (nullable NSArray<NSObject *> *)commonDataTargetsToForward {
    if ([self isKindOfClass:[NSString class]] ||
        [self isKindOfClass:[NSArray class]] ||
        [self isKindOfClass:[NSDictionary class]] ||
        [self isKindOfClass:[NSData class]]) {
        static NSArray<NSObject *> *dataTargets;
        if (dataTargets == nil) {
            dataTargets = @[
                [NSString string],
                [NSArray array],
                [NSDictionary dictionary],
                [NSData data],
            ];
        }
        return dataTargets;
    } else if ([self isKindOfClass:[NSNumber class]]) {
        static NSArray<NSObject *> *numberTargets;
        if (numberTargets == nil) {
            numberTargets = @[
                [NSString string]
            ];
        }
    }
    return nil;
}

@end
