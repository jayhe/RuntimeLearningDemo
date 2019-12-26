//
//  TestHashTable.m
//  RuntimeLearning
//
//  Created by 贺超 on 2019/12/25.
//  Copyright © 2019年 hechao. All rights reserved.
//

#import "TestMapTable.h"

@interface TestMapTable ()

@property (nonatomic, strong) NSMapTable *weakCache;
@property (nonatomic, strong) NSMutableArray<NSObject *> *objArray;

@end

@implementation TestMapTable

- (instancetype)init {
    self = [super init];
    if (self) {
        self.objArray = [NSMutableArray arrayWithCapacity:0];
        [self testHashTableWeakMememory];
        [self test];
    }
    
    return self;
}

- (void)testHashTableWeakMememory {
    self.weakCache = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
    NSObject *aObj = [NSObject new]; // 1
    NSLog(@"0 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj)));
    [self.objArray addObject:aObj]; // 2
    NSLog(@"1 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj)));
    [self.weakCache setObject:aObj forKey:@"aObj"]; // 2
    NSLog(@"2 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj)));
    [self.objArray removeAllObjects];
    NSLog(@"3 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj))); // 1
    // [self.weakCache objectForKey:@"aObj"]; // 这里打印为什么会是2 猜测objectForKey内部会返回[[obj retain] autorelease]
    // NSLog(@"4 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj))); // 2
}

- (void)test {
    if ([self.weakCache objectForKey:@"aObj"]) {
        NSLog(@"5 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)([self.weakCache objectForKey:@"aObj"])));
    }
}

@end
