//
//  BlockUsage.m
//  RuntimeLearning
//
//  Created by 贺超 on 2021/3/16.
//  Copyright © 2021 hechao. All rights reserved.
//

#import "BlockUsage.h"
#import "YYWeakProxy.h"
#import "fishhook.h"
#import <Block.h>
/*
 xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fblocks -mios-version-min=9.0.0 -fobjc-runtime=ios-9.0.0 -I ../../Pods/Headers/Public/fishhook/ BlockUsage.m
 */
@interface BlockUsage ()

@property (nonatomic, strong) NSArray *aArray;
@property (nonatomic, copy) void(^testRetainCycleBlock)(void);
@property (nonatomic, copy) void(^testBlockTypeBlock)(void);
@property (nonatomic, copy) void(^testBreakRetainCycleBlockByPassParam)(BlockUsage *paramSelf);
@property (nonatomic, copy) void(^testBreakRetainCycleBlockBySetNil)(void);
@property (nonatomic, copy) void(^testBreakRetainCycleBlockByWeak)(void);
@property (nonatomic, copy) void(^testBreakRetainCycleBlockByNSProxy)(void);
@property (nonatomic, copy) void(^testBreakRetainCycleBlockByHook)(void);
@property (nonatomic, strong) dispatch_source_t source;

@end

@implementation BlockUsage

+ (void)load {
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
         //NSObject *object = [NSObject new];
         //_Block_object_assign((void*)&object, (__bridge void*)object, 3); // 0x0000000192310bd8
         struct rebinding rebindingBlock;
         rebindingBlock.name = "_Block_object_assign";
         rebindingBlock.replacement = (void *)mine_Block_object_assign;
         rebindingBlock.replaced = (void **)(&system_Block_object_assign);
         rebind_symbols(&rebindingBlock, 1);
         //_Block_object_assign((void*)&object, (__bridge void*)object, 3);
     });
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)excuteTestCase {
//    [self testCaptureValuable];// 截获变量
//    [self testCaptureValuable1];
//    [self testCaptureValuable2];
//    [self test__blockUsage];//__block修饰符
//    [self testBlockRetainCycle];
//    [self testBreakRetainCycleByPassParam];
//    [self testBreakRetainCycleBySetNil];
//    [self testBlockTypes];
//    [self testNOESACPE];
//    [self blockUseWeakWeak];
//    [self blockUseWeakStrong];
//    [self stackBlockExcuteDelay];
    [self testHookToBreakRetainCycle];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _aArray = [NSArray array];
        int i = 0;
        void(^ aBlock)(void) = ^(void) {
            i;
            NSLog(@"111");
        };
        if (aBlock) {
            aBlock();
        }
        /*
         (lldb) po [__NSStackBlock _methodDescription]
         <__NSStackBlock: 0x7fff87c53428>:
         in __NSStackBlock:
             Instance Methods:
                 - (id) retain; (0x7fff23ccbd20)
                 - (oneway void) release; (0x7fff23ccbd30)
                 - (id) autorelease; (0x7fff23ccbd50)
                 - (unsigned long) retainCount; (0x7fff23ccbd40)
         in NSBlock:
             Class Methods:
                 + (id) alloc; (0x7fff23ccba60)
                 + (id) allocWithZone:(struct _NSZone*)arg1; (0x7fff23ccba40)
             Instance Methods:
                 - (id) debugDescription; (0x7fff23ccbb40)
                 - (id) copy; (0x7fff23ccba80)
                 - (id) copyWithZone:(struct _NSZone*)arg1; (0x7fff23ccba90)
                 - (void) invoke; (0x7fff23ccbaa0)
                 - (void) performAfterDelay:(double)arg1; (0x7fff23ccbab0)
         */
    }
    
    return self;
}

static NSString *testGlobalStaticString = @"testGlobalStaticString";
const NSString *testGlobalConstString = @"testGlobalConstString";
NSInteger globalNumber = 11;

