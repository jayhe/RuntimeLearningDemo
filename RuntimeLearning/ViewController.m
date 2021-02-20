//
//  ViewController.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/20.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "ViewController.h"
#import "TestUnsafeSwizzle.h"
#import "TestCategorySwizzle.h"
#import "TestSubClassSwizzle.h"
#import "MethodSwizzleUtil.h"
#import "NSObject+HCWillDealloc.h"
#import "TestCategoryOveride.h"
#import "TestCategoryOveride+TestOveride.h"
#import "UIFont+Test.h"
#import "AttributeUsage.h"
#import "DynamicCallFunctionTest.h"
#import "NSObject+HCInjection.h"
#import "TestSwizzleInInitialize.h"
#import "CopyUsage.h"
#import "UITextField+HCInputType.h"
#import "TestClassCluster.h"
#import "NSCacheTest.h"
#import "HCClangTrace.h"
#import "RuntimeLearning-Swift.h"
#include <mach-o/dyld.h>
#import "DispatchOnceTest.h"
#import "DispatchBarrierTest.h"
#import "DispatchGroupLeaveTest.h"
#import "DispatchExamnationTest.h"
#import "RuntimeLearningMacro.h"
#import <objc/runtime.h>
#import "TestTaggedPointer.h"
#import "ByteAlignmentTest.h"
#import "FishhookUsage.h"
#import "TestMapTable.h"
#import "TestCode.h"
#import "DynamicCallFunctionTest.h"
#import "calculate.h"
#import "TestStaticLib.h"
#import "TestMethodInvocation.h"
#import "TestViewDidLoadCallStackViewController.h"
#import <fishhook/fishhook.h>
#import "KeychainUsage.h"
#import "TestFuctionalProgromming.h"
#import "HCSwizzleInstance.h"
#import "PropertyUsage.h"
#import "HookMethodInInitialize.h"
#import "NSObject+HCSafe.h"
#include <stdlib.h>
#import "HCTestProtocol.h"
#import <Aspects/Aspects.h>
#import <dlfcn.h>

@interface TestKVOObject : NSObject
{
    /*
     ivar的查找顺序，测试发现如果传的key是带有'_'的，也是会按照_key _isKey key isKey的方式查找
     eg：key = testIvarString，则查找顺序_testIvarString _isTestIvarString testIvarString isTestIvarString
     eg：key = _testIvarString，则查找顺序__testIvarString _is_testIvarString _testIvarString is_testIvarString
     */
    NSString *_testIvarString;
    //NSString *_isTestIvarString;
    //NSString *testIvarString;
    //NSString *isTestIvarString;
}

@property (nonatomic, copy) NSString *testString;
@property (nonatomic, assign) NSInteger testInteger;
@property (nonatomic, assign) NSRange testRange;

@end

@implementation TestKVOObject

//- (nullable Ivar)hc_getIvarByKey:(NSString *)key {
//    if (![key isKindOfClass:[NSString class]] || key.length <= 0) {
//        return nil;
//    }
//    // 按照_key _isKey key isKey的方式去获取ivar
//    NSString *firstCharacter = [key substringToIndex:1];
//    NSString *upperFirstKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter];
//
//    NSString *_keyName = [NSString stringWithFormat:@"_%@", key];
//    NSString *_isKeyName = [NSString stringWithFormat:@"_is%@", upperFirstKey];
//    NSString *keyName = key;
//    NSString *isKeyName = [NSString stringWithFormat:@"is%@", upperFirstKey];
//    Ivar ivar;
//    if ((ivar = [self hc_getIvarByIvarName:_keyName])
//        || (ivar = [self hc_getIvarByIvarName:_isKeyName])
//        || (ivar = [self hc_getIvarByIvarName:keyName])
//        || (ivar = [self hc_getIvarByIvarName:isKeyName])) {
//        return ivar;
//    }
//    return nil;
//}
//
//- (nullable Ivar)hc_getIvarByIvarName:(NSString *)ivarNameString {
//    const char *ivarName = [ivarNameString cStringUsingEncoding:NSUTF8StringEncoding];
//    Ivar ivar = class_getInstanceVariable(self.class, ivarName);
//    return ivar;
//}

//- (BOOL)_isKVOA {
//    return 0;
//}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
}

//- (void)setNilValueForKey:(NSString *)key {
//    if ([key isEqualToString:@"testInteger"]) { // fix 设置number为nil的时候导致抛出异常
//        [self setValue:@(0) forKey:key];
//    }
//}

//- (void)setNilValueForKey:(NSString *)key {
//    Ivar ivar = [self hc_getIvarByKey:key];
//    if (!ivar) {
//        [super setNilValueForKey:key];
//    }
//    const char *typeEncoding = ivar_getTypeEncoding(ivar); // 'q' longlong 'Q' usignedlonglong；NSInteger在32bit是int，在64bit就是64位
//    // 遍历出所有的number、value类型的encoding，针对性的处理
//    // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
//    /*
//     Printing description of typeEncoding:
//     (const char *) typeEncoding = 0x000000010f4c5c7a "{_NSRange=\"location\"Q\"length\"Q}"
//     (lldb) po @encode(NSRange)
//     "{_NSRange=QQ}"
//     */
//    switch (typeEncoding[0]) {
//            // NSNumber scalar type
//        case 'q': // longlong
//        case 'Q': // unsigned longlong
//        case 'i': // int
//        case 'I': // unsigned int
//        case 'l': // long
//        case 'L': // unsigned long
//        case 's': // short
//        case 'S': // unsigned short
//        case 'd': // double
//        case 'f': // float
//            [self setValue:@(0) forKey:key];
//            break;
//        case '{': {
//            char* idx = index(typeEncoding, '='); // 获取'='字符串中第一个出现的参数'=' 地址，然后将该字符出现的地址返回
//            /*
//             eg："0x000000010bac7c7a {_NSRange=\"location\"Q\"length\"Q}" idx则为 0x000000010bac7c83 "=\"location\"Q\"length\"Q}"
//
//             Printing description of idx:
//             (char *) idx = 0x000000010bac7c83 "=\"location\"Q\"length\"Q}"
//             Printing description of typeEncoding:
//             (const char *) typeEncoding = 0x000000010bac7c7a "{_NSRange=\"location\"Q\"length\"Q}"
//             */
//            if (idx == NULL) { // 如果为空则表示没有找到'='，此时走远来的流程
//                [super setNilValueForKey:key];
//            }
//            // 处理NSValue的一些场景：比如NSRange、CGRect、CGPoint、CGSize；也就是NSValue structure type
//            /*
//             int strncmp(const char *str1, const char *str2, size_t n) 把 str1 和 str2 进行比较，最多比较前 n 个字节
//             如果返回值 < 0，则表示 str1 小于 str2。
//             如果返回值 > 0，则表示 str2 小于 str1。
//             如果返回值 = 0，则表示 str1 等于 str2。
//             */
//            NSValue *value;
//            long cmpLength = idx - typeEncoding;
//#define SAME_ENCODE(name) (strncmp(typeEncoding, @encode(name), cmpLength) == 0)
//            if (SAME_ENCODE(NSRange)) {
//                value = [NSValue valueWithRange:NSMakeRange(0, 0)];
//            } else if (SAME_ENCODE(CGPoint)) {
//                value = [NSValue valueWithCGPoint:CGPointZero];
//            } else if (SAME_ENCODE(CGSize)) {
//                value = [NSValue valueWithCGSize:CGSizeZero];
//            } else if (SAME_ENCODE(CGRect)) {
//                value = [NSValue valueWithCGRect:CGRectZero];
//            } else if (SAME_ENCODE(CGVector)) {
//                value = [NSValue valueWithCGVector:CGVectorMake(0, 0)];
//            } else if (SAME_ENCODE(UIEdgeInsets)) {
//                value = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
//            } else if (SAME_ENCODE(UIOffset)) {
//                value = [NSValue valueWithUIOffset:UIOffsetZero];
//            } else if (SAME_ENCODE(CGAffineTransform)) {
//                value = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
//            }
//#ifndef FOUNDATION_HAS_DIRECTIONAL_GEOMETRY
//            else if (@available(iOS 11.0, *)) {
//                if (SAME_ENCODE(NSDirectionalEdgeInsets)) {
//                    value = [NSValue valueWithDirectionalEdgeInsets:NSDirectionalEdgeInsetsZero];
//                }
//            } else {
//                // Fallback on earlier versions
//            }
//#endif
//            if (value != nil) {
//                [self setValue:value forKey:key];
//            } else {
//                [super setNilValueForKey:key];
//            }
//        }
//            break;
//        default:
//            [super setNilValueForKey:key];
//            break;
//    }
//}

