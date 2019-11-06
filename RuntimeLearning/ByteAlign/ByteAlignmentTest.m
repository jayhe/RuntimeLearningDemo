//
//  ByteAlignmentTest.m
//  RuntimeLearning
//
//  Created by 贺超 on 2019/11/5.
//  Copyright © 2019年 hechao. All rights reserved.
//

#import "ByteAlignmentTest.h"
#import <objc/runtime.h>

#ifdef __LP64__
#   define WORD_SHIFT 3UL
#   define WORD_MASK 7UL
#   define WORD_BITS 64
#else
#   define WORD_SHIFT 2UL
#   define WORD_MASK 3UL
#   define WORD_BITS 32
#endif

static inline size_t word_align(size_t x) {
    return (x + WORD_MASK) & ~WORD_MASK;
}

@interface ByteAlignmentTest ()

@property (nonatomic, assign) int a;
@property (nonatomic, assign) char b;
@property (nonatomic, assign) short c;
@property (nonatomic, assign) short d;
@property (nonatomic, copy) NSString *testString; // 指针8字节
@property (nonatomic, strong) ByteAlignmentTest *testObject; // 指针8字节

@end

@implementation ByteAlignmentTest

- (instancetype)init {
    self = [super init];
    if (self) {
//        _testString = @"test test test test test";
        [self test];
    }
    
    return self;
}

- (void)test {
    size_t charSize = sizeof(char);
    NSLog(@"charSize = %zu", charSize);
    
    size_t shortSize = sizeof(short);
    NSLog(@"shortSize = %zu", shortSize);
    
    size_t intSize = sizeof(int);
    NSLog(@"intSize = %zu", intSize);
    
    size_t floatSize = sizeof(float);
    NSLog(@"floatSize = %zu", floatSize);
    
    size_t doubleSize = sizeof(double);
    NSLog(@"doubleSize = %zu", doubleSize);
    
    __unused size_t alignedSize = word_align(9);
    NSLog(@"sizeOf Self = %ld", class_getInstanceSize(self.class));
    // 1. 没有定义任何属性的时候，是8
    // 2. OC对象的实例 size是8
    // 3. 字节按照8来对齐
}

/*
 size_t class_getInstanceSize(Class cls)
 {
 if (!cls) return 0;
 return cls->alignedInstanceSize();
 }
 
 // May be unaligned depending on class's ivars.
 uint32_t unalignedInstanceSize() {
 assert(isRealized());
 return data()->ro->instanceSize;
 }
 
 // Class's ivar size rounded up to a pointer-size boundary.
 uint32_t alignedInstanceSize() {
 return word_align(unalignedInstanceSize());
 }
 
 size_t instanceSize(size_t extraBytes) {
 size_t size = alignedInstanceSize() + extraBytes;
 // CF requires all objects be at least 16 bytes.
 if (size < 16) size = 16;
 return size;
 }
 */

@end
