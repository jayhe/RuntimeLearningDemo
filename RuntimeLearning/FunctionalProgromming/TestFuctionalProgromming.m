//
//  TestFuctionalProgromming.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/5/9.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestFuctionalProgromming.h"
#import <objc/runtime.h>

@interface TestFuctionalProgromming ()

@property (nonatomic, assign) NSInteger a;
@property (nonatomic, assign) NSInteger b;

@end

@implementation TestFuctionalProgromming

- (instancetype)init {
    self = [super init];
    if (self) {
        self.handleA(2).handleB(3);
        //[self handleA];
        //self.handleA;
    }
    
    return self;
}

- (TestFuctionalProgromming *(^)(NSInteger b))handleB {
    return ^TestFuctionalProgromming *(NSInteger b) {
        self.b = b;
        NSLog(@"%ld", b);
        return self;
    };
}
/*
 #define BLOCK_DESCRIPTOR_1 1
 struct Block_descriptor_1 {
     uintptr_t reserved;
     uintptr_t size;
 };

 #define BLOCK_DESCRIPTOR_2 1
 struct Block_descriptor_2 {
     // requires BLOCK_HAS_COPY_DISPOSE
     BlockCopyFunction copy;
     BlockDisposeFunction dispose;
 };

 #define BLOCK_DESCRIPTOR_3 1
 struct Block_descriptor_3 {
     // requires BLOCK_HAS_SIGNATURE
     const char *signature;
     const char *layout;     // contents depend on BLOCK_HAS_EXTENDED_LAYOUT
 };

 struct Block_layout {
     void *isa;
     volatile int32_t flags; // contains ref count
     int32_t reserved;
     BlockInvokeFunction invoke;
     struct Block_descriptor_1 *descriptor;
     // imported variables
 };
 */
- (TestFuctionalProgromming *(^)(NSInteger a))handleA {
    id block = ^TestFuctionalProgromming *(NSInteger a) {
        self.a = a;
        NSLog(@"%ld", a);
        //return nil; // 这里返回nil的话 0x10f9ef24a <+298>: callq  *0x10(%rax) Thread 1: EXC_BAD_ACCESS (code=1, address=0x10)
        return self;
    };
    return block;
}

@end