@end

//@interface NSKVONotifying_TestKVOObject : TestKVOObject
//
//@end
//
//@implementation NSKVONotifying_TestKVOObject
//
//@end

@class TableDataRow;

@interface TableDataSection : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<TableDataRow *> *items;
@property (nonatomic, assign) BOOL foldFlag; // default is YES

@end

@interface TableDataRow : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL action;

@end

@implementation TableDataSection

- (instancetype)init {
    self = [super init];
    if (self) {
        _foldFlag = YES;
    }
    
    return self;
}

@end

@implementation TableDataRow

- (void)dealloc {
    _action = nil;
}

@end

static NSString *kCellID    = @"CELLID";
static NSString *kHeaderID  = @"HEADERID";

void testWaitUsage(void);
void testLogicNot(NSInteger times);
void testLogicEqualNil(NSInteger times);
void testVAList(NSString *format, ...) NS_REQUIRES_NIL_TERMINATION;
void testVAList1(NSString *format, ...) NS_NO_TAIL_CALL;
int addNumbers(int a, ...) NS_NO_TAIL_CALL;
void testBenchmark(void);

@interface ViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, HCCatchUnrecognizedSelectorProtocol>

@property (nonatomic, strong) DynamicCallFunctionTest *dynamicFunctionTest;
@property (nonatomic, strong) NSCacheTest *testCache;
@property (nonatomic, strong) UITableView *entryTableView;
@property (nonatomic, strong) NSMutableArray<TableDataSection*> *dataSource;
@property (nonatomic, strong) NSString *nonatomicText;
@property (atomic, strong) NSString *atomicText;
@property (nonatomic, copy) NSString *testKVOString;

- (void)testMethodNotImp;

@end

@implementation ViewController

//- (void)injected {
//    [self setupUI];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDataSource];
    [self.view addSubview:self.entryTableView];
    [self.entryTableView addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"%s", __FUNCTION__);
    self.entryTableView.backgroundColor = [UIColor whiteColor];
    if ([self.entryTableView isMemberOfClass:[UITableView class]]) { // return [self class] == cls;
        NSLog(@"self.entryTableView is member of  UITableView");
    }
    if ([self.entryTableView isKindOfClass:[UITableView class]]) { // 递归superclass去判断class是否相等
        NSLog(@"self.entryTableView is kind of  UITableView");
    }
    [self methodToBeHook];
    /*
     (lldb) p self.entryTableView->isa
     (__unsafe_unretained Class) $4 = NSKVONotifying_UITableView
     (lldb) po [NSKVONotifying_UITableView _shortMethodDescription]
     <NSKVONotifying_UITableView: 0x600003d10bd0>:
     in NSKVONotifying_UITableView:
         Instance Methods:
             - (void) setBackgroundColor:(id)arg1; (0x7fff207b5b57)
             - (Class) class; (0x7fff207b4662)
             - (void) dealloc; (0x7fff207b440b)
             - (BOOL) _isKVOA; (0x7fff207b4403)
     (UITableView ...)

     (lldb)
     */
    //[self testObserverProperty];
    //[self checkHasInsertedDylib];
#if DEBUG
    injectBlock {
        [weakSelf setupUI];
    };
#endif
}

void functionF() {
    // stack特点： LIFO 地址从高到低分配
    // functionF先进栈，functionG后入栈

    int x = functionG(1);
    NSLog(@"%p", ((void*)functionG)); // 0x10c7f79d0
    NSLog(@"%p", ((void*)functionF)); // 0x10c7f7990
    x++; //g函数返回，当前堆栈顶部为f函数栈帧，在当前栈帧继续执行f函数的代码。
}

int functionG(int x) {
    return x + 1;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor purpleColor];
    NSLog(@"Injected %s", __FUNCTION__);
}

- (void)methodToBeHook {
    void *PC = __builtin_return_address(0);
    Dl_info info;
    dladdr(PC, &info);
    NSString *name = @(info.dli_sname);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __FUNCTION__);
    self.view.backgroundColor = [UIColor lightGrayColor];
//    [NSThread sleepForTimeInterval:5];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        self.view.backgroundColor = [UIColor redColor];
//        //[self.view addSubview:[[UIImageView alloc] initWithImage:nil]]; // 'NSInternalInconsistencyException', reason: 'Modifications to the layout engine must not be performed from a background thread after it has been accessed from the main thread.'
//    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __FUNCTION__);
//    [NSThread sleepForTimeInterval:2];
}

#pragma mark - HCCatchUnrecognizedSelectorProtocol

- (BOOL)shouldCatch {
    return YES;
}

void MineHandler(NSDictionary<NSString *, NSString *> *unrecognizedSelectorInfo) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    //NSLog(@"%@", [unrecognizedSelectorInfo objectForKey:HCUnrecognizedSelectorMessageKey]);
#pragma clang diagnostic pop
    NSLog(@"%@", unrecognizedSelectorInfo);
}

- (void)testCatchUnrecognizedSelector {
    RLSetUnrecognizedSelectorExceptionHandler(&MineHandler);
    /*
     // -Werror=incomplete-implementation
    [self testMethodNotImp];
    [self.entryTableView performSelector:@selector(haha)];
    {
        NSMutableArray *array = [NSArray array];
        [array removeLastObject];
    }
    {
        NSString *testString;
        id serverData = [NSNumber numberWithInt:12345];
        testString = serverData;
        __unused NSInteger length = testString.length;
    }
     */
    NSInteger testCase = 5;
    switch (testCase) {
        case 1: {
            //[self testMethodNotImp];
        }
            break;
        case 2: {
            // -Werror=undeclared-selector
            [self.entryTableView performSelector:@selector(haha)];
        }
            break;
        case 3: {
            //-Werror=incompatible-pointer-types
            //NSMutableArray *array = [NSArray array];
            //[array removeLastObject];
        }
            break;
        case 4: {
            NSString *testString;
            id serverData = [NSNumber numberWithInt:12345];
            testString = serverData;
            __unused NSInteger length = testString.length;
        }
            break;
        case 5: {
            
        }
            break;
        case 6: {
            NSArray *testArray;
            id serverData = @"12345";
            testArray = serverData;
            __unused NSInteger count = testArray.count;
        }
            break;
        default:
            break;
    }
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"backgroundColor"]) {
        NSLog(@"backgroundColor: %@", change);
    } else if ([keyPath isEqualToString:@"title"]) {
        NSLog(@"title: %@", change);
    } else if ([keyPath isEqualToString:@"testKVOString"]) {
        NSLog(@"testKVOString: %@", change);
    } else {
        NSLog(@"observeValu: %@", change);
    }
}

#pragma mark - Private Methods

