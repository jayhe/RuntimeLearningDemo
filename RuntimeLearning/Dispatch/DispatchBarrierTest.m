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
        [self testBarrier];
        [self testGroup];
        [self testSemaphore];
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

- (void)testSemaphore {
    dispatch_semaphore_t sema = dispatch_semaphore_create(2);
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
            dispatch_semaphore_signal(sema);// wait 和 signal要配对
        });
    });
}

@end
