//
//  DispatchGroupLeaveTest.m
//  RuntimeLearning
//
//  Created by hechao on 2019/5/7.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "DispatchGroupLeaveTest.h"
#import <fishhook/fishhook.h>

static void (*system_dispatch_group_leave)(dispatch_group_t dg);
void mine_dispatch_group_leave(dispatch_group_t dg);

@implementation DispatchGroupLeaveTest

- (instancetype)init {
    self = [super init];
    if (self) {
        [self hook];
        [self testGroupLeaveCrash];
    }
    
    return self;
}

- (void)hook {
    struct rebinding rb = {};
    rb.name = "dispatch_group_leave";
    rb.replaced = (void **)&system_dispatch_group_leave;
    rb.replacement = (void *)mine_dispatch_group_leave;
    struct rebinding rbs[] = {rb};
    rebind_symbols(rbs, 1);
}

// xcrun -sdk iphonesimulator clang -S DispatchGroupLeaveTest.m
- (void)testGroupLeaveCrash {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_leave(group);
    dispatch_group_leave(group); // "BUG IN CLIENT OF LIBDISPATCH: Unbalanced call to dispatch_group_leave()
}

/*
 #define fastpath(x) ((typeof(x))__builtin_expect(_safe_cast_to_long(x), ~0l))
 #define slowpath(x) ((typeof(x))__builtin_expect(_safe_cast_to_long(x), 0l))
 
 void
 dispatch_group_enter(dispatch_group_t dg)
 {
 long value = os_atomic_inc_orig2o(dg, dg_value, acquire);
 if (slowpath((unsigned long)value >= (unsigned long)LONG_MAX)) {
 DISPATCH_CLIENT_CRASH(value,
 "Too many nested calls to dispatch_group_enter()");
 }
 if (value == 0) {
 _dispatch_retain(dg); // <rdar://problem/22318411>
 }
 }
 
 void
 dispatch_group_leave(dispatch_group_t dg)
 {
 long value = os_atomic_dec2o(dg, dg_value, release);
 if (slowpath(value == 0)) {
 return (void)_dispatch_group_wake(dg, true);
 }
 if (slowpath(value < 0)) {
 DISPATCH_CLIENT_CRASH(value,
 "Unbalanced call to dispatch_group_leave()");
 }
 }
 
 void
 _dispatch_group_dispose(dispatch_object_t dou, DISPATCH_UNUSED bool *allow_free)
 {
 dispatch_group_t dg = dou._dg;
 
 if (dg->dg_value) {
 DISPATCH_CLIENT_CRASH(dg->dg_value,
 "Group object deallocated while in use");
 }
 
 _dispatch_sema4_dispose(&dg->dg_sema, _DSEMA4_POLICY_FIFO);
 }

 */

typedef struct my_dispatch_queue_t {
    int xref;
    int ref;
    int count;
    int gen;
    int waiters;
    int notifs;
} *dispatch_queue_t_layout;

void mine_dispatch_group_leave(dispatch_group_t dg) {
    // 尝试hook系统的dispatch_group_leave符号，这里拦截系统的leave和enter不批对导致的异常
    dispatch_queue_t_layout my_queue_t = (__bridge void *)dg;
    if (my_queue_t->count <= 0) {
        //NSCAssert(NO, @"dispatch_group_leave这里出错了");
    } else {
        system_dispatch_group_leave(dg);
    }
}

@end