- (void)initDataSource {
    TableDataSection *section0 = [TableDataSection new];
    section0.title = @"基础部分";
    {
        TableDataRow *row0 = [TableDataRow new];
        row0.title = @"拷贝使用";
        row0.action = @selector(testCopyUsage);
        TableDataRow *row1 = [TableDataRow new];
        row1.title = @"集合遍历使用";
        row1.action = @selector(testArrayReadWhileChange);
        TableDataRow *row2 = [TableDataRow new];
        row2.title = @"类簇测试";
        row2.action = @selector(testClassCluster);
        TableDataRow *row3 = [TableDataRow new];
        row3.title = @"NSCache使用";
        row3.action = @selector(testCacheUsage);
        TableDataRow *row4 = [TableDataRow new];
        row4.title = @"__attribute使用";
        row4.action = @selector(testAttributeUsage);
        TableDataRow *row5 = [TableDataRow new];
        row5.title = @"mapTable使用";
        row5.action = @selector(testMapTableUsage);
        TableDataRow *row6 = [TableDataRow new];
        row6.title = @"不定参数使用";
        row6.action = @selector(testVAListUsage);
        TableDataRow *row7 = [TableDataRow new];
        row7.title = @"测试结构体内存管理";
        row7.action = @selector(testStructUsage);
        TableDataRow *row8 = [TableDataRow new];
        row8.title = @"属性名相同就是首字母大小写的差异引发的问题";
        row8.action = @selector(testPropertyWithSameNameButDifferentCapUsage);
        TableDataRow *row9 = [TableDataRow new];
        row9.title = @"钥匙串的使用";
        row9.action = @selector(testKeychainUsage);
        TableDataRow *row10 = [TableDataRow new];
        row10.title = @"函数式编程的使用";
        row10.action = @selector(testFP);
        TableDataRow *row11 = [TableDataRow new];
        row11.title = @"修改table的indicator样式";
        row11.action = @selector(changeTableIndicatorStyle);
        TableDataRow *row12 = [TableDataRow new];
        row12.title = @"测试protocol";
        row12.action = @selector(testProtocolUsage);
        TableDataRow *row13 = [TableDataRow new];
        row13.title = @"测试并发给属性赋值-noatomic";
        row13.action = @selector(testAsyncSetNoatomicProperty);
        TableDataRow *row14 = [TableDataRow new];
        row14.title = @"测试并发给属性赋值-atomic";
        row14.action = @selector(testAsyncSetAtomicProperty);
        TableDataRow *row15 = [TableDataRow new];
        row15.title = @"测试字符串比较";
        row15.action = @selector(testStringCompare);
        TableDataRow *row16 = [TableDataRow new];
        row16.title = @"测试字符串format";
        row16.action = @selector(testStringFormat);
        section0.items = @[
            row0,
            row1,
            row2,
            row3,
            row4,
            row5,
            row6,
            row7,
            row8,
            row9,
            row10,
            row11,
            row12,
            row13,
            row14,
            row15,
            row16].mutableCopy;
    }
    
    TableDataSection *section1 = [TableDataSection new];
    section1.title = @"Runtime部分";
    {
        TableDataRow *row0 = [TableDataRow new];
        row0.title = @"类方法交换";
        row0.action = @selector(testClassMethod);
        TableDataRow *row1 = [TableDataRow new];
        row1.title = @"实例方法交换";
        row1.action = @selector(testSwizzleMethod);
        TableDataRow *row2 = [TableDataRow new];
        row2.title = @"子类实例方法交换";
        row2.action = @selector(testSubClassSwizzleMethod);
        TableDataRow *row3 = [TableDataRow new];
        row3.title = @"不安全的方法交换";
        row3.action = @selector(testUnsafeSwizzle);
        TableDataRow *row4 = [TableDataRow new];
        row4.title = @"initialize中方法交换";
        row4.action = @selector(testSwizzleInInitialize);
        TableDataRow *row5 = [TableDataRow new];
        row5.title = @"类别方法交换";
        row5.action = @selector(testCategorySwizzle);
        TableDataRow *row6 = [TableDataRow new];
        row6.title = @"类别方法覆盖测试";
        row6.action = @selector(testCategoryOveride);
        TableDataRow *row7 = [TableDataRow new];
        row7.title = @"测试对象释放之后做些事情";
        row7.action = @selector(testDoSthWhenDealloc);
        TableDataRow *row8 = [TableDataRow new];
        row8.title = @"方法调用栈";
        row8.action = @selector(testCallStack);
        TableDataRow *row13 = [TableDataRow new];
        row13.title = @"viewDidLoad方法调用栈面试题";
        row13.action = @selector(testViewDidLoadCallStack);
        TableDataRow *row9 = [TableDataRow new];
        row9.title = @"TaggedPointer测试";
        row9.action = @selector(testTaggedPointerUsage);
        TableDataRow *row10 = [TableDataRow new];
        row10.title = @"字节对齐测试";
        row10.action = @selector(testWordAlignUsage);
        TableDataRow *row11 = [TableDataRow new];
        row11.title = @"fishhook使用";
        row11.action = @selector(testFishhookUsage);
        TableDataRow *row12 = [TableDataRow new];
        row12.title = @"动态调用使用";
        row12.action = @selector(testDynamicCall);
        TableDataRow *row14 = [TableDataRow new];
        row14.title = @"修改类的isa";
        row14.action = @selector(changeInstanceClass);
        TableDataRow *row17 = [TableDataRow new];
        row17.title = @"测试自己实现简易KVO";
        row17.action = @selector(testKVO);
        TableDataRow *row18 = [TableDataRow new];
        row18.title = @"测试系统KVO";
        row18.action = @selector(testSystemKVO);
        TableDataRow *row15 = [TableDataRow new];
        row15.title = @"测试catch unrecognized selector";
        row15.action = @selector(testCatchUnrecognizedSelector);
        TableDataRow *row16 = [TableDataRow new];
        row16.title = @"测试关联对象weak";
        row16.action = @selector(testSetWeakAssociation);
        section1.items = @[
            row0,
            row1,
            row2,
            row3,
            row4,
            row5,
            row6,
            row7,
            row8,
            row13,
            row9,
            row10,
            row11,
            row12,
            row14,
            row17,
            row18,
            row15,
            row16].mutableCopy;
    }
    TableDataSection *section2 = [TableDataSection new];
    section2.title = @"优化部分";
    {
        TableDataRow *row0 = [TableDataRow new];
        row0.title = @"打印ALSR";
        row0.action = @selector(logLibASLR);
        TableDataRow *row1 = [TableDataRow new];
        row1.title = @"Clang插桩测试";
        row1.action = @selector(testClangTraceUsage);
        TableDataRow *row2 = [TableDataRow new];
        row2.title = @"将load中的hook迁移到initialize中hook";
        row2.action = @selector(testHookInInitialize);
        section2.items = @[
            row0,
            row1,
            row2].mutableCopy;
    }
    
    TableDataSection *section3 = [TableDataSection new];
    section3.title = @"多线程部分";
    {
        TableDataRow *row0 = [TableDataRow new];
        row0.title = @"dispatch_once使用";
        row0.action = @selector(testDispatchOnceUsage);
        TableDataRow *row1 = [TableDataRow new];
        row1.title = @"测试几个任务完成后再执行任务";
        row1.action = @selector(testBarrierUsage);
        TableDataRow *row2 = [TableDataRow new];
        row2.title = @"测试dispatch_group_leave异常";
        row2.action = @selector(testDispatchGroupLeaveUsage);
        TableDataRow *row3 = [TableDataRow new];
        row3.title = @"多线程题目";
        row3.action = @selector(dispatchExamnations);
        TableDataRow *row4 = [TableDataRow new];
        row4.title = @"thread fork";
        row4.action = @selector(testAttributeUsage);
        TableDataRow *row5 = [TableDataRow new];
        row5.title = @"dispatch_benchmark做时间统计";
        row5.action = @selector(testDispatchBenchmark);
        section3.items = @[
            row0,
            row1,
            row2,
            row3,
            row4,
            row5].mutableCopy;
    }
    
    self.dataSource = @[
        section0,
        section1,
        section2,
        section3,
    ].mutableCopy;
}

#pragma mark - 基础部分

- (void)testAttributeUsage {
    [AttributeUsage new];
}

- (void)testPropertyWithSameNameButDifferentCapUsage {
    [[TestMethodInvocation new] testSetPropertyWhenChangeDeclareOrder];
}

- (void)testCopyUsage {
    [[CopyUsage new] testCopyAndMutableCopy];
}

- (void)testArrayReadWhileChange {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 10; i ++) {
        [array addObject:[TestObj new]];
    }
