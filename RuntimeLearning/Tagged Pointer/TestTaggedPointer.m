//
//  TestTaggedPointer.m
//  RuntimeLearning
//
//  Created by hechao on 2019/8/19.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestTaggedPointer.h"
#import <objc/runtime.h>

@implementation TestTaggedPointer

#if (TARGET_OS_OSX || TARGET_OS_IOSMAC) && __x86_64__
// 64-bit Mac - tag bit is LSB
#   define OBJC_MSB_TAGGED_POINTERS 0
#else
// Everything else - tag bit is MSB
#   define OBJC_MSB_TAGGED_POINTERS 1
#endif

#if OBJC_MSB_TAGGED_POINTERS
#   define _OBJC_TAG_MASK (1UL<<63)
#   define _OBJC_TAG_INDEX_SHIFT 60
#   define _OBJC_TAG_SLOT_SHIFT 60
#   define _OBJC_TAG_PAYLOAD_LSHIFT 4
#   define _OBJC_TAG_PAYLOAD_RSHIFT 4
#   define _OBJC_TAG_EXT_MASK (0xfUL<<60)
#   define _OBJC_TAG_EXT_INDEX_SHIFT 52
#   define _OBJC_TAG_EXT_SLOT_SHIFT 52
#   define _OBJC_TAG_EXT_PAYLOAD_LSHIFT 12
#   define _OBJC_TAG_EXT_PAYLOAD_RSHIFT 12
#else
#   define _OBJC_TAG_MASK 1UL
#   define _OBJC_TAG_INDEX_SHIFT 1
#   define _OBJC_TAG_SLOT_SHIFT 0
#   define _OBJC_TAG_PAYLOAD_LSHIFT 0
#   define _OBJC_TAG_PAYLOAD_RSHIFT 4
#   define _OBJC_TAG_EXT_MASK 0xfUL
#   define _OBJC_TAG_EXT_INDEX_SHIFT 4
#   define _OBJC_TAG_EXT_SLOT_SHIFT 4
#   define _OBJC_TAG_EXT_PAYLOAD_LSHIFT 0
#   define _OBJC_TAG_EXT_PAYLOAD_RSHIFT 12
#endif

static inline bool
_objc_isTaggedPointer(const void * _Nullable ptr)
{
    return ((uintptr_t)ptr & _OBJC_TAG_MASK) == _OBJC_TAG_MASK;
    //return ((uintptr_t)ptr & (1UL<<63)) == (1UL<<63); // 真机
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self stringTaggedPointerTest];
        //[self numberTest];
        //[self dateTest];
    }
    
    return self;
}

- (void)stringTaggedPointerTest {
    // https://mikeash.com/pyblog/friday-qa-2015-07-31-tagged-pointer-strings.html
    // http://www.cocoachina.com/articles/13449
    // 以下结果在真机下打印：
    NSString *gloablString = @"11111111111"; // __NSCFConstantString
    [self formatedLogObject:gloablString];
    NSString *stringWithFormat = [NSString stringWithFormat:@"%@", @"11111111111"];
    [self formatedLogObject:stringWithFormat];
    // 1111  输出： 0xa000000313131314 1111 NSTaggedPointerString 8bit编码
    // 11位1 输出：0xa7bdef7bdef7bdeb 11111111111 NSTaggedPointerString 5位编码
    // mac下：
    // 1.4位表示长度；最高4位是标记位【最高位是标记是否是TaggedPointer、另外3位标记类类型的index】
    // 2.a = 1011 最高位1标记是taggedPointer
    // 3.类型存储的是索引，会根据索引去查找类的映射关系
    NSString *stringWithString = [NSString stringWithString:@"2222"]; // __NSCFConstantString [warning: Replace '[NSString stringWithString:@"2222"]' with '@"2222"']
    [self formatedLogObject:stringWithFormat];
    NSMutableString *mutable = [NSMutableString string];
    NSString *immutable;
    Class stringClass;
    char c = 'y';
    do {
        [mutable appendFormat: @"%c", c];
        immutable = [mutable copy];
        stringClass = object_getClass(immutable);
        [self formatedLogObject:immutable];
        // 下个符号断点[NSTaggedPointerString length]，查看汇编
        /*
         mac下：
         CoreFoundation`-[NSTaggedPointerString length]:
             0x7fff23c4e220 <+0>:  movq   %rdi, %rax
             0x7fff23c4e223 <+3>:  movq   0x5c9c80f6(%rip), %rcx    ; (void *)0x00007fff89e07288: objc_debug_taggedpointer_obfuscator
             0x7fff23c4e22a <+10>: xorl   (%rcx), %eax
         ->  0x7fff23c4e22c <+12>: andl   $0xf, %eax
             0x7fff23c4e22f <+15>: retq
         执行前2次循环发现
         (lldb) register read eax
              eax = 0x00000001
         (lldb) register read eax
              eax = 0x00000002
         (lldb)
         */
        __unused NSInteger length = immutable.length;
        // 输出的结果有差异
        // y的ASCII对照表值就是79 http://ascii.911cha.com/
        // 0xa000000000000791 y NSTaggedPointerString
        // 0xa000000000079792 yy NSTaggedPointerString
        // 0xa000000007979793 yyy NSTaggedPointerString
        // 0xa000000797979794 yyyy NSTaggedPointerString
        // 0xa000079797979795 yyyyy NSTaggedPointerString
        // 0xa007979797979796 yyyyyy NSTaggedPointerString
        // 0xa797979797979797 yyyyyyy NSTaggedPointerString --- 至此都是使用ASCII编码（8bit） ---
        // 0xa009659659659658 yyyyyyyy NSTaggedPointerString
        // 0xa259659659659659 yyyyyyyyy NSTaggedPointerString
        // 0x14ce0dbf0 yyyyyyyyyy __NSCFString
        
        // 1. 最高位a 二进制 1011 最高位标记是否是tagged pointer
    }
    while(_objc_isTaggedPointer((__bridge const void * _Nullable)(immutable)));
//    while (stringClass == NSClassFromString(@"NSTaggedPointerString"));
    NSString *chineseStr = [NSString stringWithFormat:@"%@", @"我"];
    Class chineseStrClass = object_getClass(chineseStr);
    NSLog(@"chineseStr class = %@", chineseStrClass); // chineseStr class = __NSCFString
}

