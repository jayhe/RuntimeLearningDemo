//
//  TestSubClassSwizzle.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/20.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestSubClassSwizzle.h"

@implementation TestSubClassSwizzle

- (void)testSubClassSwizzle {
    NSLog(@"%s", __FUNCTION__);
}

- (void)s_testSubClassSwizzle {
    [self s_testSubClassSwizzle];
}

@end

@implementation TestASubClassSwizzle

- (void)a_testSubClassSwizzle {
    [self a_testSubClassSwizzle];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation TestBSubClassSwizzle

- (void)b_testSubClassSwizzle {
    [self b_testSubClassSwizzle];
    NSLog(@"%s", __FUNCTION__);
}

@end
