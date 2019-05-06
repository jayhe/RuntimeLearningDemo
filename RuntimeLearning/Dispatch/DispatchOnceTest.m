//
//  DispatchOnceTest.m
//  RuntimeLearning
//
//  Created by hechao on 2019/5/6.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "DispatchOnceTest.h"

@implementation DispatchOnceTest

/*
 void
 _dispatch_once(dispatch_once_t *predicate,
 DISPATCH_NOESCAPE dispatch_block_t block)
 {
 if (DISPATCH_EXPECT(*predicate, ~0l) != ~0l) {
 dispatch_once(predicate, block);
 } else {
 dispatch_compiler_barrier();
 }
 DISPATCH_COMPILER_CAN_ASSUME(*predicate == ~0l);
 }
 */
+ (instancetype)sharedInstance {
    static NSInteger callCount = 0;
    static dispatch_once_t onceToken;
    static DispatchOnceTest *_instance;
    int exceptValue = ~0l; // -1
    __unused long value = __builtin_expect(onceToken, exceptValue);
    if (callCount >= 1) {
//        onceToken = 3; // crash EXC_BAD_INSTRUCTION /*dispatch_compiler_barrier();*/
        onceToken = 0; // 会继续执行once中的代码
    }
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    callCount ++;
    
    return _instance;
}

@end
