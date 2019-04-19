//
//  TestUnsafeSwizzle.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/18.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestUnsafeSwizzle.h"
//#import "MethodSwizzleUtil.h"
#import <objc/runtime.h>

@implementation TestUnsafeSwizzle

- (void)testMethod {
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation SubTestUnsafeSwizzle

+ (void)load {
    Method original = class_getInstanceMethod([self class], @selector(testMethod));
    Method replacement = class_getInstanceMethod([self class], @selector(test_testMethod));
    method_exchangeImplementations(original, replacement);
}

- (void)test_testMethod {
    [self test_testMethod];
    NSLog(@"swizzle~test");
}

@end
