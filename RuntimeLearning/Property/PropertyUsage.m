//
//  PropertyUsage.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/4.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "PropertyUsage.h"
#import "NSObject+HCLog.h"
#import "RuntimeLearningMacro.h"

@interface PropertyUsage ()

@property (nonatomic, copy) NSString *address;
@property (nonatomic, setter=_hcSetName:, getter=_hcGetName, copy) NSString *name;
@property (nonatomic, copy) void(^testBlockProperty)(void);
@property (nonatomic, copy) NSString *firstName;

@end

@implementation PropertyUsage

@synthesize address = _address;
@synthesize name = _hcTestName;
@synthesize addressFormate = _addressFormate;

+ (void)initialize {
    if (self == [PropertyUsage self]) {
        NSLog(@"initialize test");
    }
}

- (void)testPropertyUsage {
    [self hc_logMethodListDescription];
    [self hc_logIvarListDescription];
    // case 1:只声明address为readonly；日志如下：发现readonly的属性就不会自动生成set方法
    /*
     2020-06-04 16:10:54.912168+0800 RuntimeLearning[39449:780293] Method: testPropertyUsage
     2020-06-04 16:10:54.912381+0800 RuntimeLearning[39449:780293] Method: .cxx_destruct
     2020-06-04 16:10:54.912545+0800 RuntimeLearning[39449:780293] Method: address
     2020-06-04 16:10:54.912706+0800 RuntimeLearning[39449:780293] Ivar: _address
     */
    // case 2:声明address为readonly && 在扩展里面在定义同名属性
    /*
     2020-06-04 16:14:17.937265+0800 RuntimeLearning[39553:782901] Method: testPropertyUsage
     2020-06-04 16:14:17.937515+0800 RuntimeLearning[39553:782901] Method: .cxx_destruct
     2020-06-04 16:14:17.937701+0800 RuntimeLearning[39553:782901] Method: address
     2020-06-04 16:14:17.937855+0800 RuntimeLearning[39553:782901] Method: setAddress:
     2020-06-04 16:14:17.938017+0800 RuntimeLearning[39553:782901] Ivar: _address
     */
    // case 3: @synthesize address = _hcAddress;
    // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/SearchImplementation.html#//apple_ref/doc/uid/20000955
    self.name = @"HC";
    /*
      0x105afa4e4 <+84>:  leaq   0x2c745(%rip), %rax       ; @"HC"
     ->  0x105afa4eb <+91>:  movq   -0x8(%rbp), %rsi
         0x105afa4ef <+95>:  movq   0x36662(%rip), %rdi       ; "_hcSetName:"
         0x105afa4f6 <+102>: movq   %rdi, -0x28(%rbp)
         0x105afa4fa <+106>: movq   %rsi, %rdi
         0x105afa4fd <+109>: movq   -0x28(%rbp), %rsi
         0x105afa501 <+113>: movq   %rax, %rdx
         0x105afa504 <+116>: callq  *0x2abde(%rip)            ; (void *)0x00007fff513f7780: objc_msgSend
     
     rewrite-oc -I ../Utility  PropertyUsage.m # -I是指定文件夹，这里引入了该文件夹下的内容 -F是指定引入的库
     
     static void _I_PropertyUsage_testPropertyUsage(PropertyUsage * self, SEL _cmd) {
         ((void (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("hc_logMethodListDescription"));
         ((void (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("hc_logIvarListDescription"));
         ((void (*)(id, SEL, NSString * _Nonnull))(void *)objc_msgSend)((id)self, sel_registerName("_hcSetName:"), (NSString *)&__NSConstantStringImpl__var_folders_r0_4tb84bbj15j3kbzrnk8hqdwm0000gn_T_PropertyUsage_515c41_mi_0);
     }
     // __sel_registerName是dyld在加载image的时候会调用
     static SEL __sel_registerName(const char *name, bool shouldLock, bool copy)
     {
         SEL result = 0;

         if (shouldLock) selLock.assertUnlocked();
         else selLock.assertLocked();

         if (!name) return (SEL)0;

         result = search_builtins(name);
         if (result) return result;
         
         conditional_mutex_locker_t lock(selLock, shouldLock);
         if (namedSelectors) {
             result = (SEL)NXMapGet(namedSelectors, name);
         }
         if (result) return result;

         // No match. Insert.

         if (!namedSelectors) {
             namedSelectors = NXCreateMapTable(NXStrValueMapPrototype,
                                               (unsigned)SelrefCount);
         }
         if (!result) {
             result = sel_alloc(name, copy);
             // fixme choose a better container (hash not map for starters)
             NXMapInsert(namedSelectors, sel_getName(result), result);
         }

         return result;
     }
     
     */
    __unused NSString *tmpName = [self valueForKey:@"_hcTestName"]; // hcTestName 都可以得到name的值
    //__unused NSString *tmpName1 = [self valueForKey:@"name"]; // 指定getter方法并且实例名也不是如果不是按照kvc的查找方式中定义的那几种就会抛出异常‘valueForUndefinedKey’
    self.subTest = [NSDate new];
    //self.testRetainProperty = [NSObject new];
    NSArray *tmpArray = [NSArray arrayWithObject:@"1"];
    self.testCopyProperty = tmpArray;
    {
        self.testAssignProperty = [NSObject new];
    }
    {
        self.testWeakProperty = [NSObject new];
    }
    /*
     2020-06-04 16:38:42.875467+0800 RuntimeLearning[40098:801362] Method: _hcSetName:
     2020-06-04 16:38:42.875789+0800 RuntimeLearning[40098:801362] Method: testPropertyUsage
     2020-06-04 16:38:42.875968+0800 RuntimeLearning[40098:801362] Method: _hcGetName
     2020-06-04 16:38:42.876086+0800 RuntimeLearning[40098:801362] Method: .cxx_destruct
     2020-06-04 16:38:42.876285+0800 RuntimeLearning[40098:801362] Method: address
     2020-06-04 16:38:42.876396+0800 RuntimeLearning[40098:801362] Method: setAddress:
     2020-06-04 16:38:42.876580+0800 RuntimeLearning[40098:801362] Ivar: _address
     2020-06-04 16:38:42.876713+0800 RuntimeLearning[40098:801362] Ivar: _hcTestName
     */
    // 默认是read-write的@property会告诉编译器自动生成get set方法。同时@synthesize address = _address;
    self.addressFormate = @"xxx";
    //self.categoryTest;
#define IS_USE_TEMP 1
#if IS_USE_TEMP
    //__weak typeof(self) weakSelf = self;
    self.testBlockProperty = ^(void) {
        NSLog(@"excute block");
        //NSLog(@"%@", self.subTest);
        void(^tempBlock)(void) = ^(void) {
            //NSLog(@"inner self.subTest = %@", weakSelf.subTest);
            NSLog(@"inner self.subTest = %@", self.subTest);
        };
        MineBlockRef ref = (__bridge void *)(tempBlock);
        NSLog(@"block refcount = %d", ref->flags & MineBlockFlagsRefcountMask);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), tempBlock);
        NSLog(@"block refcount = %d", ref->flags & MineBlockFlagsRefcountMask);
    };
    MineBlockRef blockRef = (__bridge void *)(self.testBlockProperty);
    self.testBlockProperty();
