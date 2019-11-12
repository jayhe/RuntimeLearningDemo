//
//  DispatchExamnationTest.m
//  RuntimeLearning
//
//  Created by 贺超 on 2019/11/7.
//  Copyright © 2019年 hechao. All rights reserved.
//

#import "DispatchExamnationTest.h"

@implementation DispatchExamnationTest

- (instancetype)init {
    if (self) {
        [self testCurrentQueue];
        [self testCurrentQueue1];
    }
    
    return self;
}

- (void)testCurrentQueue {
    dispatch_queue_t currentQueue = dispatch_queue_create("com.hc.currentQueue.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(currentQueue, ^{
        NSLog(@"%s:1", __FUNCTION__);
    });
    dispatch_async(currentQueue, ^{
        NSLog(@"%s:2", __FUNCTION__);
    });
    dispatch_sync(currentQueue, ^{
        NSLog(@"%s:3", __FUNCTION__);
    });
    NSLog(@"%s:4", __FUNCTION__);
    dispatch_async(currentQueue, ^{
        NSLog(@"%s:5", __FUNCTION__);
    });
    dispatch_async(currentQueue, ^{
        NSLog(@"%s:6", __FUNCTION__);
    });
    dispatch_async(currentQueue, ^{
        NSLog(@"%s:7", __FUNCTION__);
    });
    dispatch_async(currentQueue, ^{
        [self performSelector:@selector(testLog) withObject:nil afterDelay:0];
        //[self performSelector:@selector(testLog) withObject:nil];
    });
    // 3在4之前 12乱序
    // 567画乱序
    // 8不会打印：runloop默认没开启
}

- (void)testLog {
    NSLog(@"%s:8", __FUNCTION__);
}

- (void)testCurrentQueue1 {
    __block int a = 0;
    while(a < 5) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            a++;
            NSLog(@"%d -- currentQueue -- %@", a, [NSThread currentThread]);
        });
    }
    NSLog(@"%d", a); // >= 5
}

- (void)testSerialQueue {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.hc.serialQueue.test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"%s:1", __FUNCTION__);
    dispatch_async(serialQueue, ^{
        NSLog(@"%s:2", __FUNCTION__);
        dispatch_sync(serialQueue, ^{
           NSLog(@"%s:3", __FUNCTION__);
        });
        NSLog(@"%s:4", __FUNCTION__);
    });
    NSLog(@"%s:5", __FUNCTION__);
    // 1 2 3 死锁进系统断言程序退出
}

@end
