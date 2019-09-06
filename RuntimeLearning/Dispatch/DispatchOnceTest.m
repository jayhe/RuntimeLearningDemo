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
 
 static int
 _dispatch_unfair_lock_wait(uint32_t *uaddr, uint32_t val, uint32_t timeout,
 dispatch_lock_options_t flags)
 {
 int rc;
 _dlock_syscall_switch(err,
 rc = __ulock_wait(UL_UNFAIR_LOCK | flags, uaddr, val, timeout),
 case 0: return rc > 0 ? ENOTEMPTY : 0;
 case ETIMEDOUT: case EFAULT: return err;
 case EOWNERDEAD: DISPATCH_CLIENT_CRASH(*uaddr,
 "corruption of lock owner");
 default: DISPATCH_INTERNAL_CRASH(err, "ulock_wait() failed");
 );
 }
 
 */
+ (instancetype)sharedInstance {
    static NSInteger callCount = 0;
    static dispatch_once_t onceToken;
    static DispatchOnceTest *_instance;
    int exceptValue = ~0l; // -1
    if (callCount >= 1) {
//        onceToken = 1; // crash EXC_BAD_INSTRUCTION ； "BUG IN CLIENT OF LIBDISPATCH: corruption of lock owner" "BUG IN LIBDISPATCH: ulock_wait() failed"
        onceToken = 0; // 会继续执行once中的代码
    }
    __unused long value = __builtin_expect(onceToken, exceptValue);
    // 执行完之后会将onceToken置-1；下次执行会判断onceToken的值不为-1为0就在此执行block为其他的值就会异常获取原子锁异常；为-1就不做处理
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    callCount ++;
    
    return _instance;
}

@end