- (void)testCaptureValuable {
    int i = 2;//局部非oc对象
    NSNumber *num = @3;//局部oc对象
    static NSString *testStaticString = @"testStaticString";
    const NSString *testConstString = @"testConstString";
    __block NSInteger blockInt = 1;
    __weak BlockUsage *weakSelf = self;
    
    long (^myBlock)(void) = ^long() {
        blockInt = 2;
        NSLog(@"%@\n%@\n%@\n%@\n%ld", testStaticString, testConstString, testGlobalStaticString, testGlobalConstString, blockInt);
        NSLog(@"%@", self.aArray);
        NSLog(@"%@", weakSelf.aArray);
        return i * num.intValue + globalNumber;
    };
    
    i = 3;
    testStaticString = @"testChangeStaticString";
    globalNumber = 12;
    __unused long r = myBlock();
    // clang rewrite
    /*
     // block修饰的变量
     struct __Block_byref_blockInt_0 {
     void *__isa;
     __Block_byref_blockInt_0 *__forwarding;
     int __flags;
     int __size;
     NSInteger blockInt;
     };
     
     // block结构体内部结构
     struct __BlockTest__testCaptureValuable_block_impl_0 {
     struct __block_impl impl;
     struct __BlockTest__testCaptureValuable_block_desc_0* Desc;
     NSString *__strong *testStaticString;
     const NSString *__strong testConstString;
     BlockTest *const __strong self;
     BlockTest *__weak weakSelf;
     int i;
     NSNumber *__strong num;
     __Block_byref_blockInt_0 *blockInt; // by ref
     __BlockTest__testCaptureValuable_block_impl_0(void *fp, struct __BlockTest__testCaptureValuable_block_desc_0 *desc, NSString *__strong *_testStaticString, const NSString *__strong _testConstString, BlockTest *const __strong _self, BlockTest *__weak _weakSelf, int _i, NSNumber *__strong _num, __Block_byref_blockInt_0 *_blockInt, int flags=0) : testStaticString(_testStaticString), testConstString(_testConstString), self(_self), weakSelf(_weakSelf), i(_i), num(_num), blockInt(_blockInt->__forwarding) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
     
     // block的函数实现
     static long __BlockTest__testCaptureValuable_block_func_0(struct __BlockTest__testCaptureValuable_block_impl_0 *__cself) {
     __Block_byref_blockInt_0 *blockInt = __cself->blockInt; // bound by ref
     NSString *__strong *testStaticString = __cself->testStaticString; // bound by copy
     const NSString *__strong testConstString = __cself->testConstString; // bound by copy
     BlockTest *const __strong self = __cself->self; // bound by copy
     BlockTest *__weak weakSelf = __cself->weakSelf; // bound by copy
     int i = __cself->i; // bound by copy
     NSNumber *__strong num = __cself->num; // bound by copy
     
     (blockInt->__forwarding->blockInt) = 2; // blockInt的forwarding是指向了自己，原对象的forwarding也会指向“自己”，达到堆和栈上使用的都是堆上的
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_4, (*testStaticString), testConstString, testGlobalStaticString, testGlobalConstString, (blockInt->__forwarding->blockInt));
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_5, ((NSArray *(*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("aArray")));
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_6, ((NSArray *(*)(id, SEL))(void *)objc_msgSend)((id)weakSelf, sel_registerName("aArray")));
     return i * ((int (*)(id, SEL))(void *)objc_msgSend)((id)num, sel_registerName("intValue")) + globalNumber;
     }
     
     // 转换后的函数
     static void _I_BlockTest_testCaptureValuable(BlockTest * self, SEL _cmd) {
     int i = 2;
     NSNumber *num = ((NSNumber *(*)(Class, SEL, int))(void *)objc_msgSend)(objc_getClass("NSNumber"), sel_registerName("numberWithInt:"), 3);
     static NSString *testStaticString = (NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_2;
     const NSString *testConstString = (NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_3;
     __attribute__((__blocks__(byref))) __Block_byref_blockInt_0 blockInt = {(void*)0,(__Block_byref_blockInt_0 *)&blockInt, 0, sizeof(__Block_byref_blockInt_0), 1};
     __attribute__((objc_ownership(weak))) BlockTest *weakSelf = self;
     
     long (*myBlock)(void) = ((long (*)())&__BlockTest__testCaptureValuable_block_impl_0((void *)__BlockTest__testCaptureValuable_block_func_0, &__BlockTest__testCaptureValuable_block_desc_0_DATA, &testStaticString, testConstString, self, weakSelf, i, num, (__Block_byref_blockInt_0 *)&blockInt, 570425344));
     
     i = 3;
     testStaticString = (NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_7;
     globalNumber = 12;
     __attribute__((unused)) long r = ((long (*)(__block_impl *))((__block_impl *)myBlock)->FuncPtr)((__block_impl *)myBlock);
     }
     
     */
    
}

- (void)testCaptureValuable1 {
    int num = arc4random() % 100;
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate];
    void(^testBlock)(void) = ^(void) {
        NSLog(@"num = %d", num);
        //num++; // 编译器不允许block内部对值拷贝的对象进行修改【比如修改指针指向、或者修改值】，主要是有代码歧义
        NSLog(@"timeInterval = %f", timeInterval);
    };
    testBlock();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        testBlock();
    });
}

