//
//  main.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/20.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PropertyUsage.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        NSData *data = [@"30B1EB3D-671F-4F52-BD91-F84F8DEAD594" dataUsingEncoding:NSUTF8StringEncoding];
//        // <33304231 45423344 2d363731 462d3446 35322d42 4439312d 46383446 38444541 44353934>
//        // <42383031 36383932 2d454542 462d3444 38322d38 4536302d 39354631 35433045 46323338>
//        //char *chars = '42383031 36383932 2d454542 462d3444 38322d38 4536302d 39354631 35433045 46323338';
//        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //[[PropertyUsage new] testPropertyUsage];
        //[[SubPropertyUsage new] testSubClassPropertyUsage];
        /*
        NSObject *testObj = [NSObject new];
        __weak typeof (testObj) weak1 = testObj;
        __weak typeof (testObj) weak2 = testObj;
        __weak typeof (testObj) weak3 = testObj;
        __weak typeof (testObj) weak4 = testObj;
        __weak typeof (testObj) weak5 = testObj;
        NSLog(@"%p %p %p %p %p %p", &weak1, &weak2, &weak3, &weak4, &weak5, &testObj);
        // RuntimeLearning[41918:854578] 0x7ffee964fc90 0x7ffee964fc88 0x7ffee964fc80 0x7ffee964fc78 0x7ffee964fc70 0x7ffee964fc98
         */
        //return 0;
        __block CGFloat testCGFloat; // be 0.0 ？？可能不是
        float testFloat; // be 0.0 ？？
        double testDouble; // be 0.0 ？？
        NSInteger testInteger; // be 0
        CGPoint testCGPoint; // be CGPointZero ？？可能不是
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
