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
    /*
     1. (x + 7) / 8 * 8 [取上整 * 8]
     2. ((x + 7) >> 3) << 3 // 7 == 0111
     3. 将(x + 7)的低三位置0
     p/d 输出10进制 p/x输出16进制 p/o输出8进制
     (lldb) p/x ~7
     (int) $7 = 0xfffffff8
     */
}

static inline size_t word_align10(size_t x) {
    /*
     1. (x + 9) / 10 * 10 [取上整 * 10]
     2. 9 == 1001 10 == 1010
     3. (lldb) p/x ~9
     (int) $4 = 0xfffffffa
     6 == 0110
     */
    return ((x + 9) / 10) * 10;
    //return (x + 9) & 0xfffffffa;// ???
}

struct HCLinkNode {
    struct HCLinkNode *pre;
    struct HCLinkNode *next;
    NSString *key;
    id value;
}; // 32

struct HCLinkedList {
    struct HCLinkNode head;
    struct HCLinkNode tail;
    int nodeCount;
}; // 72
/*
struct HCLinkedList {
    struct HCLinkNode *head;
    struct HCLinkNode *tail;
    int nodeCount;
}; // 24
*/
// 指针大小就是8字节，结构体内部也是一样；malloc的时候是16字节对齐；获取instanceSize对齐市8字节对齐，最少16
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
        //[self test];
        [self testAlign10Byte];
    }
    
    return self;
}

- (void)testAlign10Byte {
    for (NSInteger i = 1; i < 112; i++) {
        NSLog(@"%ld align with 10 byte is %ld", i, word_align10(i));
    }
}

- (void)test {
    NSObject *obj = [[NSObject alloc] init];
    uintptr_t disguiseValue = ~(uintptr_t)obj;
    __unused uintptr_t undisguiseValue = ~disguiseValue;
    
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
    // 1. 没有定义任何属性的时候，sizeof(self)、class_getInstanceSize(self.class)是8 malloc_size是16 [isa的大小是8 内部创建的时候判断小于16则会返回16] malloc出来是16字节对齐
    // 2. OC对象的指针 size是8字节
    // 3. 64bit字节按照8来对齐
    // 4. malloc的大小对于分配的空间小于256的时候内部是nano_malloc，字节对齐的规则是16的倍数
    self.a = 0xFFFFFF;
    /*
     汇编指令：
     sub x0, x1, x2 ===> 将x1和x2寄存器的值相减，存到x0中
     add x0, x1, x2 ===> 将x1和x2寄存器的值相加，存到x0中
     str x0, x1, x8 ===> 将寄存器x0的值保存到栈内存 x1+x8处
     ldr x0, x1, x2 ===> 将寄存器x1和x2的值相加作为地址，取该内存地址的值放入x0中
     */
    /*
     RuntimeLearning`-[ByteAlignmentTest setA:]:
     0x1040a71e4 <+0>:  sub    sp, sp, #0x20             ; =0x20
     0x1040a71e8 <+4>:  adrp   x8, 32
     0x1040a71ec <+8>:  add    x8, x8, #0x628            ; =0x628
     0x1040a71f0 <+12>: str    x0, [sp, #0x18]
     0x1040a71f4 <+16>: str    x1, [sp, #0x10]
     0x1040a71f8 <+20>: str    w2, [sp, #0xc]
     0x1040a71fc <+24>: ldr    w2, [sp, #0xc]
     0x1040a7200 <+28>: ldr    x0, [sp, #0x18]
     0x1040a7204 <+32>: ldrsw  x8, [x8]
     0x1040a7208 <+36>: add    x8, x0, x8
     0x1040a720c <+40>: str    w2, [x8]
     ->  0x1040a7210 <+44>: add    sp, sp, #0x20             ; =0x20
     0x1040a7214 <+48>: ret
     */
    self.b = 'd';
    self.c = 0xccc;
    self.testString = @"eeeeee";
    /*
     setTestString下断点，查看汇编代码
     bl跳转指令
     
     RuntimeLearning`-[ByteAlignmentTest setTestString:]:
     0x1040a7380 <+0>:  sub    sp, sp, #0x30             ; =0x30 (48)
     0x1040a7384 <+4>:  stp    x29, x30, [sp, #0x20]
     0x1040a7388 <+8>:  add    x29, sp, #0x20            ; =0x20 (36)
     0x1040a738c <+12>: adrp   x8, 32
     0x1040a7390 <+16>: add    x8, x8, #0x638            ; =0x638
     0x1040a7394 <+20>: stur   x0, [x29, #-0x8]
     0x1040a7398 <+24>: str    x1, [sp, #0x10]
     0x1040a739c <+28>: str    x2, [sp, #0x8]
     ->  0x1040a73a0 <+32>: ldr    x1, [sp, #0x10]
     0x1040a73a4 <+36>: ldur   x0, [x29, #-0x8]
     0x1040a73a8 <+40>: ldrsw  x3, [x8]
     0x1040a73ac <+44>: ldr    x8, [sp, #0x8]
     0x1040a73b0 <+48>: mov    x2, x8
     0x1040a73b4 <+52>: bl     0x1040ba0c0               ; symbol stub for: objc_setProperty_nonatomic_copy
     0x1040a73b8 <+56>: ldp    x29, x30, [sp, #0x20]
     0x1040a73bc <+60>: add    sp, sp, #0x30             ; =0x30
     0x1040a73c0 <+64>: ret
     
     // x0 self
     (lldb) register read x0
     x0 = 0x00000002832a19e0
     (lldb) p self
     (ByteAlignmentTest *) $0 = 0x00000002832a19e0
     // x1 cmd
     (lldb) register read x1
     x1 = 0x0000000100685169  "setTestString:"
     // x2 第一个参数
     (lldb) register read x2
     x2 = 0x0000000100689b48  @"eeeeee"
     (lldb) register read x8
     x8 = 0x000000010068f638  RuntimeLearning`ByteAlignmentTest._testString
     */
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
 // malloc的时候会用到instanceSize，最少是16
 size_t instanceSize(size_t extraBytes) {
 size_t size = alignedInstanceSize() + extraBytes;
 // CF requires all objects be at least 16 bytes.
 if (size < 16) size = 16;
 return size;
 }
 */

@end
