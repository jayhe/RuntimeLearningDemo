//
//  AttributeUsage.m
//  RuntimeLearning
//
//  Created by hechao on 2019/4/10.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "AttributeUsage.h"
#import "RuntimeLearningMacro.h"

void unexcept(void) __attribute__ ((noreturn));

@interface AttributeUsage ()

@property (strong, nonatomic) NSLock *lock;

@end

@implementation AttributeUsage

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _lock = [NSLock new];
        [self testUsages];
    }
    
    return self;
}

- (void)testUsages {
    [self cleanupUsage];
    [self testNoReturn:NO];
}

#pragma mark - cleanup
//#define onExit \
//__strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^ \

//static void blockCleanUp(__strong void(^*block)(void)) {
//    (*block)();
//}

- (void)cleanupUsage {
    [self.lock lock];
    onExit {
        [self.lock unlock];
    };
    // 做很多事情
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - constructor && destructor

__attribute__((constructor(2))) static void AttributeUsageConstructor1(void) {
    NSLog(@"Excute before main");
}

__attribute__((constructor(1))) static void AttributeUsageConstructor(void) {
    NSLog(@"Excute before main");
}

__attribute__((destructor)) static void AttributeUsageDestructor(void) {
    NSLog(@"Excute after main");
}

#pragma mark -

- (NSInteger)testNoReturn:(BOOL)aBool {
    if (aBool == NO) {
        return 0;
    } else {
        unexcept();
    }
}

void unexcept(void) {
    exit(1);
}

@end
