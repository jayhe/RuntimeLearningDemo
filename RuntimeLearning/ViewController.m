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
#import "UIFont+Test.h"
#import "AttributeUsage.h"
#import "DynamicCallFunctionTest.h"
#import "NSObject+Injection.h"
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

static NSString *kCellID    = @"CELLID";
static NSString *kHeaderID  = @"HEADERID";

void testWaitUsage(void);
void testLogicNot(NSInteger times);
void testLogicEqualNil(NSInteger times);
void testVAList(NSString *format, NSString *format1, ...) NS_REQUIRES_NIL_TERMINATION;
void testVAList1(NSString *format, NSString *format1, ...) NS_NO_TAIL_CALL;
void testBenchmark(void);

@interface ViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DynamicCallFunctionTest *dynamicFunctionTest;
@property (nonatomic, strong) NSCacheTest *testCache;
@property (nonatomic, strong) UITableView *entryTableView;
@property (nonatomic, strong) NSMutableArray<TableDataSection*> *dataSource;

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
    NSLog(@"%s", __FUNCTION__);
#if DEBUG
    injectBlock {
        [weakSelf setupUI];
    };
#endif
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
//    [array addObject:@"1"];
//    NSObject *obj;
//    [array addObject:obj];//** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
//    [dict setObject:@"2222" forKey:@"111"]; // dict的hash返回的就是count
//    [dict setValue:nil forKey:@"111"]; // 如果value是nil则内部调用remove CoreFoundation`-[__NSDictionaryM removeObjectForKey:]:
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __FUNCTION__);
    self.view.backgroundColor = [UIColor lightGrayColor];
//    [NSThread sleepForTimeInterval:5];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __FUNCTION__);
//    [NSThread sleepForTimeInterval:2];
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"backgroundColor"]) {
        NSLog(@"backgroundColor: %@", change);
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
        section0.items = @[
            row0,
            row1,
            row2,
            row3,
            row4,
            row5,
            row6,
            row7,
            row8].mutableCopy;
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
            row12].mutableCopy;
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
        section2.items = @[
                   row0,
                   row1].mutableCopy;
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
    testVAList(@"%@, %@", @"0", @"1", @"11", nil);
    // testVAList1(@"%@, %@", @"0", @"1", @"11");
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
    __weak typeof(self) weakSelf = self;
    [tmpView hc_doSthWhenDeallocWithBlock:^(NSObject * _Nonnull target) {
        __strong typeof(target) strongTarget = target;
        [strongTarget removeObserver:weakSelf forKeyPath:@"backgroundColor"];
    }];
}

- (void)testCategoryOveride {
    [TestCategoryOveride new];
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

void testVAList(NSString *format, NSString *format1, ...) {
    va_list va_list;
    va_start(va_list, format1);
    NSString *param = format1;
    while (param != nil) {
        NSLog(@"&param = %p\n and param = %@", param, param);
        param = va_arg(va_list, id);
    }
    va_end(va_list);
}

void testVAList1(NSString *format, NSString *format1, ...) {
    va_list va_list;
    va_start(va_list, format1);
    NSString *param = format1;
    while (param != nil) {
        NSLog(@"&param = %p\n and param = %@", param, param);
        param = va_arg(va_list, id);
    }
    va_end(va_list);
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

@implementation TableDataSection


@end

@implementation TableDataRow

- (void)dealloc {
    _action = nil;
}

@end