- (void)testCaptureValuable2 {
    __block NSNumber *aNSNumber = @(11);
    __block NSObject *aObj = [NSObject new];
    void(^testBlock0)(void) = ^(void) {
        NSLog(@"num = %@, %p", aNSNumber, aNSNumber);
        NSLog(@"obj = %@, %p", aObj, aObj);
    };
    
    void(^testBlock1)(void) = ^(void) {
        NSLog(@"num = %@, %p", aNSNumber, aNSNumber);
        NSLog(@"obj = %@, %p", aObj, aObj);
    };
    
    testBlock0();
    testBlock1();
}

- (void)test__blockUsage {
#define USEBLOCK 0
#if USEBLOCK
    __block NSMutableArray *array = [NSMutableArray array];
    NSLog(@"1:%p", &array);
    void(^block)(void) = ^{
        NSLog(@"3:%p", &array);
        [array addObject: @"5"];
        [array addObject: @"5"];
        NSLog(@"%@",array);
    };
    array = [NSMutableArray array];
    NSLog(@"2:%p", &array);
    block();
    NSLog(@"%@",array);
#else
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"1:%p", &array);
    NSLog(@"1:refCoount = %ld", CFGetRetainCount((__bridge CFTypeRef)(array)));
    void(^block)(void) = ^{
        NSLog(@"3:%p", &array);
        NSLog(@"3:refCoount = %ld", CFGetRetainCount((__bridge CFTypeRef)(array)));
        [array addObject: @"5"];
        [array addObject: @"5"];
        NSLog(@"%@",array);
    };
    array = nil;
    NSLog(@"2:%p", &array);
    //    NSLog(@"2:refCoount = %ld", CFGetRetainCount((__bridge CFTypeRef)(array)));
    block();
    NSLog(@"%@",array);