//    https://www.jianshu.com/p/66f8410c6bbc
    // 数组的枚举函数，遍历的时候在非尾部插入元素会异常。
    [array enumerateObjectsUsingBlock:^(TestObj *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // case1:遍历的时候修改元素【不会有问题】
//            NSLog(@"%@", obj);
//            [array replaceObjectAtIndex:3 withObject:[TestObj new]];
        
            // case2:遍历的时候添加元素及在尾部insert
//            [array addObject:@"added"];
//            NSLog(@"%@", obj); // 会一直输出，因为执行一次添加一个元素，一直添加；Executes a given block using each object in the array, starting with the first object and continuing through the array to the last object.
        
            // case3.1:遍历的时候在数组的某个index插入；eg：index == 0
//            [array insertObject:@"added" atIndex:0]; // EXC_BAD_ACCESS (code=EXC_I386_GPFLT)
//            NSLog(@"%@", obj);
            // case3.2:遍历的时候在数组的某个index插入；eg：index == （0, count) insert的index是数组的尾部 array.count则不会闪退
//            [array insertObject:@"added" atIndex:array.count]; // 这个类似于addObject
//            NSLog(@"%@", obj);
        
            // case4: 遍历的时候移除数组的元素；【不会有问题】
//            [array removeObjectAtIndex:0];
//            NSLog(@"%@", obj);
    }];
    // 在for in的循环中，如果只是修改数组内部引用的元素的属性则不会有问题，如果是修改了数组内部引用或者是改变数组的大小则会闪退
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (id obj in array) {
            // case1:遍历的时候修改元素【 EXC_BAD_ACCESS (code=EXC_I386_GPFLT)】
//            [array replaceObjectAtIndex:0 withObject:[TestObj new]];
//            NSLog(@"%@", obj);
    
            // case2:遍历的时候添加元素及在尾部insert 【*** Collection <__NSArrayM: 0x6000003c0900> was mutated while being enumerated.'】
//            [array addObject:@"added"];
//            NSLog(@"%@", obj);
    
            // case3: 遍历的时候移除数组的元素；【同上】
//            [array removeLastObject];
//            NSLog(@"%@", obj); // EXC_BAD_ACCESS (code=1, address=0x4ca0af4303c8)
        }
//    });
    
    // 在for循环中，增删改没有问题
//    for (NSInteger i = 0; i < array.count; i ++) {
            // case1:遍历的时候修改元素【 没有问题 】
//            [array replaceObjectAtIndex:4 withObject:[TestObj new]];
//            NSLog(@"%@", array[i]);
            // case2:遍历的时候添加元素及在尾部insert 【 跟enumerate效果一样】
//            [array addObject:@"added"];
//            NSLog(@"%@", array[i]);
            // case3.1:遍历的时候在数组的某个index插入；eg：index == 0 【 跟enumerate效果一样】
//            [array insertObject:@"added" atIndex:0];
//            NSLog(@"%@", array[i]);
            // case3.2:遍历的时候在数组的某个index插入；eg：index == （0, count) 【 跟enumerate效果一样】
//            [array insertObject:@"added" atIndex:1];
//            NSLog(@"%@", array[i]);
            // case4: 遍历的时候移除数组的元素；【不会有问题】
//            [array removeObjectAtIndex:0];
//            NSLog(@"%@", array[i]);
//    }
}

- (void)testMapTableUsage {
    [TestMapTable new];
}

- (void)testVAListUsage {
    testVAList(@"%@, %@, %@", @"0", @"1", @"11", nil);
    testVAList1(@"%@, %@, %@", @"0", @"1", @"11");
    addNumbers(10, 11, 12, 10, 13, -11, 100, 111, 222, 333, 444);
}

- (void)testStructUsage {
    [TestCode new];
}

- (void)testClassCluster {
    [TestClassCluster new];
}

- (void)testCacheUsage {
    self.testCache = [NSCacheTest new];
    [self.testCache test];
}

- (void)testKeychainUsage {
    KeychainUsage *keychain = [[KeychainUsage alloc] initWithService:@"com.hc.runtimelearning" accessGroup:@"group.hc.demo"]; // L2ZY2L7GYS.group.hc.demo
    [keychain testKeychainUsage];
}

- (void)testFP {
    [TestFuctionalProgromming new];
}

- (void)changeTableIndicatorStyle {
    // @property (readonly, nonatomic, getter=_horizontalScrollIndicator) UIView* horizontalScrollIndicator;
    // @property (readonly, nonatomic, getter=_verticalScrollIndicator) UIView* verticalScrollIndicator;
    UIView *indicator = [self.entryTableView valueForKey:@"verticalScrollIndicator"];
    if (indicator) {
        // 修改颜色
        [indicator setBackgroundColor:[UIColor purpleColor]];
        // 修改宽度，利用Aspects去hook实例对象
        [indicator aspect_hookSelector:@selector(setFrame:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            CGRect bounds = indicator.bounds;
            bounds.size.width = 6;
            ((UIView *)aspectInfo.instance).bounds = bounds;
        } error:NULL];
    }
    /*
     (lldb) po [0x7fa97d020000 valueForKey:@"verticalScrollIndicator"]
     <_UIScrollViewScrollIndicator: 0x7fa97c510d70; frame = (369 3; 3 218); alpha = 0; autoresize = LM; layer = <CALayer: 0x600003eed080>>
     (lldb) expression ((UIView *)0x7fa97c510d70).backgroundColor = [UIColor redColor]
     (UICachedDeviceRGBColor *) $31 = 0x000060000261bb00
     (lldb) flush
     */
}

- (void)testProtocolUsage {
    // Protocol是继承自NSObject
    __unused Protocol *testProtocol = @protocol(HCTestProtocol);
    if ([(Class)(testProtocol) isKindOfClass:[NSObject class]]) {
        NSLog(@"testProtocol is NSObject");
    }
    //id obj = [[(Class)(testProtocol) alloc] init];
    Protocol *testA = @protocol(HCTestAProtocol);
    Protocol *testB = @protocol(HCTestBProtocol);
    __unused NSString *testAName = [NSString stringWithUTF8String:protocol_getName(testA)]; // HCTestAProtocol
    __unused NSString *testBName = [NSString stringWithUTF8String:protocol_getName(testB)]; // HCTestBProtocol
    if (protocol_conformsToProtocol(testA, @protocol(HCModuleATestProtocol))) {
        NSLog(@"call module A");
    }
}

- (void)testAsyncSetNoatomicProperty {
    for (NSInteger i = 0; i < 100000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.nonatomicText = [NSString stringWithFormat:@"abcdefghj%ld", (long)i];
            // 这里改成下面这句会怎样？？
            // self.nonatomicText = [NSString stringWithFormat:@"%ld", (long)i];
        });
    }
    /* 闪退的原因，由于是nonatomic，set方法的调用不是原子性的，就存在多个线程可能同时在执行，如果一个线程执行到release另外一个线程也执行到release，那么久会异常。
     - (void)setNonatomicText:(NSString *)nonatomicText {
         [nonatomicText retain];
         [_nonatomicText release];
         _nonatomicText = nonatomicText;
     }
     看看libmalloc的源码：
     // Try to free to a tiny region.
     if ((uintptr_t)ptr & (TINY_QUANTUM - 1)) {
         szone_error(szone, 1, "Non-aligned pointer being freed", ptr, NULL);
         return;
     }
     */
    /*
     libobjc.A.dylib`objc_release:
         0x7fff51411000 <+0>:  testq  %rdi, %rdi
         0x7fff51411003 <+3>:  je     0x7fff51411007            ; <+7>
         0x7fff51411005 <+5>:  jns    0x7fff51411008            ; <+8>
         0x7fff51411007 <+7>:  retq
         0x7fff51411008 <+8>:  movq   (%rdi), %rax
     ->  0x7fff5141100b <+11>: testb  $0x4, 0x20(%rax)
         0x7fff5141100f <+15>: je     0x7fff5141101b            ; <+27>
         0x7fff51411011 <+17>: movl   $0x1, %esi
         0x7fff51411016 <+22>: jmp    0x7fff51411028            ; objc_object::sidetable_release(bool)
         0x7fff5141101b <+27>: movq   0x389f549e(%rip), %rsi    ; "release"
         0x7fff51411022 <+34>: jmpq   *0x36625268(%rip)         ; (void *)0x00007fff513f7780: objc_msgSend
     */
}

- (void)testAsyncSetAtomicProperty {
    for (NSInteger i = 0; i < 100000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.atomicText = [NSString stringWithFormat:@"abcdefghj%ld", (long)i];
        });
    }
    // atomic的不会闪退了，atomic保证读取的操作是原子性的，但是不保证数据是安全的，有可能一个线程读另外一个在写，那么就数据不同步了
    for (NSInteger i = 0; i < 100000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.atomicText;
        });
    }
}