#else
#define IS_INNER 1
#if IS_INNER
    void(^innerBlock)(void) = ^(void) {
        NSLog(@"inner self.subTest = %@", self.subTest);
    };
    self.testBlockProperty = ^(void) {
        NSLog(@"excute block");
        //NSLog(@"%@", self.subTest);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), innerBlock);
    };
    self.testBlockProperty();
#else
    void(^outterBlock)(void) = ^(void) {
        NSLog(@"outter self.subTest = %@", self.subTest);
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), outterBlock);
#endif
#endif
    
    //[self testMuiThreadSetProperty];
}

- (void)testMuiThreadSetProperty {
#define TagPointer 1
#if !TagPointer
    /*
     notnatimic + strong or copy 偶现闪退
     atomic则保证setter的操作是原子性的安全的，所以不会闪退，但是影响性能
     (lldb) bt
     * thread #2, queue = 'com.apple.root.default-qos', stop reason = EXC_BAD_ACCESS (code=1, address=0x4187c5cd0ba0)
         frame #0: 0x00007fff5141100b libobjc.A.dylib`objc_release + 11
         frame #1: 0x000000010302da77 RuntimeLearning`-[PropertyUsage setFirstName:](self=0x0000600000291c70, _cmd="setFirstName:", firstName=@"abcdefjhjk") at PropertyUsage.m:0
       * frame #2: 0x000000010302d380 RuntimeLearning`__41-[PropertyUsage testMuiThreadSetProperty]_block_invoke(.block_descriptor=0x0000600002fbc900) at PropertyUsage.m:144:18
         frame #3: 0x0000000103a63dd4 libdispatch.dylib`_dispatch_call_block_and_release + 12
         frame #4: 0x0000000103a64d48 libdispatch.dylib`_dispatch_client_callout + 8
         frame #5: 0x0000000103a671ef libdispatch.dylib`_dispatch_queue_override_invoke + 1022
         frame #6: 0x0000000103a7628c libdispatch.dylib`_dispatch_root_queue_drain + 351
         frame #7: 0x0000000103a76b96 libdispatch.dylib`_dispatch_worker_thread2 + 132
         frame #8: 0x00007fff524636b6 libsystem_pthread.dylib`_pthread_wqthread + 220
         frame #9: 0x00007fff52462827 libsystem_pthread.dylib`start_wqthread + 15
     (lldb)
     */
    for (NSInteger i = 0; i < 1000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.firstName = [NSString stringWithFormat:@"%@", @"abcdefjhjk"];
        });
    }
