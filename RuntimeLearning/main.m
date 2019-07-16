//
//  main.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/20.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DynamicCallFunctionTest.h"
#import "DispatchOnceTest.h"
#import "DispatchBarrierTest.h"
#import "DispatchGroupLeaveTest.h"

void testWaitUsage(void);
void testLogicNot(NSInteger times);
void testLogicEqualNil(NSInteger times);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        dynamicCallPrintfFunction();
        dynamicCallAddFunction();
        [DispatchOnceTest sharedInstance];
        [DispatchOnceTest sharedInstance];
        [DispatchBarrierTest new];
        [DispatchGroupLeaveTest new];
        __unused pid_t mainPid = getpid();
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            int *statloc = NULL;
            __unused pid_t tmpPid = getpid();
            pid_t pid = wait(statloc);
            NSLog(@"pid_t = %d", (int)pid);
            NSObject *obj = [[NSObject alloc] init];
            uintptr_t disguiseValue = ~(uintptr_t)obj;
            __unused uintptr_t undisguiseValue = ~disguiseValue;
            
            testWaitUsage();
        });
//        return 0;
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

void testWaitUsage(void) {
    pid_t pc,pr;
    pc = fork();
    if(pc < 0) {
        NSLog(@"error ocurred!/n");
    } else if (pc == 0) {
        NSLog(@"This is child process with pid of %d/n", getpid());
        sleep(5);
    } else {
        pr = wait(NULL);
        NSLog(@"I catched a child process with pid of %d/n", pr);
    }
}

void testLogicNot(NSInteger times) {
    if (times == 0) {
        return;
    }
    CFAbsoluteTime totalCost = 0;
    for (NSInteger i = 0; i < times; i ++) {
        CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
        NSObject *test;
        for (NSInteger j = 0; j < 100000000; j ++) {
            if (!test) {
                
            }
        }
        totalCost += (CFAbsoluteTimeGetCurrent() - time);
        NSLog(@"time cost: %.4f", CFAbsoluteTimeGetCurrent() - time);
    }
    NSLog(@"average time cost: %.4f", totalCost / times);
    /*
     2019-07-13 10:07:36.597256+0800 RuntimeLearning[7885:8687005] time cost: 0.1631
     2019-07-13 10:07:36.764009+0800 RuntimeLearning[7885:8687005] time cost: 0.1666
     2019-07-13 10:07:36.927153+0800 RuntimeLearning[7885:8687005] time cost: 0.1630
     2019-07-13 10:07:37.095567+0800 RuntimeLearning[7885:8687005] time cost: 0.1683
     2019-07-13 10:07:37.256778+0800 RuntimeLearning[7885:8687005] time cost: 0.1611
     2019-07-13 10:07:37.412076+0800 RuntimeLearning[7885:8687005] time cost: 0.1552
     2019-07-13 10:07:37.577263+0800 RuntimeLearning[7885:8687005] time cost: 0.1650
     2019-07-13 10:07:37.732546+0800 RuntimeLearning[7885:8687005] time cost: 0.1552
     2019-07-13 10:07:37.901192+0800 RuntimeLearning[7885:8687005] time cost: 0.1685
     2019-07-13 10:07:38.061348+0800 RuntimeLearning[7885:8687005] time cost: 0.1600
     2019-07-13 10:07:38.225245+0800 RuntimeLearning[7885:8687005] time cost: 0.1638
     2019-07-13 10:07:38.383679+0800 RuntimeLearning[7885:8687005] time cost: 0.1583
     2019-07-13 10:07:38.550693+0800 RuntimeLearning[7885:8687005] time cost: 0.1669
     2019-07-13 10:07:38.715068+0800 RuntimeLearning[7885:8687005] time cost: 0.1642
     2019-07-13 10:07:38.886890+0800 RuntimeLearning[7885:8687005] time cost: 0.1717
     2019-07-13 10:07:39.041844+0800 RuntimeLearning[7885:8687005] time cost: 0.1548
     2019-07-13 10:07:39.203011+0800 RuntimeLearning[7885:8687005] time cost: 0.1610
     2019-07-13 10:07:39.362856+0800 RuntimeLearning[7885:8687005] time cost: 0.1597
     2019-07-13 10:07:39.523183+0800 RuntimeLearning[7885:8687005] time cost: 0.1602
     2019-07-13 10:07:39.677425+0800 RuntimeLearning[7885:8687005] time cost: 0.1541
     2019-07-13 10:07:39.677538+0800 RuntimeLearning[7885:8687005] average time cost: 0.1620
     */
}

void testLogicEqualNil(NSInteger times) {
    if (times == 0) {
        return;
    }
    CFAbsoluteTime totalCost = 0;
    for (NSInteger i = 0; i < 20; i ++) {
        CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
        NSObject *test;
        for (NSInteger j = 0; j < 100000000; j ++) {
            if (test == nil) {
                
            }
        }
        totalCost += (CFAbsoluteTimeGetCurrent() - time);
        NSLog(@"time cost: %.4f", CFAbsoluteTimeGetCurrent() - time);
    }
    NSLog(@"average time cost: %.4f", totalCost / times);
    /*
     2019-07-13 10:08:27.736487+0800 RuntimeLearning[7925:8688951] time cost: 0.1454
     2019-07-13 10:08:27.880481+0800 RuntimeLearning[7925:8688951] time cost: 0.1438
     2019-07-13 10:08:28.023278+0800 RuntimeLearning[7925:8688951] time cost: 0.1427
     2019-07-13 10:08:28.173704+0800 RuntimeLearning[7925:8688951] time cost: 0.1503
     2019-07-13 10:08:28.320942+0800 RuntimeLearning[7925:8688951] time cost: 0.1471
     2019-07-13 10:08:28.469281+0800 RuntimeLearning[7925:8688951] time cost: 0.1482
     2019-07-13 10:08:28.614297+0800 RuntimeLearning[7925:8688951] time cost: 0.1448
     2019-07-13 10:08:28.762971+0800 RuntimeLearning[7925:8688951] time cost: 0.1486
     2019-07-13 10:08:28.907184+0800 RuntimeLearning[7925:8688951] time cost: 0.1441
     2019-07-13 10:08:29.052712+0800 RuntimeLearning[7925:8688951] time cost: 0.1454
     2019-07-13 10:08:29.194756+0800 RuntimeLearning[7925:8688951] time cost: 0.1419
     2019-07-13 10:08:29.337975+0800 RuntimeLearning[7925:8688951] time cost: 0.1431
     2019-07-13 10:08:29.481757+0800 RuntimeLearning[7925:8688951] time cost: 0.1436
     2019-07-13 10:08:29.626273+0800 RuntimeLearning[7925:8688951] time cost: 0.1443
     2019-07-13 10:08:29.773237+0800 RuntimeLearning[7925:8688951] time cost: 0.1468
     2019-07-13 10:08:29.920283+0800 RuntimeLearning[7925:8688951] time cost: 0.1469
     2019-07-13 10:08:30.063997+0800 RuntimeLearning[7925:8688951] time cost: 0.1436
     2019-07-13 10:08:30.207566+0800 RuntimeLearning[7925:8688951] time cost: 0.1434
     2019-07-13 10:08:30.352019+0800 RuntimeLearning[7925:8688951] time cost: 0.1443
     2019-07-13 10:08:30.502022+0800 RuntimeLearning[7925:8688951] time cost: 0.1499
     2019-07-13 10:08:30.502139+0800 RuntimeLearning[7925:8688951] average time cost: 0.1454
     */
}
