//
//  DispatchBarrierTest.m
//  RuntimeLearning
//
//  Created by hechao on 2019/5/6.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "DispatchBarrierTest.h"
#import "RuntimeLearningMacro.h"

@implementation DispatchBarrierTest

- (instancetype)init {
    self = [super init];
    if (self) {
        // 实现前面的任务执行完了再执行后面的任务
        [self testBarrier]; // x
        [self testGroup]; // ⩗
        [self testGroup1]; // x
        [self testSemaphore]; // ⩗
        [self testRunloop]; // ⩗
    }
    
    return self;
}

- (void)testBarrier {
    dispatch_queue_t queue = dispatch_queue_create("rl.barrier.test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"testBarrier-task1");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"testBarrier-task1:async task");
        });
    });
    dispatch_async(queue, ^{
        NSLog(@"testBarrier-task2");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testBarrier-task2:async task");
        });
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async");
    });
    dispatch_async(queue, ^{
        NSLog(@"testBarrier-task3");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testBarrier-task3:async task");
        });
    });
}

- (void)testGroup {
    dispatch_queue_t queue = dispatch_queue_create("rl.group.test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"testGroup-task1");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"testGroup-task1:async task");
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"testGroup-task2");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testGroup-task2:async task");
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_notify");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"testGroup-task3");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testGroup-task3:async task");
        });
    });
}

- (void)testGroup1 {
    dispatch_queue_t queue = dispatch_queue_create("rl.group1.test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"testGroup-task1");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"testGroup-task1:async task");
        });
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"testGroup-task2");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testGroup-task2:async task");
        });
    });
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    NSLog(@"dispatch_group_notify");
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_notify");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"testGroup-task3");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testGroup-task3:async task");
        });
    });
}

- (void)testSemaphore {
    dispatch_semaphore_t sema = dispatch_semaphore_create(2); // value如果为负数 则信号量为空 DISPATCH_BAD_INPUT
    dispatch_queue_t queue = dispatch_queue_create("rl.semaphore.test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"testSemaphore-task1");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"testSemaphore-task1:async task");
            dispatch_semaphore_signal(sema);
        });
    });
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"testSemaphore-task2");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testSemaphore-task2:async task");
            dispatch_semaphore_signal(sema);
        });
    });
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER); // 这里需要2个信号，这样保证前面的2个任务都完成才执行
        NSLog(@"testSemaphore-task3");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testSemaphore-task3:async task");
            dispatch_semaphore_signal(sema);
            dispatch_semaphore_signal(sema);// wait 和 signal要配对，否则_dispatch_semaphore_dispose会报错"BUG IN CLIENT OF LIBDISPATCH: Semaphore object deallocated while in use"
        });
    });
    /*
     // 当自增信号时，如果自增后 信号大于0 就不处理；否则就会唤起等待的线程 FIFO
     long
     dispatch_semaphore_signal(dispatch_semaphore_t dsema)
     {
     long value = os_atomic_inc2o(dsema, dsema_value, release);
     if (fastpath(value > 0)) {
     return 0;
     }
     if (slowpath(value == LONG_MIN)) {
     DISPATCH_CLIENT_CRASH(value,
     "Unbalanced call to dispatch_semaphore_signal()");
     }
     return _dispatch_semaphore_signal_slow(dsema);
     }
     
     void
     _dispatch_semaphore_dispose(dispatch_object_t dou,
     DISPATCH_UNUSED bool *allow_free)
     {
     dispatch_semaphore_t dsema = dou._dsema;
     
     if (dsema->dsema_value < dsema->dsema_orig) {
     DISPATCH_CLIENT_CRASH(dsema->dsema_orig - dsema->dsema_value,
     "Semaphore object deallocated while in use");
     }
     
     _dispatch_sema4_dispose(&dsema->dsema_sema, _DSEMA4_POLICY_FIFO);
     }

     */
}

- (void)testRunloop {
    dispatch_queue_t queue = dispatch_queue_create("rl.runloop.test.queue", DISPATCH_QUEUE_CONCURRENT);
    __block BOOL task1Finished = NO, task2Finished = NO;
    dispatch_async(queue, ^{
        NSLog(@"testRunloop-task1");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"testRunloop-task1:async task");
            task1Finished = YES;
        });
    });
    dispatch_async(queue, ^{
        NSLog(@"testRunloop-task2");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testRunloop-task2:async task");
            task2Finished = YES;
        });
    });
    dispatch_async(queue, ^{
        while (!(task1Finished && task2Finished)) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        }
        NSLog(@"testRunloop-task3");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"testRunloop-task3:async task");
        });
    });
}

@end
