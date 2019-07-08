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

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        dynamicCallPrintfFunction();
//        dynamicCallAddFunction();
//        [DispatchOnceTest sharedInstance];
//        [DispatchOnceTest sharedInstance];
//        [DispatchBarrierTest new];
//        [DispatchGroupLeaveTest new];
//        __unused pid_t mainPid = getpid();
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            int *statloc = NULL;
//            __unused pid_t tmpPid = getpid();
//            pid_t pid = wait(statloc);
//            NSLog(@"pid_t = %d", (int)pid);
//            NSObject *obj = [[NSObject alloc] init];
//            uintptr_t disguiseValue = ~(uintptr_t)obj;
//            __unused uintptr_t undisguiseValue = ~disguiseValue;
//            
//            testWaitUsage();
//        });
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
