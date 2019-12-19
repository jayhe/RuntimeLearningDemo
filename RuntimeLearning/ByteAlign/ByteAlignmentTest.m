//
//  ByteAlignmentTest.m
//  RuntimeLearning
//
//  Created by 贺超 on 2019/11/5.
//  Copyright © 2019年 hechao. All rights reserved.
//

#import "ByteAlignmentTest.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

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

- (void)test;

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
    /*
     @property (nonatomic, assign) int a; // int 大小是4
     @property (nonatomic, assign) char b; // char 大小是1
     @property (nonatomic, assign) short c; // short 大小是2
     @property (nonatomic, assign) short d;
     @property (nonatomic, copy) NSString *testString; // 指针8字节
     @property (nonatomic, strong) ByteAlignmentTest *testObject; // 指针8字节
     
     NSLog(@"sizeOf self = %ld", sizeof(self)); // 8
     NSLog(@"class_getInstanceSize self = %ld", class_getInstanceSize(self.class)); // 40
     NSLog(@"malloc_size self = %ld", malloc_size((__bridge const void *)(self))); // 48
     */
    NSLog(@"sizeOf self = %ld", sizeof(self)); // 8
    NSLog(@"class_getInstanceSize self = %ld", class_getInstanceSize(self.class)); // 40 [对象本身8 + 4 + 1 + 2 + 2 + 8 + 8 再对齐]
    NSLog(@"malloc_size self = %ld", malloc_size((__bridge const void *)(self))); // 48
    // 1. 没有定义任何属性的时候，sizeof(self)、class_getInstanceSize(self.class)是8 malloc_size是16 [isa的大小是8 内部创建的时候判断小于16则会返回16]
    // 2. OC对象的指针 size是8字节
    // 3. 64bit字节按照8来对齐
    // 4. malloc的大小对于分配的空间小于256的时候内部是nano_malloc，字节对齐的规则是16的倍数
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