- (void)testStringCompare {
    NSString *test = @"123";
    NSString *test1 = @"123";
    NSString *test2 = [NSString stringWithFormat:@"%@", test]; // Returns a string created by using a given format string as a template into which the remaining argument values are substituted.
    NSString *test3 = [NSString stringWithString:test]; // Returns a string created by copying the characters from another given string. 相当于copy，对于不可变得数据copy就是返回本身
    NSLog(@"test: %p, %@ class:%@", test, test, object_getClass(test));
    NSLog(@"test1: %p, %@ class:%@", test1, test1, object_getClass(test1));
    NSLog(@"test2: %p, %@ class:%@", test2, test2, object_getClass(test2));
    NSLog(@"test3: %p, %@ class:%@", test3, test3, object_getClass(test3));
    /*
     2020-10-29 14:22:06.726032+0800 RuntimeLearning[57636:1100791] test: 0x104a97410, 123 class:__NSCFConstantString
     2020-10-29 14:22:06.726273+0800 RuntimeLearning[57636:1100791] test1: 0x104a97410, 123 class:__NSCFConstantString
     2020-10-29 14:22:06.726493+0800 RuntimeLearning[57636:1100791] test2: 0xe8845fa5d1d42c14, 123 class:NSTaggedPointerString
     2020-10-29 14:22:06.726620+0800 RuntimeLearning[57636:1100791] test3: 0x104a97410, 123 class:__NSCFConstantString
     */
    if (test == test1) {
        NSLog(@"test == test1"); // ✅
    } else {
        NSLog(@"test not == test1");
    }
    if (test == test2) {
        NSLog(@"test == test2");
    } else {
        NSLog(@"test not == test2"); // ✅
    }
    if ([test isEqualToString:test2]) {
        NSLog(@"test isEqualToString test2"); // ✅
    } else {
        NSLog(@"test isNotEqualToString= test2");
    }
    if (test == test3) {
        NSLog(@"test == test3"); // ✅
    } else {
        NSLog(@"test not == test3");
    }
    // 假如不是taggedpointer 会相等吗
    NSString *anotherTest = @"123456789012";
    NSString *anotherTest1 = [NSString stringWithFormat:@"%@", anotherTest];
    NSLog(@"anotherTest: %p, %@ class:%@", anotherTest, anotherTest, object_getClass(anotherTest));
    NSLog(@"anotherTest1: %p, %@ class:%@", anotherTest1, anotherTest1, object_getClass(anotherTest1));
    /*
     anotherTest: 0x1050cc5b0, 123456789012 class:__NSCFConstantString
     anotherTest1: 0x6000004fe620, 123456789012 class:__NSCFString
     */
    if (anotherTest == anotherTest1) {
        NSLog(@"anotherTest == anotherTest1");
    } else {
        NSLog(@"anotherTest not == anotherTest1"); // ✅
    }
}

- (void)testStringFormat {
    for (NSInteger i = 0; i < 3; i++) {
        // NSInteger sex; // sex可能不为0
        NSInteger sex = 16; // 0就相当于nil不会崩溃，其他的值就会闪退，猜测%@会去从可变参数中读取对象
        NSString *sexString = [NSString stringWithFormat:@"%@", sex]; //  EXC_BAD_ACCESS (code=1, address=0x10)
        NSLog(@"sexString = %@", sexString);
    }
}

#pragma mark - Runtime部分

- (void)testClassSwizzle {
    [TestCategorySwizzle testClassMethod];
}

- (void)testUnsafeSwizzle {
    /* crash: 父类的testMethod的imp指向了子类的替换的实现；父类没法调用子类的方法导致异常*/
    @try {
        [[TestUnsafeSwizzle new] testMethod];
    } @catch (NSException *exception) {
        NSLog(@"exception = %@", exception);
    }
    
    /*手动调用load方法，swizzle了2次，相当于没有替换实现*/
    [SubTestUnsafeSwizzle load];
    [[SubTestUnsafeSwizzle new] testMethod];
    
    /*
     总结：
     1.为什么要在方法替换中加dispatch_once就是为了保证替换生效一次
     2.为什么方法替换要先addMethod，而不是直接替换实现，就是为了避免子类没有实现父类的方法，子类中做交换会改变父类原函数的实现指向（子类替换的实现），
       这样调用父类的方法时，实现指向子类的实现导致异常
     */
}

- (void)testCategorySwizzle {
     [[TestCategorySwizzle new] testCategorySwizzle];
    /*
     总结：
     1.类别的load方法调用顺序跟compile的先后顺序有关系
     2.Aspect的原理是替换了forwordInvocation，并且alais一个selector来执行，在设置的时机会执行block的回调
     */
}

- (void)testSubClassSwizzleMethod {
#define kSwizzleByInherit 0
#if !kSwizzleByInherit
    /*
     struct {TestBSubClassSwizzle.testSubClassSwizzle, b_testSubClassSwizzle.imp}
     struct {TestBSubClassSwizzle.b_testSubClassSwizzle, TestSubClassSwizzle.testSubClassSwizzle.imp}
     */
    [MethodSwizzleUtil swizzleInstanceMethodWithClass:[TestBSubClassSwizzle class] originalSel:@selector(testSubClassSwizzle) replacementSel:@selector(b_testSubClassSwizzle)];
    /*
     struct {TestASubClassSwizzle.testSubClassSwizzle, a_testSubClassSwizzle.imp}
     struct {TestASubClassSwizzle.a_testSubClassSwizzle, TestSubClassSwizzle.testSubClassSwizzle.imp}
     */
    [MethodSwizzleUtil swizzleInstanceMethodWithClass:[TestASubClassSwizzle class] originalSel:@selector(testSubClassSwizzle) replacementSel:@selector(a_testSubClassSwizzle)];
    /*
     struct {TestSubClassSwizzle.testSubClassSwizzle, s_testSubClassSwizzle.imp}
     struct {TestSubClassSwizzle.s_testSubClassSwizzle, TestSubClassSwizzle.testSubClassSwizzle.imp}
     */
    [MethodSwizzleUtil swizzleInstanceMethodWithClass:[TestSubClassSwizzle class] originalSel:@selector(testSubClassSwizzle) replacementSel:@selector(s_testSubClassSwizzle)];
#else
    /*
     struct {TestSubClassSwizzle.testSubClassSwizzle, s_testSubClassSwizzle.imp}
     struct {TestSubClassSwizzle.s_testSubClassSwizzle, testSubClassSwizzle.imp}
     */
    [MethodSwizzleUtil swizzleInstanceMethodWithClass:[TestSubClassSwizzle class] originalSel:@selector(testSubClassSwizzle) replacementSel:@selector(s_testSubClassSwizzle)];
    /*
     struct {TestASubClassSwizzle.testSubClassSwizzle, a_testSubClassSwizzle.imp}
     struct {TestASubClassSwizzle.a_testSubClassSwizzle, TestSubClassSwizzle.testSubClassSwizzle.imp}
     */
    [MethodSwizzleUtil swizzleInstanceMethodWithClass:[TestASubClassSwizzle class] originalSel:@selector(testSubClassSwizzle) replacementSel:@selector(a_testSubClassSwizzle)];
    /*
     struct {TestBSubClassSwizzle.testSubClassSwizzle, b_testSubClassSwizzle.imp}
     struct {TestBSubClassSwizzle.b_testSubClassSwizzle, TestASubClassSwizzle.testSubClassSwizzle.imp}
     */
    [MethodSwizzleUtil swizzleInstanceMethodWithClass:[TestBSubClassSwizzle class] originalSel:@selector(testSubClassSwizzle) replacementSel:@selector(b_testSubClassSwizzle)];
#endif
    [[TestBSubClassSwizzle new] testSubClassSwizzle];
    /*
     输出结果：
     kSwizzleWithInherit == 1
     2019-02-20 17:22:14.367353+0800 RuntimeLearning[11749:2242513] -[TestSubClassSwizzle testSubClassSwizzle]
     2019-02-20 17:22:14.367436+0800 RuntimeLearning[11749:2242513] -[TestASubClassSwizzle a_testSubClassSwizzle]
     2019-02-20 17:22:14.367497+0800 RuntimeLearning[11749:2242513] -[TestBSubClassSwizzle b_testSubClassSwizzle]
     kSwizzleWithInherit == 0
     2019-02-20 17:24:25.400826+0800 RuntimeLearning[11990:2245916] -[TestSubClassSwizzle testSubClassSwizzle]
     2019-02-20 17:24:25.400920+0800 RuntimeLearning[11990:2245916] -[TestBSubClassSwizzle b_testSubClassSwizzle]
     */
    /*
     总结
     按照继承链swizzle和不按照继承链swizzle，会产生不同的效果，所以我们会在load方法中做swizzle，利用了load的特性，父类load先于子类调用
     */
}

