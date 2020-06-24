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

/*
 + (id)self {
     return (id)self;
 }

 - (id)self {
     return self;
 }
 
 struct objc_super {
     /// Specifies an instance of a class.
     __unsafe_unretained _Nonnull id receiver;

     /// Specifies the particular superclass of the instance to message.
 #if !defined(__cplusplus)  &&  !__OBJC2__
     // For compatibility with old objc-runtime.h header
     __unsafe_unretained _Nonnull Class class;
 #else
     __unsafe_unretained _Nonnull Class super_class;
 #endif
    //super_class is the first class to search
 };
 
 OBJC_EXPORT void
 objc_msgSendSuper(void // struct objc_super *super, SEL op, ... )
 
 */

+ (void)initialize {
    [super initialize];
    if (self == [TestSwizzleInInitialize self]) { // 这个玩意能防止子类没有实现调用父类的，why?由于类的self返回的事self也就是类本身，当子类没有实现initialize的时候调用，默认会调用父类的这个时候表达式左边self是子类，而表达式右边是本类，所以就能达到该效果
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
