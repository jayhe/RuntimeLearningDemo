//
//  TestIsaUsage.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/12/10.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestIsaUsage.h"

@implementation TestIsaUsage
// OBJC_EXPORT id _Nullable objc_msgSendSuper2(struct objc_super * _Nonnull super, SEL _Nonnull op, ...)

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class])); // bl    _objc_msgSendSuper2 .loc    2 17 22                 ; RuntimeLearning/ISA/TestIsaUsage.m:17:22
        // 由于_objc_msgSendSuper2需要传入的objc_super结构体，receiver是self，super_class传的是当前类(这一点跟objc_msgSendSuper有差异)，所以这里调用传入的参数objc_super == {self, TestIsaUsage.class}，
    }
    return self;
}

- (NSString *)debugDescription {
    [super debugDescription];
    [self callSomeFunc];
    return @"debugDescription";
}

- (void)callSomeFunc {
    
}

@end
