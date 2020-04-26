//
//  main.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/20.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        __block CGFloat testCGFloat; // be 0.0 ？？可能不是
        float testFloat; // be 0.0 ？？
        double testDouble; // be 0.0 ？？
        NSInteger testInteger; // be 0
        CGPoint testCGPoint; // be CGPointZero ？？可能不是
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
