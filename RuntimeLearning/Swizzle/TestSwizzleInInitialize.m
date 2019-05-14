//
//  TestSwizzleInInitialize.m
//  RuntimeLearning
//
//  Created by hechao on 2019/5/14.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestSwizzleInInitialize.h"
#import "MethodSwizzleUtil.h"

@implementation TestSwizzleInInitialize

+ (void)initialize {
    [super initialize];
    if (self == [TestSwizzleInInitialize self]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(testSwizzleMethod) replacementSel:@selector(s_testSwizzleMethod)];
        });
    }
}

- (void)testSwizzleMethod {
    NSLog(@"%s", __FUNCTION__);
}

- (void)testLogMethod {
    NSLog(@"%s", __FUNCTION__);
}

- (void)testTrackMethod {
    NSLog(@"%s", __FUNCTION__);
}

- (void)s_testSwizzleMethod {
    [self s_testSwizzleMethod];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation TestSwizzleInInitializeA

+ (void)initialize {
    [super initialize];
    if (self == [TestSwizzleInInitializeA self]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(testSwizzleMethod) replacementSel:@selector(a_testSwizzleMethod)];
        });
    }
}

- (void)a_testSwizzleMethod {
    [self a_testSwizzleMethod];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation TestSwizzleInInitializeB

+ (void)initialize {
    [super initialize];
    if (self == [TestSwizzleInInitializeB self]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(testSwizzleMethod) replacementSel:@selector(b_testSwizzleMethod)];
        });
    }
}

- (void)b_testSwizzleMethod {
    [self b_testSwizzleMethod];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation TestSwizzleInInitialize (Log)

+ (void)initialize {
    if (self == [TestSwizzleInInitialize self]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(testLogMethod) replacementSel:@selector(log_testSwizzleMethod)];
        });
    }
}

- (void)log_testSwizzleMethod {
    [self log_testSwizzleMethod];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation TestSwizzleInInitialize (Track)

+ (void)initialize {
    if (self == [TestSwizzleInInitialize self]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MethodSwizzleUtil swizzleInstanceMethodWithClass:self originalSel:@selector(testTrackMethod) replacementSel:@selector(track_testSwizzleMethod)];
        });
    }
}

- (void)track_testSwizzleMethod {
    [self track_testSwizzleMethod];
    NSLog(@"%s", __FUNCTION__);
}

@end
