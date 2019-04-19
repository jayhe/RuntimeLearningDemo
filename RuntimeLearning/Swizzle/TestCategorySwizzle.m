//
//  TestCategorySwizzle.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/19.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestCategorySwizzle.h"
#import "MethodSwizzleUtil.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>

@implementation TestCategorySwizzle

- (void)testCategorySwizzle {
    NSLog(@"%s", __FUNCTION__);
}

+ (void)testClassMethod {
    
}

@end

@implementation TestCategorySwizzle(Log)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*
         struct {testCategorySwizzle, log_testCategorySwizzle.imp}
         struct {log_testCategorySwizzle, testCategorySwizzle.imp}
         */
        [MethodSwizzleUtil swizzleInstanceMethodWithClass:[TestCategorySwizzle class] originalSel:@selector(testCategorySwizzle) replacementSel:@selector(log_testCategorySwizzle)];
//        [self aspect_hookSelector:@selector(testCategorySwizzle) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//            [(TestCategorySwizzle *)aspectInfo.instance log_testCategorySwizzle];
//        } error:nil];
    });
}

- (void)log_testCategorySwizzle {
    [self log_testCategorySwizzle];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation TestCategorySwizzle(EventTrack)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*
         假设Log类别的load先执行
         struct {testCategorySwizzle, track_testCategorySwizzle.imp}
         struct {track_testCategorySwizzle, log_testCategorySwizzle.imp}
         */
        [MethodSwizzleUtil swizzleInstanceMethodWithClass:[TestCategorySwizzle class] originalSel:@selector(testCategorySwizzle) replacementSel:@selector(track_testCategorySwizzle)];
//        [self aspect_hookSelector:@selector(testCategorySwizzle) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//            [(TestCategorySwizzle *)aspectInfo.instance track_testCategorySwizzle];
//        } error:nil];
    });
}

- (void)track_testCategorySwizzle {
    [self track_testCategorySwizzle];
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation TestCategorySwizzle (ClassMethod)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getClassMethod(self, @selector(testClassMethod));
        Method replacementMethod = class_getClassMethod(self, @selector(class_testClassMethod));
        Class class = object_getClass(self);
        if (class_addMethod(class, @selector(testClassMethod), method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))) {
            class_replaceMethod(self, @selector(class_testClassMethod), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, replacementMethod);
        }
    });
}

+ (void)class_testClassMethod {
    
}

@end
