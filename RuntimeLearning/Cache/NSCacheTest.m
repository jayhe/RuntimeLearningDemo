//
//  NSCacheTest.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/3/5.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "NSCacheTest.h"
#import <objc/runtime.h>

@interface NSCacheTest () <NSCacheDelegate>

@property (nonatomic, strong) NSCache *memoryCache;

@end

@implementation NSCacheTest

- (instancetype)init {
    self = [super init];
    if (self) {
        _memoryCache = [[NSCache alloc] init];
        _memoryCache.countLimit = 5;
        _memoryCache.totalCostLimit = 1024;
        _memoryCache.delegate = self;
    }
    
    return self;
}

- (void)test {
    //[self testOverlimit];
    //[self checkIfHasLRU];
    [self checkIfHasLFU];
}

#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"willEvictObject = %@", obj);
}

#pragma mark - Private Method

- (void)testOverlimit {
    NSInteger loopCount = 10;
    for (NSInteger i = 0; i < loopCount; i++) {
        NSString *urlString = [NSString stringWithFormat:@"https://www.test.%ld", (long)i];
        NSURL *obj = [NSURL URLWithString:urlString];
        [self.memoryCache setObject:obj forKey:@(i).stringValue];
    }
    
    // loopCount == 10的时候当执行之后会输出：
    // RuntimeLearning[19309:858051] willEvictObject = https://www.test.0
    // RuntimeLearning[19309:858051] willEvictObject = https://www.test.1
    // RuntimeLearning[19309:858051] willEvictObject = https://www.test.2
    // RuntimeLearning[19309:858051] willEvictObject = https://www.test.3
    // RuntimeLearning[19309:858051] willEvictObject = https://www.test.4
    // 可以看到先加入cache的元素被移除了
    [self logAllCachedData];
    /*
     RuntimeLearning[19858:902352] (
         "https://www.test.5",
         "https://www.test.6",
         "https://www.test.7",
         "https://www.test.8",
         "https://www.test.9"
     )
     */
    // 清除数据
    [self.memoryCache removeAllObjects];
}

// 最近未使用原则
- (void)checkIfHasLRU {
    NSInteger loopCount = 5;
    for (NSInteger i = 0; i < loopCount; i++) {
        NSString *urlString = [NSString stringWithFormat:@"https://www.test.%ld", (long)i];
        NSURL *obj = [NSURL URLWithString:urlString];
        [self.memoryCache setObject:obj forKey:@(i).stringValue];
    }
    [self.memoryCache objectForKey:@"0"];
    [self.memoryCache objectForKey:@"3"];
    [self logAllCachedData];
    NSString *urlString = @"https://www.test.6";
    NSURL *obj = [NSURL URLWithString:urlString];
    [self.memoryCache setObject:obj forKey:@"6"];
    // RuntimeLearning[19541:877142] willEvictObject = https://www.test.1
    NSString *urlString1 = @"https://www.test.7";
    NSURL *obj1 = [NSURL URLWithString:urlString1];
    [self.memoryCache setObject:obj1 forKey:@"7"];
    // RuntimeLearning[19541:877142] willEvictObject = https://www.test.2
    NSString *urlString2 = @"https://www.test.8";
    NSURL *obj2 = [NSURL URLWithString:urlString2];
    [self.memoryCache setObject:obj2 forKey:@"8"];
    // RuntimeLearning[19541:877142] willEvictObject = https://www.test.4
    // 清除数据
    [self.memoryCache removeAllObjects];
}

// 最不经常使用原则
- (void)checkIfHasLFU {
    NSInteger loopCount = 5;
    for (NSInteger i = 0; i < loopCount; i++) {
        NSString *urlString = [NSString stringWithFormat:@"https://www.test.%ld", (long)i];
        NSURL *obj = [NSURL URLWithString:urlString];
        [self.memoryCache setObject:obj forKey:@(i).stringValue];
    }
    [self.memoryCache objectForKey:@"1"];
    [self.memoryCache objectForKey:@"1"];
    [self.memoryCache objectForKey:@"3"];
    [self.memoryCache objectForKey:@"3"];
    [self.memoryCache objectForKey:@"4"];
    [self.memoryCache objectForKey:@"0"];
    [self logAllCachedData];
    /*
     RuntimeLearning[19795:898814] (
         "https://www.test.2",
         "https://www.test.0",
         "https://www.test.3",
         "https://www.test.1",
         "https://www.test.4"
     )
     */
    NSString *urlString = @"https://www.test.6";
    NSURL *obj = [NSURL URLWithString:urlString];
    [self.memoryCache setObject:obj forKey:@"6"];
    // RuntimeLearning[19628:885142] willEvictObject = https://www.test.2
    NSString *urlString1 = @"https://www.test.7";
    NSURL *obj1 = [NSURL URLWithString:urlString1];
    [self.memoryCache setObject:obj1 forKey:@"7"];
    // RuntimeLearning[19628:885142] willEvictObject = https://www.test.4
    NSString *urlString2 = @"https://www.test.8";
    NSURL *obj2 = [NSURL URLWithString:urlString2];
    [self.memoryCache setObject:obj2 forKey:@"8"];
    // RuntimeLearning[19628:885142] willEvictObject = https://www.test.0
    NSString *urlString3 = @"https://www.test.9";
    NSURL *obj3 = [NSURL URLWithString:urlString3];
    [self.memoryCache setObject:obj3 forKey:@"9"];
    // RuntimeLearning[19628:885142] willEvictObject = https://www.test.6
    // 这里看起来好像使用频次的优先级会高于最近使用
}

- (void)logAllCachedData {
    SEL allObjects = NSSelectorFromString(@"allObjects");
    IMP (*cachedAllObjects)(id, SEL);
    if ([self.memoryCache respondsToSelector:allObjects]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
        cachedAllObjects = class_getMethodImplementation([self.memoryCache class], allObjects);
#pragma clang diagnostic pop
    }
    if (cachedAllObjects) {
        NSLog(@"%@", cachedAllObjects(self.memoryCache, allObjects));
    }
}

@end
