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

struct HCTestUnordered {
    int a;
    char b;
    short c;
    short d;
    NSString *testString;
};

struct HCTestOrderedASC {
    char b;
    short c;
    short d;
    int a;
    NSString *testString;
};

struct HCTestOrderedDESC {
    NSString *testString;
    int a;
    short c;
    short d;
    char b;
};

@interface HCTestObjUnordered : NSObject
{
    @public
    int a;
    char b;
    short c;
    NSString *testString;
    short d;
}
@end

@implementation HCTestObjUnordered

@end

@interface HCTestObjUnordered1 : NSObject

@property (nonatomic, assign) int a;
@property (nonatomic, assign) char b;
@property (nonatomic, assign) short c;
@property (nonatomic, copy) NSString *testString;
@property (nonatomic, assign) short d;

@end

@implementation HCTestObjUnordered1

@end

struct Student {
  bool sex;
  short int age;
  char *address;
  float grade;
  char  name[9];
};

struct StudentOrdered {
  bool sex;
  char  name[9];
  short int age;
  float grade;
  char *address;
};

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
        [self testAlign10Byte];
        [self testStructSize];
        [self testStructSize1];
    }
    
    return self;
}

- (void)testStructSize1 {
    NSLog(@"size of Student = %zd", sizeof(struct Student)); // 32
    NSLog(@"size of StudentOrdered = %zd", sizeof(struct StudentOrdered)); // 24
}

- (void)testStructSize {
    struct HCTestUnordered unordered = {};
    unordered.a = 0xFFFF;
    unordered.b = 'd'; // 0x64
    unordered.c = 0xcc;
    unordered.d = 0xdd;
    unordered.testString = @"testString";
    /*
    (lldb) p &unordered
    (HCTestUnordered *) $1 = 0x00007ffeebd40670
     FF FF 00 00 64 00 CC 00 DD 00 00 00 00 00 00 00 F0 21 F0 03 01 00 00
     */
    struct HCTestOrderedASC orderedASC = {};
    orderedASC.a = 0xFFFF;
    orderedASC.b = 'd';
    orderedASC.c = 0xcc;
    orderedASC.d = 0xdd;
    orderedASC.testString = @"testString";
    struct HCTestOrderedDESC orderedDESC = {};
    /*
     (lldb) p &orderedASC
     (HCTestOrderedASC *) $4 = 0x00007ffeebd40650
     64 00 CC 00 DD 00 00 00 FF FF 00 00 00 00 00 00 F0 21 F0 03 01 00 00 00
     */
    orderedDESC.a = 0xFFFF;
    orderedDESC.b = 'd';
    orderedDESC.c = 0xcc;
    orderedDESC.d = 0xdd;
    orderedDESC.testString = @"testString";
    /*
     (lldb) p &orderedDESC
     (HCTestOrderedDESC *) $5 = 0x00007ffeebd40630
     F0 21 F0 03 01 00 00 00 FF FF 00 00 CC 00 DD 00 64 00 00 00 00 00 00 00
     */
    HCTestObjUnordered *obj = [HCTestObjUnordered new];
    obj->a = 0xFFFF;
    obj->b = 'd';
    obj->c = 0xcc;
    obj->d = 0xdd;
    obj->testString = @"testString";
    /*
     (lldb) p obj
     (HCTestObjUnordered *) $1 = 0x00006000010b0460
     F8 BA 58 0D 01 00 00 00 FF FF 00 00 64 00 CC 00 F0 D1 57 0D 01 00 00 00 DD 00 00 00 00 00 00 00
     */
    HCTestObjUnordered1 *obj1 = [HCTestObjUnordered1 new];
    obj1.a = 0xFFFF;
    obj1.b = 'd';
    obj1.c = 0xcc;
    obj1.d = 0xdd;
    obj1.testString = @"testString";
    /*
     (lldb) p obj
     (HCTestObjUnordered *) $1 = 0x00006000010b0cc0
     48 BB 58 0D 01 00 00 00 64 00 CC 00 DD 00 00 00 FF FF 00 00 00 00 00 00 F0 D1 57 0D 01 00 00 00
     */
    /*
     对比OC的类直接定义变量无序的，跟声明属性无序的，发现最终在变量在内存布局上是不一样的，属性的话会按照类型的size升序排序
     */
    NSLog(@"size of HCTestUnordered = %zd", sizeof(unordered)); // 24
    NSLog(@"size of HCTestOrderedASC = %zd", sizeof(orderedASC)); // 24
    NSLog(@"size of HCTestOrderedDESC = %zd", sizeof(orderedDESC)); // 24
    NSLog(@"size of HCTestObjUnordered = %zd", class_getInstanceSize([HCTestObjUnordered class])); // 32 多了个isa
    NSLog(@"size of HCTestObjUnordered1 = %zd", class_getInstanceSize([HCTestObjUnordered1 class])); // 32
    /*
     一般情况下计算结构体尺寸大小有如下规则：

         结构体中每个数据成员的偏移位置是数据成员本身尺寸的倍数。
         结构体的尺寸是最大基础类型数据成员尺寸的倍数。
         如果有结构体嵌套时，被嵌套的结构体成员的偏移位置就是被嵌套结构体中尺寸最大的基础类型数据成员尺寸的倍数。嵌套结构体的尺寸则是所有被嵌套中的以及自身中的最大基础类型数据成员尺寸的倍数。
     */
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
    self.b = 'd'; // 0x64
    self.c = 0xccc;
    // 2020-11-27 memory write可以修改数据
    // 类的底层是结构体，编译器对类的变量的布局也做了优化会根据变量的size来从小到大排序，我们通过Debug - View Memory可以查看信息
    // 80 D5 9A 0B 01 00 00 00 64 00 CC 0C 00 00 00 00 FF FF FF 00 00 00 00 00
    self.testString = @"eeeeee"; // p self.testString  (__NSCFConstantString *) $6 = 0x000000010b99f310 @"eeeeee"
    // 80 D5 9A 0B 01 00 00 00 64 00 CC 0C 00 00 00 00 FF FF FF 00 00 00 00 00 10 F3 99 0B 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