#else
    for (NSInteger i = 0; i < 1000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.firstName = [NSString stringWithFormat:@"%@", @"abc"];
        });
    }
#endif
}

- (void)dealloc {
    NSLog(@"[%@ %s]", self.class, __FUNCTION__);
}

#pragma mark - Getter && Setter

- (NSDate *)subTest {
    if (_subTest == nil) {
        _subTest = [NSDate date];
    }
    
    return _subTest;
}

@end

@implementation PropertyUsage(TestCategory)


@end

@implementation SubPropertyUsage

//@dynamic subTest;
@synthesize subTest = _subTest_;

- (void)testSubClassPropertyUsage {
    NSLog(@"subclass");
    [self hc_logMethodListDescription];
    [self hc_logIvarListDescription];
    NSLog(@"%@", self.subTest); // null
    //self.subTest = @"_subTest_";
    self.subTest = [NSDate date];
    /*
     po [self _shortMethodDescription]
     <SubPropertyUsage: 0x600000211c70>:
     in SubPropertyUsage:
         Properties:
             @property (retain, nonatomic) NSDate* subTest;  (@synthesize subTest = _subTest_;)
         Instance Methods:
             - (void) setSubTest:(id)arg1; (0x10f0be280)
             - (id) subTest; (0x10f0be230)
             - (void) testSubClassPropertyUsage; (0x10f0be160)
             - (void) .cxx_destruct; (0x10f0be2f0)
     in PropertyUsage:
         Properties:
             @property (retain, nonatomic) NSObject* categoryTest;
             @property (copy, nonatomic) NSString* address;  (@synthesize address = _address;)
             @property (copy, nonatomic, getter=_hcGetName, setter=_hcSetName:) NSString* name;  (@synthesize name = _hcTestName;)
             @property (copy, nonatomic) ^block testBlockProperty;  (@synthesize testBlockProperty = _testBlockProperty;)
             @property (retain, nonatomic) NSDate* subTest;  (@synthesize subTest = _subTest;)
             @property (copy, nonatomic) NSArray* testCopyProperty;  (@synthesize testCopyProperty = _testCopyProperty;)
             @property (nonatomic) NSObject* testAssignProperty;  (@synthesize testAssignProperty = _testAssignProperty;)
             @property (weak, nonatomic) NSObject* testWeakProperty;  (@synthesize testWeakProperty = _testWeakProperty;)
             @property (readonly) unsigned long hash;
             @property (readonly) Class superclass;
             @property (readonly, copy) NSString* description;
             @property (readonly, copy) NSString* debugDescription;
             @property (copy, nonatomic) NSString* addressFormate;  (@synthesize addressFormate = _addressFormate;)
         Instance Methods:
             - (void) _hcSetName:(id)arg1; (0x10f0bdc70)
             - (void) setSubTest:(id)arg1; (0x10f0bdd80)
             - (void) setTestCopyProperty:(id)arg1; (0x10f0bde30)
             - (void) setTestAssignProperty:(id)arg1; (0x10f0bded0)
             - (void) setTestWeakProperty:(id)arg1; (0x10f0bdf70)
             - (void) setAddressFormate:(id)arg1; (0x10f0bdd20)
             - (id) subTest; (0x10f0bdae0)
             - (void) setTestBlockProperty:(^block)arg1; (0x10f0be030)
             - (^block) testBlockProperty; (0x10f0bdfe0)
             - (id) addressFormate; (0x10f0bdcd0)
             - (void) testPropertyUsage; (0x10f0bd500)
             - (id) _hcGetName; (0x10f0bdc20)
             - (id) testCopyProperty; (0x10f0bdde0)
             - (id) testAssignProperty; (0x10f0bde90)
             - (id) testWeakProperty; (0x10f0bdf20)
             - (void) .cxx_destruct; (0x10f0be090)
             - (void) dealloc; (0x10f0bda50)
             - (id) address; (0x10f0bdb70)
             - (void) setAddress:(id)arg1; (0x10f0bdbc0)
     */
}

@end
