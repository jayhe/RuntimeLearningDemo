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

int main(int argc, char * argv[]) {
    @autoreleasepool {
        dynamicCallPrintfFunction();
        dynamicCallAddFunction();
        [DispatchOnceTest sharedInstance];
        [DispatchOnceTest sharedInstance];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