#endif
    
    /**1.不使用__block修饰**/
    /* 输出 */
    /*
     2019-03-06 17:18:43.850993+0800 ClangLearningDemo[69048:1293929] 1:0x7ffee5a97f18
     2019-03-06 17:18:43.851069+0800 ClangLearningDemo[69048:1293929] 2:0x7ffee5a97f18
     2019-03-06 17:18:43.851124+0800 ClangLearningDemo[69048:1293929] 3:0x600002cec020
     */
    // Block不允许修改外部变量的值。Apple这样设计，应该是考虑到了block的特殊性，block也属于“函数”的范畴，变量进入block，实际就是已经改变了作用域。在几个作用域之间进行切换时，如果不加上这样的限制，变量的可维护性将大大降低！    如果想要在block内部修改局部变量的值，那么就需要使用__block修饰符告诉编译器
    // void _Block_object_assign(void *destArg, const void *object, const int flags) -- 会传入指针、对象和策略
    /* clang rewrite */
    /*
     struct __BlockTest__test__blockUsage_block_impl_0 {
     struct __block_impl impl;
     struct __BlockTest__test__blockUsage_block_desc_0* Desc;
     NSMutableArray *__strong array;
     __BlockTest__test__blockUsage_block_impl_0(void *fp, struct __BlockTest__test__blockUsage_block_desc_0 *desc, NSMutableArray *__strong _array, int flags=0) : array(_array) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
     static void __BlockTest__test__blockUsage_block_func_0(struct __BlockTest__test__blockUsage_block_impl_0 *__cself) {
     NSMutableArray *__strong array = __cself->array; // bound by copy
     
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_9, &array);
     ((void (*)(id, SEL, ObjectType  _Nonnull __strong))(void *)objc_msgSend)((id)array, sel_registerName("addObject:"), (id _Nonnull)(NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_10);
     ((void (*)(id, SEL, ObjectType  _Nonnull __strong))(void *)objc_msgSend)((id)array, sel_registerName("addObject:"), (id _Nonnull)(NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_11);
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_972a08_mi_12,array);
     }
     */
    
    
    
    /**2.使用__block修饰**/
    /* 输出 */
    /*
     2019-03-06 17:35:52.950918+0800 ClangLearningDemo[69373:1306013] 1:0x7ffee67f5f08
     2019-03-06 17:35:52.950990+0800 ClangLearningDemo[69373:1306013] 2:0x60000368a2a8
     2019-03-06 17:35:52.951041+0800 ClangLearningDemo[69373:1306013] 3:0x60000368a2a8
     */
    
    /* clang rewrite */
    /*
     // 多了一个__Block_byref的结构体
     struct __Block_byref_array_1 {
     void *__isa;
     __Block_byref_array_1 *__forwarding;
     int __flags;
     int __size;
     void (*__Block_byref_id_object_copy)(void*, void*);
     void (*__Block_byref_id_object_dispose)(void*);
     NSMutableArray *__strong array;
     };
     
     // Block内部对array是一个结构体类型了
     struct __BlockTest__test__blockUsage_block_impl_0 {
     struct __block_impl impl;
     struct __BlockTest__test__blockUsage_block_desc_0* Desc;
     __Block_byref_array_1 *array; // by ref
     __BlockTest__test__blockUsage_block_impl_0(void *fp, struct __BlockTest__test__blockUsage_block_desc_0 *desc, __Block_byref_array_1 *_array, int flags=0) : array(_array->__forwarding) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
     
     // Block内部访问array是通过（array->__forwarding->array）；堆上的__forwarding指向的是自己
     static void __BlockTest__test__blockUsage_block_func_0(struct __BlockTest__test__blockUsage_block_impl_0 *__cself) {
     __Block_byref_array_1 *array = __cself->array; // bound by ref
     
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_90f226_mi_9, &(array->__forwarding->array));
     ((void (*)(id, SEL, ObjectType  _Nonnull __strong))(void *)objc_msgSend)((id)(array->__forwarding->array), sel_registerName("addObject:"), (id _Nonnull)(NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_90f226_mi_10);
     ((void (*)(id, SEL, ObjectType  _Nonnull __strong))(void *)objc_msgSend)((id)(array->__forwarding->array), sel_registerName("addObject:"), (id _Nonnull)(NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_90f226_mi_11);
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_90f226_mi_12,(array->__forwarding->array));
     }
     
     // 转化后的函数，__block申明后，数据已经被转为了结构体
     static void _I_BlockTest_test__blockUsage(BlockTest * self, SEL _cmd) {
     __attribute__((__blocks__(byref))) __Block_byref_array_1 array = {(void*)0,(__Block_byref_array_1 *)&array, 33554432, sizeof(__Block_byref_array_1), __Block_byref_id_object_copy_131, __Block_byref_id_object_dispose_131, ((NSMutableArray * _Nonnull (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSMutableArray"), sel_registerName("array"))};
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_90f226_mi_8, &(array.__forwarding->array));
     void(*block)(void) = ((void (*)())&__BlockTest__test__blockUsage_block_impl_0((void *)__BlockTest__test__blockUsage_block_func_0, &__BlockTest__test__blockUsage_block_desc_0_DATA, (__Block_byref_array_1 *)&array, 570425344));
     (array.__forwarding->array) = ((NSMutableArray * _Nonnull (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSMutableArray"), sel_registerName("array"));
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_90f226_mi_13, &(array.__forwarding->array));
     ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_90f226_mi_14,(array.__forwarding->array));
     }
     */
    
    
    // oc 源码
    /*
     // 查看_Block_object_assign
     // BLOCK_FIELD_IS_BYREF
     {
     // src points to stack
     struct Block_byref *copy = (struct Block_byref *)malloc(src->size);
     copy->isa = NULL;
     // byref value 4 is logical refcount of 2: one for caller, one for stack
     copy->flags = src->flags | BLOCK_BYREF_NEEDS_FREE | 4;
     copy->forwarding = copy; // patch heap copy to point to itself
     src->forwarding = copy;  // patch stack to point to heap copy
     copy->size = src->size;
     }
     */
}

- (void)testBlockRetainCycle1 {
    // blockp捕获值是嵌套传递的，先是testRetainCycleBlock持有再传递给gcd的
    self.testRetainCycleBlock = ^(void){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"self = %@", self);
        });
    };
    self.testRetainCycleBlock();
    /*
     static void __BlockTest__testBlockRetainCycle1_block_func_1(struct __BlockTest__testBlockRetainCycle1_block_impl_1 *__cself) {
     BlockTest *const __strong self = __cself->self; // bound by copy

           dispatch_after(dispatch_time((0ull), (int64_t)(1 * 1000000000ull)), dispatch_get_main_queue(), ((void (*)())&__BlockTest__testBlockRetainCycle1_block_impl_0((void *)__BlockTest__testBlockRetainCycle1_block_func_0, &__BlockTest__testBlockRetainCycle1_block_desc_0_DATA, self, 570425344)));
       }
     */
}