- (void)testDoSthWhenDealloc {
    UIScrollView *tmpView = [UIScrollView new];
    [tmpView addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    [tmpView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [tmpView hc_doSthWhenDeallocWithBlock:^(NSObject * _Nonnull target) {
        [target removeObserver:self forKeyPath:@"backgroundColor"];
        NSLog(@"removeObserver:forKeyPath:backgroundColor");
    }];
    [tmpView hc_doSthWhenDeallocWithBlock:^(NSObject * _Nonnull target) {
        [target removeObserver:self forKeyPath:@"frame"];
        NSLog(@"removeObserver:forKeyPath:frame");
    }];
    /*
     使用OBJC_ASSOCIATION_RETAIN设置关联对象会有一下异常
     'Cannot remove an observer <ViewController 0x7f97a5f05e60> for the key path "backgroundColor" from <UIScrollView 0x7f97a787b000> because it is not registered as an observer.'
     */
}

- (void)testSetWeakAssociation {
#define TestAssign 0
    // 系统的关联对象的Policy非强持有引用只有assign，没有weak这种的；
    // assign就有个问题，当关联的对象释放了，宿主对象再次获取就有问题，可能导致bad access异常
#if TestAssign
    static char kTestAssignKey;
    {
        {
            UILabel *associatedLabel = [UILabel new];
            objc_setAssociatedObject(self, &kTestAssignKey, associatedLabel, OBJC_ASSOCIATION_ASSIGN);
        }
        UILabel *label = objc_getAssociatedObject(self, &kTestAssignKey); // EXC_BAD_ACCESS
    }
#else
    // 如果关联对象也支持weak这种特性就好了，关联的对象释放了，自动置空，宿主对象再次获取拿到的是个nil
    static char kTestWeakKey;
    {
        {
            UILabel *associatedLabel = [UILabel new];
            objc_setWeakAssociatedObject(self, &kTestWeakKey, associatedLabel);
            //objc_setAssociatedObject(self, &kTestWeakKey, associatedLabel, OBJC_ASSOCIATION_ASSIGN);
            //objc_setAssociatedObject(self, &kTestWeakKey, nil, OBJC_ASSOCIATION_ASSIGN);
        }
        UILabel *label = objc_getAssociatedObject(self, &kTestWeakKey);
        NSLog(@"label = %@", label); // null
    }
#endif
}

- (void)testCategoryOveride {
    TestCategoryOveride *obj = [TestCategoryOveride new];
    // 通过类别调用未公开的方法
    [obj privateMethod];
    [obj log];
    // 类别的作用：
    // 1.给类增加方法-便于类的扩展以及功能的划分，可以根据功能来定义不同的类别
    // 2.给类增加属性
    // 3.不通过runtime-api来调用私有库的私有方法
}

- (void)testSwizzleInInitialize {
    TestSwizzleInInitializeA *tmpA = [TestSwizzleInInitializeA new];
    [tmpA testSwizzleMethod];
    /*输出*/
    /*
     2019-05-14 10:08:51.161443+0800 RuntimeLearning[42053:1082605] -[TestSwizzleInInitialize testSwizzleMethod]
     2019-05-14 10:08:51.161661+0800 RuntimeLearning[42053:1082605] -[TestSwizzleInInitializeA a_testSwizzleMethod]
     */
//    TestSwizzleInInitializeB *tmpB = [TestSwizzleInInitializeB new];
//    [tmpB testSwizzleMethod];
    
//    TestSwizzleInInitialize *tmp = [TestSwizzleInInitialize new];
//    [tmp testLogMethod];
    /*类别中的initialize会覆盖类中的，执行compile source的最后加入的类别的方法*/
}

- (void)logLibASLR {
    NSLog(@"www.dllhook.com\nDyld image count is: %d.\n", _dyld_image_count());
    for (int i = 0; i < _dyld_image_count(); i++) {
        char *image_name = (char *)_dyld_get_image_name(i);
        const struct mach_header *mh = _dyld_get_image_header(i);
        intptr_t vmaddr_slide = _dyld_get_image_vmaddr_slide(i);
        NSLog(@"Image name %s at address 0x%llx and ASLR slide 0x%lx.\n",
               image_name, (mach_vm_address_t)mh, vmaddr_slide);
    }
}

- (BOOL)checkHasInsertedDylib {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    // 没做任何注入的时候返回的是NULL??非越狱手机获取不到环境变量
    if (env == NULL) {
        return NO;
    }
    NSString *stringContent = [[NSString alloc] initWithCString:(const char* )env encoding:NSUTF8StringEncoding];
    NSLog(@"stringContent = %@", stringContent);
    // /Library/MobileSubstrate/MobileSubstrate.dylib
    return YES;
}

- (void)testCallStack {
    functionF();
}

- (void)testViewDidLoadCallStack {
    TestViewDidLoadCallStackViewController *vc = [TestViewDidLoadCallStackViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testClangTraceUsage {
    [TestSwift testSwiftMethod];
    
    [HCClangTrace generateOrderFile];
}

- (void)testHookInInitialize {
   [[SubHookMethodInInitialize new] methodToBeHooked];
}

- (void)testTaggedPointerUsage {
    [TestTaggedPointer new];
}

- (void)testWordAlignUsage {
    [ByteAlignmentTest new];
}

- (void)testFishhookUsage {
    [FishhookUsage new];
}

- (void)testDynamicCall {
    dynamicCallPrintfFunction();
    dynamicCallAddFunction();
    //int tmp = calculate_add(2, 5); // 动态库的方法调用 动态库需要dyld load_commonds加载动态库
    // 0x109812513 <+24>: callq  0x10981ec4e               ; symbol stub for: calculate_add
    //int tmp1 = static_calculate_add(2, 5);
    // 0x109812522 <+39>: callq  0x10981ebe0               ; static_calculate_add at TestStaticLib.m:13
}

- (void)changeInstanceClass {
    UIView *view = [UIView new];
    HCSwizzleHookInstance(view);
    NSLog(@"hook:\nself.class = %@ object_getClass(self) = %@", view.class, object_getClass(view));
    //HCObserveValueForKey(vc, @"backgroundColor");
    view.backgroundColor = [UIColor redColor];
    HCSwizzleUnhookInstance(view);
    NSLog(@"unhook:\n self.class = %@ object_getClass(self) = %@", view.class, object_getClass(view));
    
    ViewController *vc = [ViewController new];
    object_setClass(vc, [UIViewController class]);
    Class cls = [vc class];
    NSLog(@"cls = %@", cls);
    Class cls1 = object_getClass(vc);
    NSLog(@"cls1 = %@", cls1);
    if (cls == cls1) {
        NSLog(@"is Equal");
    } else {
        NSLog(@"not Equal");
    }
}

- (void)testSystemKVO {
    /*
     (lldb) po [NSKVONotifying_TestKVOObject _shortMethodDescription]
     <NSKVONotifying_TestKVOObject: 0x600001e558c0>:
     in NSKVONotifying_TestKVOObject:
         Instance Methods:
             - (void) setTestString:(id)arg1; (0x7fff207b5b57)
             - (Class) class; (0x7fff207b4662)
             - (void) dealloc; (0x7fff207b440b)
             - (BOOL) _isKVOA; (0x7fff207b4403)
     in TestKVOObject:
         Properties:
             @property (copy, nonatomic) NSString* testString;  (@synthesize testString = _testString;)
         Instance Methods:
             - (id) testString; (0x1071074f0)
             - (void) setTestString:(id)arg1; (0x107107540)
             - (void) dealloc; (0x107107490)
             - (void) .cxx_destruct; (0x1071075a0)
     (NSObject ...)

     dealloc的实现:
     (lldb) dis -s 0x7fff207b4403
     Foundation`NSKVODeallocate:
     
     
     _isKVOA的实现：
     (lldb) dis -s 0x7fff207b4403
     Foundation`NSKVOIsAutonotifying:
     (lldb) br set -a 0x7fff207b4403
     Breakpoint 51: where = Foundation`NSKVOIsAutonotifying, address = 0x00007fff207b4403
     
     hechao@hechaodeMacBook-Pro Foundation.framework % nm Foundation | grep '_isKVOA'
     00007fff207b5b4f t -[NSObject(NSKeyValueObserverNotifying) _isKVOA]
     查看伪代码NSObject的_isKVOA返回的是0，NSKVOIsAutonotifying返回的是1；但是断点发现在触发kvo的时候并没有调用该方法，暂不知道该函数的作用是干啥的
     
     setTestString的实现：
     dis -s 0x7fff207b5b57
     Foundation`_NSSetObjectValueAndNotify:
     
     
     class的实现：
     // 父类：
     (lldb) dis -s 0x1071074f0
         0x1071074f0: xorb   %bh, %bl
         0x1071074f2: pushq  %rsp
         0x1071074f3: cmpsb  %es:(%rdi), (%rsi)
     // KVO子类：
     (lldb) dis -s 0x7fff207b4662
     Foundation`NSKVOClass:
         0x7fff207b4662 <+0>:  pushq  %rbp
         0x7fff207b4663 <+1>:  movq   %rsp, %rbp
         0x7fff207b4666 <+4>:  pushq  %r15
         0x7fff207b4668 <+6>:  pushq  %r14
         0x7fff207b466a <+8>:  pushq  %rbx
         0x7fff207b466b <+9>:  pushq  %rax
         0x7fff207b466c <+10>: movq   %rsi, %r14
         0x7fff207b466f <+13>: movq   %rdi, %r15
         0x7fff207b4672 <+16>: callq  0x7fff2094a51a            ; symbol stub for: object_getClass
         0x7fff207b4677 <+21>: movq   %rax, %rbx
         0x7fff207b467a <+24>: movq   %rax, %rdi
         0x7fff207b467d <+27>: callq  0x7fff207b5b19            ; _NSKVONotifyingOriginalClassForIsa
     (lldb)
     */
    TestKVOObject *test = [TestKVOObject new];
    [test addObserver:self forKeyPath:@"testString" options:NSKeyValueObservingOptionNew context:nil];
    test.testString = @"testString";
    [test setValue:@"testValue" forKey:@"testString"]; // 属性kvc设置会触发kvo
    [test addObserver:self forKeyPath:@"testIvarString" options:NSKeyValueObservingOptionNew context:nil];
    [test setValue:@"testIvarValue" forKey:@"testIvarString"]; // ivar kvc设置也会触发kvo；可以猜测kvc的内部不仅仅是赋予了值，还会调用willChange、didChangeValueForKey
    /*
     在添加观察属性addObserver的时候，会判断是否支持kvo，如果支持的话会把属性对应的setter(setter方法是保存在一个全局的地方)方法给设置成成类似_NSSetObjectValueAndNotify且生成setter方法的时候会判断是否有set方法，有的话则替换掉实现，而
     在setValue:forKey的时候会去找缓存中是否有对应的setter方法，没有的话则去找set方法(有的话则根据encode赋予对应的set方法_NSSetObjectValueForKeyWithMethod)，再去找它的实例然后赋予对应encode的setIvar方法_NSSetObjectValueForKeyInIvar
     bt
     1.-[NSObject(NSKeyValueCoding) setValue:forKey:]
     2._NSSetUsingKeyValueSetter
        dis -s 0x7fff207b5c64 // _NSSetUsingKeyValueSetter其中的一个跳转指令
        Foundation`_NSSetObjectValueAndNotify:
     3._NSSetObjectValueAndNotify
     4.-[TestKVOObject didChangeValueForKey:]
     */
    [test setValue:nil forKey:@"testString"];
    [test setValue:nil forKey:@"testInteger"]; //  *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '[<TestKVOObject 0x600003f939a0> setNilValueForKey]: could not set nil as the value for the key testInteger.'
    /*
     setNilValueForKey有说明对于number和NSValue类型的，设置nil会抛出异常
     */
    [test setValue:nil forKey:@"testRange"]; // *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '[<TestKVOObject 0x60000135ac40> setNilValueForKey]: could not set nil as the value for the key testRange.'
    NSLog(@"test.testRange = %@", NSStringFromRange(test.testRange)); // test.testRange = {0, 0}
}

- (void)testKVO {
    NSLog(@"Before observe self.class = %@, object_getClass(self) = %@, metaClass = %@, imp = %p", self.class, object_getClass(self), object_getClass(object_getClass(self)), method_getImplementation(class_getInstanceMethod(object_getClass(self), @selector(setTestKVOString:))));
    HCObserveValueForKey(self, @"testKVOString");
    self.testKVOString = @"Test After Observe";
    NSLog(@"After observed self.class = %@, object_getClass(self) = %@, metaClass = %@, imp = %p", self.class, object_getClass(self), object_getClass(object_getClass(self)), method_getImplementation(class_getInstanceMethod(object_getClass(self), @selector(setTestKVOString:))));
    HCRemoveObserveValueForKey(self, @"testKVOString");
    NSLog(@"After remove observer self.class = %@, object_getClass(self) = %@, metaClass = %@ imp = %p",
          self.class, object_getClass(self), object_getClass(object_getClass(self)), method_getImplementation(class_getInstanceMethod(object_getClass(self), @selector(setTestKVOString:))));
    self.testKVOString = @"Test After Remove Observer";
    /*
     2020-12-11 17:02:09.371290+0800 RuntimeLearning[46613:1125464] Before observe self.class = ViewController, object_getClass(self) = ViewController, imp = 0x101031100
     2020-12-11 17:02:09.371716+0800 RuntimeLearning[46613:1125464] testKVOString: {
     }
     2020-12-11 17:02:09.371974+0800 RuntimeLearning[46613:1125464] After observed self.class = ViewController, object_getClass(self) = HC_HOOK_ViewController, imp = 0x101024b90
     2020-12-11 17:02:09.372474+0800 RuntimeLearning[46613:1125464] After remove observer self.class = ViewController, object_getClass(self) = HC_HOOK_ViewController, imp = 0x101031100
     */
    
    HCObserveValueForKey(self, @"testKVOString");
    self.testKVOString = @"Test After Observe Again";
    NSLog(@"After observed again self.class = %@, object_getClass(self) = %@, metaClass = %@, imp = %p", self.class, object_getClass(self), object_getClass(object_getClass(self)), method_getImplementation(class_getInstanceMethod(object_getClass(self), @selector(setTestKVOString:))));
    HCRemoveObserveValueForKey(self, @"testKVOString");
    NSLog(@"After remove observer again self.class = %@, object_getClass(self) = %@, metaClass = %@ imp = %p",
          self.class, object_getClass(self), object_getClass(object_getClass(self)), method_getImplementation(class_getInstanceMethod(object_getClass(self), @selector(setTestKVOString:))));
    self.testKVOString = @"Test After Remove Observer Again";
}

#pragma mark - Observer

- (void)testObserverProperty {
    HCObserveValueForKey(self, @"title");
    self.title = @"22222";
}

#pragma mark - 多线程

- (void)testDispatchOnceUsage {
    [DispatchOnceTest sharedInstance];
    [DispatchOnceTest sharedInstance];
}

- (void)testBarrierUsage {
    [DispatchBarrierTest new];
}

- (void)testDispatchGroupLeaveUsage {
    [DispatchGroupLeaveTest new];
}

- (void)dispatchExamnations {
    [DispatchExamnationTest new];
}

- (void)testDispatchBenchmark {
    testBenchmark();
}

- (void)testThreadFork {
    __unused pid_t mainPid = getpid();
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        int *statloc = NULL;
        __unused pid_t tmpPid = getpid();
        pid_t pid = wait(statloc);
        NSLog(@"pid_t = %d", (int)pid);
        testWaitUsage();
    });
}

#pragma mark - C Method

void testWaitUsage(void) {
    pid_t pc,pr;
    pc = fork();
    if(pc < 0) {
        NSLog(@"error ocurred!/n");
    } else if (pc == 0) {
        NSLog(@"This is child process with pid of %d/n", getpid());
        sleep(5);
    } else {
        pr = wait(NULL);
        NSLog(@"I catched a child process with pid of %d/n", pr);
    }
}

void testLogicNot(NSInteger times) {
    if (times == 0) {
        return;
    }
    CFAbsoluteTime totalCost = 0;
    for (NSInteger i = 0; i < times; i ++) {
        CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
        NSObject *test;
        for (NSInteger j = 0; j < 100000000; j ++) {
            if (!test) {
                
            }
        }
        totalCost += (CFAbsoluteTimeGetCurrent() - time);
        NSLog(@"time cost: %.4f", CFAbsoluteTimeGetCurrent() - time);
    }
    NSLog(@"average time cost: %.4f", totalCost / times);
    /*
     2019-07-13 10:07:36.597256+0800 RuntimeLearning[7885:8687005] time cost: 0.1631
     2019-07-13 10:07:36.764009+0800 RuntimeLearning[7885:8687005] time cost: 0.1666
     2019-07-13 10:07:36.927153+0800 RuntimeLearning[7885:8687005] time cost: 0.1630
     2019-07-13 10:07:37.095567+0800 RuntimeLearning[7885:8687005] time cost: 0.1683
     2019-07-13 10:07:37.256778+0800 RuntimeLearning[7885:8687005] time cost: 0.1611
     2019-07-13 10:07:37.412076+0800 RuntimeLearning[7885:8687005] time cost: 0.1552
     2019-07-13 10:07:37.577263+0800 RuntimeLearning[7885:8687005] time cost: 0.1650
     2019-07-13 10:07:37.732546+0800 RuntimeLearning[7885:8687005] time cost: 0.1552
     2019-07-13 10:07:37.901192+0800 RuntimeLearning[7885:8687005] time cost: 0.1685
     2019-07-13 10:07:38.061348+0800 RuntimeLearning[7885:8687005] time cost: 0.1600
     2019-07-13 10:07:38.225245+0800 RuntimeLearning[7885:8687005] time cost: 0.1638
     2019-07-13 10:07:38.383679+0800 RuntimeLearning[7885:8687005] time cost: 0.1583
     2019-07-13 10:07:38.550693+0800 RuntimeLearning[7885:8687005] time cost: 0.1669
     2019-07-13 10:07:38.715068+0800 RuntimeLearning[7885:8687005] time cost: 0.1642
     2019-07-13 10:07:38.886890+0800 RuntimeLearning[7885:8687005] time cost: 0.1717
     2019-07-13 10:07:39.041844+0800 RuntimeLearning[7885:8687005] time cost: 0.1548
     2019-07-13 10:07:39.203011+0800 RuntimeLearning[7885:8687005] time cost: 0.1610
     2019-07-13 10:07:39.362856+0800 RuntimeLearning[7885:8687005] time cost: 0.1597
     2019-07-13 10:07:39.523183+0800 RuntimeLearning[7885:8687005] time cost: 0.1602
     2019-07-13 10:07:39.677425+0800 RuntimeLearning[7885:8687005] time cost: 0.1541
     2019-07-13 10:07:39.677538+0800 RuntimeLearning[7885:8687005] average time cost: 0.1620
     */
}

void testLogicEqualNil(NSInteger times) {
    if (times == 0) {
        return;
    }
    CFAbsoluteTime totalCost = 0;
    for (NSInteger i = 0; i < 20; i ++) {
        CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
        NSObject *test;
        for (NSInteger j = 0; j < 100000000; j ++) {
            if (test == nil) {
                
            }
        }
        totalCost += (CFAbsoluteTimeGetCurrent() - time);
        NSLog(@"time cost: %.4f", CFAbsoluteTimeGetCurrent() - time);
    }
    NSLog(@"average time cost: %.4f", totalCost / times);
    /*
     2019-07-13 10:08:27.736487+0800 RuntimeLearning[7925:8688951] time cost: 0.1454
     2019-07-13 10:08:27.880481+0800 RuntimeLearning[7925:8688951] time cost: 0.1438
     2019-07-13 10:08:28.023278+0800 RuntimeLearning[7925:8688951] time cost: 0.1427
     2019-07-13 10:08:28.173704+0800 RuntimeLearning[7925:8688951] time cost: 0.1503
     2019-07-13 10:08:28.320942+0800 RuntimeLearning[7925:8688951] time cost: 0.1471
     2019-07-13 10:08:28.469281+0800 RuntimeLearning[7925:8688951] time cost: 0.1482
     2019-07-13 10:08:28.614297+0800 RuntimeLearning[7925:8688951] time cost: 0.1448
     2019-07-13 10:08:28.762971+0800 RuntimeLearning[7925:8688951] time cost: 0.1486
     2019-07-13 10:08:28.907184+0800 RuntimeLearning[7925:8688951] time cost: 0.1441
     2019-07-13 10:08:29.052712+0800 RuntimeLearning[7925:8688951] time cost: 0.1454
     2019-07-13 10:08:29.194756+0800 RuntimeLearning[7925:8688951] time cost: 0.1419
     2019-07-13 10:08:29.337975+0800 RuntimeLearning[7925:8688951] time cost: 0.1431
     2019-07-13 10:08:29.481757+0800 RuntimeLearning[7925:8688951] time cost: 0.1436
     2019-07-13 10:08:29.626273+0800 RuntimeLearning[7925:8688951] time cost: 0.1443
     2019-07-13 10:08:29.773237+0800 RuntimeLearning[7925:8688951] time cost: 0.1468
     2019-07-13 10:08:29.920283+0800 RuntimeLearning[7925:8688951] time cost: 0.1469
     2019-07-13 10:08:30.063997+0800 RuntimeLearning[7925:8688951] time cost: 0.1436
     2019-07-13 10:08:30.207566+0800 RuntimeLearning[7925:8688951] time cost: 0.1434
     2019-07-13 10:08:30.352019+0800 RuntimeLearning[7925:8688951] time cost: 0.1443
     2019-07-13 10:08:30.502022+0800 RuntimeLearning[7925:8688951] time cost: 0.1499
     2019-07-13 10:08:30.502139+0800 RuntimeLearning[7925:8688951] average time cost: 0.1454
     */
}

typedef struct my_va_list {
    int gp_offset;
    int fp_offset;
    void *overflow_arg_area;
    void *reg_save_area;
} *my_va_list_layout;

void testVAList(NSString *format, ...) {
    va_list va_list;
    va_start(va_list, format);
//    NSString *param = format;
//    while (param != nil) {
//        NSLog(@"&param = %p\n and param = %@", param, param);
//        param = va_arg(va_list, id);
//    }
    NSString *text = [[NSString alloc] initWithFormat:format arguments:va_list];
    va_end(va_list);
    NSLog(@"%@", text);
}

int addNumbers(int a, ...) {
    va_list va_list;
    int result = a;
    int param;
    my_va_list_layout va_layout = NULL;
    va_start(va_list, a);
    va_end(va_list);
    return result;
}

void testVAList1(NSString *format, ...) {
    va_list va_list;
//    NSString *param;
    if (format) {
        va_start(va_list, format);
//        while ((param = va_arg(va_list, NSString *))) {
//            NSLog(@"param = %@", param);
//        }
        NSString *text = [[NSString alloc] initWithFormat:format arguments:va_list];
        va_end(va_list);
        NSLog(@"testVAList1: %@", text);
    }
}


void testBenchmark(void) {
    NSInteger count = 1000, iterations = 100;
    NSString *obj = @"test";
    uint64_t t = dispatch_benchmark(iterations, ^{
        @autoreleasepool {
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (size_t i = 0; i < count; i++) {
                [mutableArray addObject:obj];
            }
        }
    });
    NSLog(@"[[NSMutableArray array] addObject:] Avg. Runtime: %llu ns", t);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TableDataSection *sectionData = [self.dataSource objectAtIndex:section];
    return sectionData.items.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderID];
    TableDataSection *sectionData = [self.dataSource objectAtIndex:section];
    headerView.textLabel.text = sectionData.title;
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    TableDataSection *sectionData = [self.dataSource objectAtIndex:indexPath.section];
    TableDataRow *item = [sectionData.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TableDataSection *sectionData = [self.dataSource objectAtIndex:indexPath.section];
    TableDataRow *item = [sectionData.items objectAtIndex:indexPath.row];
    if (item.action && [self respondsToSelector:item.action]) {
        ((void(*)(id, SEL))objc_msgSend)(self, item.action);
    }
}

#pragma mark - Getter && Setter

- (UITableView *)entryTableView {
    if (_entryTableView == nil) {
        _entryTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _entryTableView.delegate = self;
        _entryTableView.dataSource = self;
        _entryTableView.rowHeight = 44;
        _entryTableView.sectionHeaderHeight = 50;
        _entryTableView.estimatedSectionFooterHeight = 0;
        [_entryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
        [_entryTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderID];
    }
    
    return _entryTableView;
}


@end
