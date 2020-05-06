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
        //[self testBarrier]; // x
        // [self testBarrier1]; // x
        //[self testGroup]; // ⩗
        //[self testGroup1]; // x
        [self testSemaphore]; // ⩗
        //[self testRunloop]; // ⩗
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

- (void)testBarrier1 {
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
    // dispatch_barrier_async_and_wait
    dispatch_barrier_async_and_wait(queue, ^{
        NSLog(@"dispatch_barrier_async_and_wait");
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
/*
 [Dispatch Semaphore](https://developer.apple.com/documentation/dispatch/dispatch_semaphore?language=objc)

 An object that controls access to a resource across multiple execution contexts through use of a traditional counting semaphore.

 Overview

 A dispatch semaphore is an efficient implementation of a traditional counting semaphore. Dispatch semaphores call down to the kernel only when the calling thread needs to be blocked. If the calling semaphore does not need to block, no kernel call is made.

 You increment a semaphore count by calling the dispatch_semaphore_signal method, and decrement a semaphore count by calling dispatch_semaphore_wait or one of its variants that specifies a timeout.
 */
- (void)testSemaphore {
    /*
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
     
     libdispatch.dylib`_dispatch_semaphore_signal_slow:
         0x10520978f <+0>:  pushq  %rbp
         0x105209790 <+1>:  movq   %rsp, %rbp
         0x105209793 <+4>:  pushq  %rbx
         0x105209794 <+5>:  pushq  %rax
         0x105209795 <+6>:  cmpl   $0x0, 0x40(%rdi)
         0x105209799 <+10>: leaq   0x40(%rdi), %rbx
         0x10520979d <+14>: jne    0x1052097a9               ; <+26>
         0x10520979f <+16>: movq   %rbx, %rdi
         0x1052097a2 <+19>: xorl   %esi, %esi
         0x1052097a4 <+21>: callq  0x10520918a               ; _dispatch_sema4_create_slow
         0x1052097a9 <+26>: movl   $0x1, %esi
         0x1052097ae <+31>: movq   %rbx, %rdi
         0x1052097b1 <+34>: callq  0x1052092f3               ; _dispatch_sema4_signal
     ->  0x1052097b6 <+39>: movl   $0x1, %eax
         0x1052097bb <+44>: addq   $0x8, %rsp
         0x1052097bf <+48>: popq   %rbx
         0x1052097c0 <+49>: popq   %rbp
         0x1052097c1 <+50>: retq   
     
     libsystem_kernel.dylib`semaphore_signal_trap:
     ->  0x7fff523b6268 <+0>:  movq   %rcx, %r10
         0x7fff523b626b <+3>:  movl   $0x1000021, %eax          ; imm = 0x1000021
         0x7fff523b6270 <+8>:  syscall
         0x7fff523b6272 <+10>: retq
         0x7fff523b6273 <+11>: nop
     
     
     libdispatch.dylib`_dispatch_sema4_signal:
         0x1052092f3 <+0>:  pushq  %rbp
         0x1052092f4 <+1>:  movq   %rsp, %rbp
         0x1052092f7 <+4>:  pushq  %r14
         0x1052092f9 <+6>:  pushq  %rbx
         0x1052092fa <+7>:  movq   %rsi, %rbx
         0x1052092fd <+10>: movq   %rdi, %r14
         0x105209300 <+13>: movl   (%r14), %edi
         0x105209303 <+16>: callq  0x10523f756               ; symbol stub for: semaphore_signal
     ->  0x105209308 <+21>: testl  %eax, %eax
         0x10520930a <+23>: jne    0x105209316               ; <+35>
         0x10520930c <+25>: decq   %rbx
         0x10520930f <+28>: jne    0x105209300               ; <+13>
         0x105209311 <+30>: popq   %rbx
         0x105209312 <+31>: popq   %r14
         0x105209314 <+33>: popq   %rbp
         0x105209315 <+34>: retq
         0x105209316 <+35>: cmpl   $0xf, %eax
         0x105209319 <+38>: je     0x105209327               ; <+52>
         0x10520931b <+40>: cmpl   $0xfffffed3, %eax         ; imm = 0xFFFFFED3
         0x105209320 <+45>: jne    0x10520932c               ; <+57>
         0x105209322 <+47>: callq  0x10523b2d1               ; _dispatch_sema4_signal.cold.2
         0x105209327 <+52>: callq  0x10523b2ef               ; _dispatch_sema4_signal.cold.3
         0x10520932c <+57>: movl   %eax, %edi
         0x10520932e <+59>: callq  0x10523b2b7               ; _dispatch_sema4_signal.cold.1
     
     */
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
            dispatch_semaphore_signal(sema);// signal次数要不小于wait次数，否则_dispatch_semaphore_dispose会报错"BUG IN CLIENT OF LIBDISPATCH: Semaphore object deallocated while in use"
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