- (void)testDispatchSourceTimerRetainCycle {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_source, DISPATCH_TIME_NOW, 1.7 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_source, ^{
        // block --> self --> source --> block
        NSLog(@"self = %@", self);
    });
    dispatch_resume(_source);
    /*
     struct __BlockTest__testDispatchSourceTimerRetainCycle_block_impl_0 {
       struct __block_impl impl;
       struct __BlockTest__testDispatchSourceTimerRetainCycle_block_desc_0* Desc;
       BlockTest *const __strong self;
       __BlockTest__testDispatchSourceTimerRetainCycle_block_impl_0(void *fp, struct __BlockTest__testDispatchSourceTimerRetainCycle_block_desc_0 *desc, BlockTest *const __strong _self, int flags=0) : self(_self) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     static void __BlockTest__testDispatchSourceTimerRetainCycle_block_func_0(struct __BlockTest__testDispatchSourceTimerRetainCycle_block_impl_0 *__cself) {
       BlockTest *const __strong self = __cself->self; // bound by copy

             NSLog((NSString *)&__NSConstantStringImpl__var_folders_r0_4tb84bbj15j3kbzrnk8hqdwm0000gn_T_BlockTest_5a4e95_mi_24, self);
         }
     
     
     static void _I_BlockTest_testDispatchSourceTimerRetainCycle(BlockTest * self, SEL _cmd) {
         dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
         (*(NSObject **)((char *)self + OBJC_IVAR_$_BlockTest$_source)) = dispatch_source_create((&_dispatch_source_type_timer), 0, 0, queue);
         dispatch_source_set_timer((*(NSObject **)((char *)self + OBJC_IVAR_$_BlockTest$_source)), (0ull), 1.7 * 1000000000ull, 0.1 * 1000000000ull);
         __attribute__((objc_ownership(weak))) typeof(self) weakSelf = self;
         dispatch_source_set_event_handler((*(NSObject **)((char *)self + OBJC_IVAR_$_BlockTest$_source)), ((void (*)())&__BlockTest__testDispatchSourceTimerRetainCycle_block_impl_0((void *)__BlockTest__testDispatchSourceTimerRetainCycle_block_func_0, &__BlockTest__testDispatchSourceTimerRetainCycle_block_desc_0_DATA, self, 570425344)));
         dispatch_resume((*(NSObject **)((char *)self + OBJC_IVAR_$_BlockTest$_source)));
     }
     */
}

- (void)testBlockRetainCycle {
    __weak typeof(self) weakSelf = self;
    typeof(weakSelf) tmp = weakSelf;
    self.testRetainCycleBlock = ^(void){
        NSLog(@"%@", self);
        NSLog(@"%@", tmp); // 这里也会有循环引用
        self.testRetainCycleBlock = nil;//在适当的时机打破环，避免循环引用；或者使用weak引用（建议）
    };
    self.testRetainCycleBlock();
    /****/
    /* clang rewrite */
    /*
     struct __BlockTest__testBlockRetainCycle_block_impl_0 {
     struct __block_impl impl;
     struct __BlockTest__testBlockRetainCycle_block_desc_0* Desc;
     BlockTest *const __strong self;
     __BlockTest__testBlockRetainCycle_block_impl_0(void *fp, struct __BlockTest__testBlockRetainCycle_block_desc_0 *desc, BlockTest *const __strong _self, int flags=0) : self(_self) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
     
     static void __BlockTest__testBlockRetainCycle_block_func_0(struct __BlockTest__testBlockRetainCycle_block_impl_0 *__cself) {
     BlockTest *const __strong self = __cself->self; // bound by copy
     
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_cf9eab_mi_15, self);
     }
     
     static void _I_BlockTest_testBlockRetainCycle(BlockTest * self, SEL _cmd) {
     ((void (*)(id, SEL, void (*)()))(void *)objc_msgSend)((id)self, sel_registerName("setTestRetainCycleBlock:"), ((void (*)())&__BlockTest__testBlockRetainCycle_block_impl_0((void *)__BlockTest__testBlockRetainCycle_block_func_0, &__BlockTest__testBlockRetainCycle_block_desc_0_DATA, self, 570425344)));
     }
     */
}

