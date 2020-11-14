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

@interface TestMapTableObject : NSObject

@end

@implementation TestMapTableObject

@end

@implementation TestMapTable

- (instancetype)init {
    self = [super init];
    if (self) {
        self.objArray = [NSMutableArray arrayWithCapacity:0];
        [self testHashTableWeakMememory];
        [self test];
        //[self testWeakHashTableNotPurgedRightAway];
    }
    
    return self;
}

- (void)testHashTableWeakMememory {
    self.weakCache = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
    TestMapTableObject *aObj = [TestMapTableObject new]; // 1
    NSLog(@"0 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj)));
    [self.objArray addObject:aObj]; // 2
    NSLog(@"1 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj)));
    [self.weakCache setObject:aObj forKey:@"aObj"]; // 2
    NSLog(@"2 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj)));
    [self.objArray removeAllObjects];
    NSLog(@"3 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj))); // 1
    /*
     打个符号断点：objc_retainAutoreleasedReturnValue
     (lldb) register read rdi
          rdi = 0x00007fbfe5c04c60
     (lldb) po 0x00007fbfe5c04c60
     NSMapTable {
     [2] aObj -> <TestMapTableObject: 0x6000023b0c10>
     }
     */
    [self.weakCache objectForKey:@"aObj"]; // 这里打印为什么会是2 猜测objectForKey内部会返回[[obj retain] autorelease]
    NSLog(@"4 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aObj))); // 2
}

- (void)testWeakHashTableNotPurgedRightAway {
    self.weakCache = [NSMapTable strongToWeakObjectsMapTable]; // weak obj and strong key
    for (NSInteger i = 0; i < 100; i ++) {
        {
            NSObject *aObj = [NSObject new];
            [self.weakCache setObject:aObj forKey:@"aObj"];
        }
        NSLog(@"weakObj = %@", [self.weakCache objectForKey:@"aObj"]);
    }
}

- (void)test {
    if ([self.weakCache objectForKey:@"aObj"]) {
        NSLog(@"5 ref count obj:%ld", (long)CFGetRetainCount((__bridge CFTypeRef)([self.weakCache objectForKey:@"aObj"])));
    }
}

@end