- (void)numberTest {
    NSNumber *aNumber = @(123);
    NSLog(@"aNumber retainCount = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aNumber)));
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:aNumber];
    [array addObject:aNumber];
    NSLog(@"aNumber retainCount after added to array = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(aNumber)));
    NSNumber *testNumber;
    //Class numberClass;
    NSInteger c = 1, offset = 1;
    do {
        testNumber = @((c<<offset) - 1);
        //numberClass = object_getClass(testNumber);
        [self formatedLogObject:testNumber];
        offset++;
        /*
          0xb000000000000013 1 __NSCFNumber
          0xb000000000000033 3 __NSCFNumber
          0xb000000000000073 7 __NSCFNumber
          0xb0000000000000f3 15 __NSCFNumber
          0xb0000000000001f3 31 __NSCFNumber
          0xb0000000000003f3 63 __NSCFNumber
          0xb0000000000007f3 127 __NSCFNumber
          0xb000000000000ff3 255 __NSCFNumber
          0xb000000000001ff3 511 __NSCFNumber
          0xb000000000003ff3 1023 __NSCFNumber
          0xb000000000007ff3 2047 __NSCFNumber
          0xb00000000000fff3 4095 __NSCFNumber
          0xb00000000001fff3 8191 __NSCFNumber
          0xb00000000003fff3 16383 __NSCFNumber
          0xb00000000007fff3 32767 __NSCFNumber
          0xb0000000000ffff3 65535 __NSCFNumber
          0xb0000000001ffff3 131071 __NSCFNumber
          0xb0000000003ffff3 262143 __NSCFNumber
          0xb0000000007ffff3 524287 __NSCFNumber
          0xb000000000fffff3 1048575 __NSCFNumber
          0xb000000001fffff3 2097151 __NSCFNumber
          0xb000000003fffff3 4194303 __NSCFNumber
          0xb000000007fffff3 8388607 __NSCFNumber
          0xb00000000ffffff3 16777215 __NSCFNumber
          0xb00000001ffffff3 33554431 __NSCFNumber
          0xb00000003ffffff3 67108863 __NSCFNumber
          0xb00000007ffffff3 134217727 __NSCFNumber
          0xb0000000fffffff3 268435455 __NSCFNumber
          0xb0000001fffffff3 536870911 __NSCFNumber
          0xb0000003fffffff3 1073741823 __NSCFNumber
          0xb0000007fffffff3 2147483647 __NSCFNumber
          0xb000000ffffffff3 4294967295 __NSCFNumber
          0xb000001ffffffff3 8589934591 __NSCFNumber
          0xb000003ffffffff3 17179869183 __NSCFNumber
          0xb000007ffffffff3 34359738367 __NSCFNumber
          0xb00000fffffffff3 68719476735 __NSCFNumber
          0xb00001fffffffff3 137438953471 __NSCFNumber
          0xb00003fffffffff3 274877906943 __NSCFNumber
          0xb00007fffffffff3 549755813887 __NSCFNumber
          0xb0000ffffffffff3 1099511627775 __NSCFNumber
          0xb0001ffffffffff3 2199023255551 __NSCFNumber
          0xb0003ffffffffff3 4398046511103 __NSCFNumber
          0xb0007ffffffffff3 8796093022207 __NSCFNumber
          0xb000fffffffffff3 17592186044415 __NSCFNumber
          0xb001fffffffffff3 35184372088831 __NSCFNumber
          0xb003fffffffffff3 70368744177663 __NSCFNumber
          0xb007fffffffffff3 140737488355327 __NSCFNumber
          0xb00ffffffffffff3 281474976710655 __NSCFNumber
          0xb01ffffffffffff3 562949953421311 __NSCFNumber
          0xb03ffffffffffff3 1125899906842623 __NSCFNumber
          0xb07ffffffffffff3 2251799813685247 __NSCFNumber
          0xb0fffffffffffff3 4503599627370495 __NSCFNumber
          0xb1fffffffffffff3 9007199254740991 __NSCFNumber
          0xb3fffffffffffff3 18014398509481983 __NSCFNumber
          0xb7fffffffffffff3 36028797018963967 __NSCFNumber
          0x14d50b1d0 72057594037927935 __NSCFNumber
         */
        
        
        /*
         + (NSNumber *) numberWithInt: (int)aValue
         {
         NSIntNumber *n;
         
         if (self != NSNumberClass)
         {
         return [[[self alloc] initWithBytes: (const void *)&aValue
         objCType: @encode(int)] autorelease];
         }
         
         CHECK_SINGLETON (aValue);
         #ifdef OBJC_SMALL_OBJECT_SHIFT
         if (useSmallInt &&
         (aValue < (INT_MAX>>OBJC_SMALL_OBJECT_SHIFT)) &&
         (aValue > -(INT_MAX>>OBJC_SMALL_OBJECT_SHIFT)))
         {
         return (id)((aValue << OBJC_SMALL_OBJECT_SHIFT) | SMALL_INT_MASK);
         }
         #endif
         n = NSAllocateObject (NSIntNumberClass, 0, 0);
         n->value = aValue;
         return AUTORELEASE(n);
         }
         */
        // 1. __NSCFNumber : 当值在指针可以表示的最大范围的时候指针本来就存储了值
        // 2. 内存管理跟taggedPointer
    }
    while(_objc_isTaggedPointer((__bridge const void * _Nullable)(testNumber)));
}

- (void)dateTest {
    for (NSInteger i = 0; i < 100; i ++) {
        NSDate *date = [NSDate date];
        [self formatedLogObject:date];
        // 0xe41c1b9566170df5 2019-11-06 07:24:50 +0000 __NSTaggedDate
        // 0x15ce04c10 2019-11-06 07:41:44 +0000 __NSDate
        // 1. 循环100次是调试发现·date·有时候是__NSTaggedDate有时候又是__NSDate
        // 2. 有概率实例化出来的是taggedPointer
        BOOL isTaggedPointer = _objc_isTaggedPointer((__bridge const void * _Nullable)(date)); // YES
        if (isTaggedPointer) {
            NSLog(@"date retainCount = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(date))); // 64bit 打印为9223372036854775807
        }
        /*
         inline uintptr_t
         objc_object::rootRetainCount()
         {
         if (isTaggedPointer()) return (uintptr_t)this;
         
         sidetable_lock();
         isa_t bits = LoadExclusive(&isa.bits);
         ClearExclusive(&isa.bits);
         if (bits.nonpointer) {
         uintptr_t rc = 1 + bits.extra_rc;
         if (bits.has_sidetable_rc) {
         rc += sidetable_getExtraRC_nolock();
         }
         sidetable_unlock();
         return rc;
         }
         
         sidetable_unlock();
         return sidetable_retainCount();
         }
         */
    }
    NSDate *today = [NSDate date];
    NSLog(@"today retainCount = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(today)));
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:today];
    [array addObject:today];
    NSLog(@"today retainCount after added to array = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(today)));
}

#pragma mark - Private Method

- (void)formatedLogObject:(id)object {
    NSLog(@"0x%6lx %@ %@", object, object, object_getClass(object));
}

@end