- (void)testBreakRetainCycleByPassParam {
    self.testBreakRetainCycleBlockByPassParam = ^(BlockUsage *paramSelf) {
        NSLog(@"testBreakRetainCycle:%@", paramSelf);
    };
    /*
    (lldb) po $arg2
    <__NSGlobalBlock__: 0x102680298>
     signature: "v16@?0@"BlockTest"8"
     invoke   : 0x10267c260 (/Users/hechao/Library/Developer/CoreSimulator/Devices/9BD675A0-4A47-46F6-8E35-3512CF8F88BA/data/Containers/Bundle/Application/8080B86F-0FDC-4F84-9321-C7F998D921CB/ClangLearningDemo.app/ClangLearningDemo`__44-[BlockTest testBreakRetainCycleByPassParam]_block_invoke)

    (lldb)
     */
    self.testBreakRetainCycleBlockByPassParam(self);
    /*
     struct __BlockTest__testBreakRetainCycleByPassParam_block_impl_0 {
     struct __block_impl impl;
     struct __BlockTest__testBreakRetainCycleByPassParam_block_desc_0* Desc;
     __BlockTest__testBreakRetainCycleByPassParam_block_impl_0(void *fp, struct __BlockTest__testBreakRetainCycleByPassParam_block_desc_0 *desc, int flags=0) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
     static void __BlockTest__testBreakRetainCycleByPassParam_block_func_0(struct __BlockTest__testBreakRetainCycleByPassParam_block_impl_0 *__cself, BlockTest *__strong paramSelf) {
     
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_04791f_mi_24, paramSelf);
     }
     
     static struct __BlockTest__testBreakRetainCycleByPassParam_block_desc_0 {
     size_t reserved;
     size_t Block_size;
     } __BlockTest__testBreakRetainCycleByPassParam_block_desc_0_DATA = { 0, sizeof(struct __BlockTest__testBreakRetainCycleByPassParam_block_impl_0)};
     
     这种传参的方式，不会有循环引用问题：由于传参的方式，block内部不会去捕获持有这个参数
     */
}

- (void)testBreakRetainCycleBySetNil {
    NSLog(@"testBreakRetainCycleBySetNil:self.retainCount before tmp refrence = %ld", CFGetRetainCount((__bridge CFTypeRef)(self))); // 1
    __block BlockUsage *strongSelf = self;
    NSLog(@"testBreakRetainCycleBySetNil:self.retainCount after tmp refrence = %ld", CFGetRetainCount((__bridge CFTypeRef)(self))); // 2
    self.testBreakRetainCycleBlockBySetNil = ^(void) {
        NSLog(@"testBreakRetainCycle:%@", strongSelf);
        strongSelf = nil;
    };
    self.testBreakRetainCycleBlockBySetNil();
    NSLog(@"testBreakRetainCycleBySetNil:self.retainCount after set nil = %ld", CFGetRetainCount((__bridge CFTypeRef)(self))); // 1
    /*
     struct __Block_byref_strongSelf_3 {
     void *__isa;
     __Block_byref_strongSelf_3 *__forwarding;
     int __flags;
     int __size;
     void (*__Block_byref_id_object_copy)(void*, void*);
     void (*__Block_byref_id_object_dispose)(void*);
     BlockTest *__strong strongSelf;
     };

     
     struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0 {
     struct __block_impl impl;
     struct __BlockTest__testBreakRetainCycleBySetNil_block_desc_0* Desc;
     __Block_byref_strongSelf_3 *strongSelf; // by ref
     __BlockTest__testBreakRetainCycleBySetNil_block_impl_0(void *fp, struct __BlockTest__testBreakRetainCycleBySetNil_block_desc_0 *desc, __Block_byref_strongSelf_3 *_strongSelf, int flags=0) : strongSelf(_strongSelf->__forwarding) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
     static void __BlockTest__testBreakRetainCycleBySetNil_block_func_0(struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0 *__cself) {
     __Block_byref_strongSelf_3 *strongSelf = __cself->strongSelf; // bound by ref
     
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_8j_551wkz1d1rg878kt8mg21tg40000gn_T_BlockTest_04791f_mi_25, (strongSelf->__forwarding->strongSelf));
     (strongSelf->__forwarding->strongSelf) = __null;
     }
     static void __BlockTest__testBreakRetainCycleBySetNil_block_copy_0(struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0*dst, struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0*src) {_Block_object_assign((void*)&dst->strongSelf, (void*)src->strongSelf, );}
     
     static void __BlockTest__testBreakRetainCycleBySetNil_block_dispose_0(struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0*src) {_Block_object_dispose((void*)src->strongSelf,);}
     
     static struct __BlockTest__testBreakRetainCycleBySetNil_block_desc_0 {
     size_t reserved;
     size_t Block_size;
     void (*copy)(struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0*, struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0*);
     void (*dispose)(struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0*);
     } __BlockTest__testBreakRetainCycleBySetNil_block_desc_0_DATA = { 0, sizeof(struct __BlockTest__testBreakRetainCycleBySetNil_block_impl_0), __BlockTest__testBreakRetainCycleBySetNil_block_copy_0, __BlockTest__testBreakRetainCycleBySetNil_block_dispose_0};
     
     static void _I_BlockTest_testBreakRetainCycleBySetNil(BlockTest * self, SEL _cmd) {
     __attribute__((__blocks__(byref))) __Block_byref_strongSelf_3 strongSelf = {(void*)0,(__Block_byref_strongSelf_3 *)&strongSelf, 33554432, sizeof(__Block_byref_strongSelf_3), __Block_byref_id_object_copy_131, __Block_byref_id_object_dispose_131, self};
     ((void (*)(id, SEL, void (*)()))(void *)objc_msgSend)((id)self, sel_registerName("setTestBreakRetainCycleBlockBySetNil:"), ((void (*)())&__BlockTest__testBreakRetainCycleBySetNil_block_impl_0((void *)__BlockTest__testBreakRetainCycleBySetNil_block_func_0, &__BlockTest__testBreakRetainCycleBySetNil_block_desc_0_DATA, (__Block_byref_strongSelf_3 *)&strongSelf, 570425344)));
     ((void (*(*)(id, SEL))())(void *)objc_msgSend)((id)self, sel_registerName("testBreakRetainCycleBlockBySetNil"))();
     }
     
     这种方式可以解决循环引用：由于定义了block类型的局部变量，会转换成结构体(结构体内部强持有了self)，block函数内部结构体中引用这个结构体，当将block类型的局部变量置为nil之后，强持有关系就被打断了
     */
}

- (void)testBreakRetainCycleByWeak {
    __weak typeof(self) weakSelf = self;
    self.testBreakRetainCycleBlockByWeak = ^(void) {
        __strong typeof(self) strongSelf = weakSelf; // 涉及到多线程异步操作，最好加上一个强引用，这样保证下面的任务可以被执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", strongSelf); // 执行该段代码之后，临时变量strongSelf就释放了，self就能正常的dealloc
        });
    };
    self.testBlockTypeBlock();
}

- (void)testBreakRetainCycleByNSProxy {
    YYWeakProxy *proxy = [YYWeakProxy proxyWithTarget:self];
    self.testBreakRetainCycleBlockByNSProxy = ^(void) {
        [proxy performSelector:@selector(doSthInBlock)];
    };
    self.testBreakRetainCycleBlockByNSProxy();
}

- (void)doSthInBlock {
    
}

#pragma mark - 尝试hook的方式来解决循环引用

static void (*system_Block_object_assign)(void *destAddr, const void *object, const int flags);

- (void)testHookToBreakRetainCycle {
    self.testBreakRetainCycleBlockByHook = ^(void) {
        NSLog(@"%s %@", __FUNCTION__, self);
    };
    self.testBreakRetainCycleBlockByHook();
}

void mine_Block_object_assign(void *destAddr, const void *object, const int flags) {
    NSObject *obj = (__bridge NSObject *)(object);
    system_Block_object_assign(destAddr, (__bridge const void *)([YYWeakProxy proxyWithTarget:obj]), flags);
}

#pragma mark - Block类型

typedef void (^ReturnBlock)(void);

ReturnBlock returnBlockFunction(ReturnBlock block) {
    return block;
}

- (void)testBlockTypes {
    // 0x1 全局区
    // 0x6 堆区
    // 0x7 栈区
    void(^globalBlock)(void) = ^(void) {
        NSLog(@"xxx");
        //NSLog(@"%@", testGlobalConstString);
        //NSLog(@"%@", testGlobalStaticString);
        //NSLog(@"%ld", globalNumber);
    };
    globalBlock();
    _testBlockTypeBlock = [globalBlock copy];
    int i = 9;
    void(^mallocBlock)(void) = ^(void) {
        NSLog(@"xxx %d", i);
    };
    NSLog(@"stack block:%@", ^(void) {
        NSLog(@"xxx %d", i);
    });
    mallocBlock();
    _testBlockTypeBlock = [mallocBlock copy];
    
    int j = 10;
    void(__weak ^weakBlock)(void) = ^(void) {
        NSLog(@"xxx %d", j);
        //NSLog(@"xxx %@", self);
    }; // stack
    weakBlock();
    [self getInfo:weakBlock];
    returnBlockFunction(^{
        NSLog(@"xxx %d", j);
    });
}

- (id)getInfo:(void(^)(void))completedBlock {
    int j = 10;
    ReturnBlock returnBlock = ^(void) {
        NSLog(@"xxx %d", j);
    };
    
    return returnBlock;
}
NSLock *aLock;
- (void)testNOESACPE {
    aLock = [NSLock new];
    [self performNOESCAPEBlock:^(NSString *string) {
        NSLog(@"%@%@", self, string);
    }];
    [self performBlock:^(NSString *string) {
        NSLog(@"%@%@", self, string);
    }];
}

//- (void)performBlock:(__attribute__((noescape)) void (^)(NSString *string))testBlock {
- (void)performNOESCAPEBlock:(void (NS_NOESCAPE ^)(NSString *string))testBlock {
    [aLock lock];
    if (testBlock) {
        testBlock(@"performNOESCAPEBlock");
    }
    [aLock unlock];
}

- (void)performBlock:(void (^)(NSString *string))testBlock {
    [aLock lock];
    if (testBlock) {
        testBlock(@"performBlock");
    }
    [aLock unlock];
}

- (void)blockUseWeakWeak {
    // doSth doSth1都是stack block，在栈上，栈内存管理
    void(^ __weak doSth)(void) = nil;
    {
        int i = 0;
        void(^ __weak doSth1)(void) = ^{
            i;
            NSLog(@"111111");
        };
        doSth = doSth1;
    }
    doSth();
}

- (void)blockUseWeakStrong {
    // doSth是stack doSth1是malloc
    void(^ __weak doSth)(void) = nil;
    {
        int i = 0;
        void(^ doSth1)(void) = ^{
            i;
            NSLog(@"111111");
        };
        doSth = doSth1;
    }
    // 堆对象出了作用域会被释放，释放的内部会清除弱引用
    // doSth1会被dispose，doSth变为nil了，但是block的调用是调用的invoke函数，指针地址调用，不是objc_msgSend，所以闪退了
    doSth(); // null
    /*
     (lldb) bt
     * thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=1, address=0x10)
       * frame #0: 0x0000000100276f45 ClangLearningDemo`-[BlockTest blockUseWeakStrong](self=0x00006000007b5780, _cmd="blockUseWeakStrong") at BlockTest.m:620:5
         frame #1: 0x0000000100274885 ClangLearningDemo`-[BlockTest init](self=0x00006000007b5780, _cmd="init") at BlockTest.m:41:9
         frame #2: 0x0000000100277592 ClangLearningDemo`main(argc=1, argv=0x00007ffeef98acf8) at main.m:31:23
         frame #3: 0x00007fff5227ec25 libdyld.dylib`start + 1
         frame #4: 0x00007fff5227ec25 libdyld.dylib`start + 1
     (lldb)
     */
}

static BlockUsage *staticSelf = nil;
- (void)weakAndStatic {
    __weak typeof(self) weakSelf = self;
    staticSelf = weakSelf; // 这里取的是weakSelf指针所对应的obj
}

- (void)weakGlobalBlockExcuteDelay {
    void(^ __weak doSth)(void) = ^{
        NSLog(@"111111");
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        doSth();
    });
}

/*
 ClangLearningDemo`__34-[BlockTest stackBlockExcuteDelay]_block_invoke_2:
     0x1084d7cb0 <+0>:  pushq  %rbp
     0x1084d7cb1 <+1>:  movq   %rsp, %rbp
     0x1084d7cb4 <+4>:  subq   $0x20, %rsp
     0x1084d7cb8 <+8>:  movq   %rdi, -0x8(%rbp)
     0x1084d7cbc <+12>: movq   %rdi, -0x10(%rbp)
 ->  0x1084d7cc0 <+16>: addq   $0x20, %rdi
     0x1084d7cc4 <+20>: callq  0x1084d8c5a               ; symbol stub for: objc_loadWeakRetained
     0x1084d7cc9 <+25>: movq   %rax, %rdi
     0x1084d7ccc <+28>: movq   %rdi, %rcx
     0x1084d7ccf <+31>: movq   %rdi, -0x18(%rbp)
     0x1084d7cd3 <+35>: movq   %rcx, %rdi
     0x1084d7cd6 <+38>: callq  *0x10(%rax)
     0x1084d7cd9 <+41>: movq   -0x18(%rbp), %rax
     0x1084d7cdd <+45>: movq   %rax, %rdi
     0x1084d7ce0 <+48>: callq  *0x3352(%rip)             ; (void *)0x00007fff51411000: objc_release
     0x1084d7ce6 <+54>: addq   $0x20, %rsp
     0x1084d7cea <+58>: popq   %rbp
     0x1084d7ceb <+59>: retq
 */
- (void)stackBlockExcuteDelay {
    int i = 0;
    void(^ __weak doSth)(void) = ^{
        i;
        NSLog(@"111111");
    }; // __NSStackBlock__
    // stack block出了作用域释放了，会闪退
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (doSth) {
//            doSth();
//        }
        doSth();
    });
    /*
     (lldb) register read rdi
          rdi = 0x0000600003794840
     (lldb) register read rdi
     rdi          = error: unavailable
     (lldb)
     */
}

- (void)globalBlockExcuteDelay {
    void(^ doSth)(void) = ^{
        NSLog(@"111111");
    };
    // global block不被释放，会执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        doSth();
    });
}

- (void)mallocBlockExcuteDelay {
    int i = 0;
    void(^ doSth)(void) = ^{
        i;
        NSLog(@"111111");
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        doSth();
    });
}

@end

