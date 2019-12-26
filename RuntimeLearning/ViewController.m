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

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) DynamicCallFunctionTest *dynamicFunctionTest;
@property (weak, nonatomic) IBOutlet UITextField *aTextFiled;

@end

@implementation ViewController

//- (void)injected {
//    [self setupUI];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s", __FUNCTION__);
    [self testUnsafeSwizzle];
    [self testCategorySwizzle];
    [self testSubClassSwizzleMethod];
    [self testDoSthWhenDealloc];
    [self testCategoryOveride];
    [self testClassSwizzle];
    [self testSwizzleInInitialize];
    [self testAttributeUsage];
#if DEBUG
    injectBlock {
        [weakSelf setupUI];
    };
#endif
    [self testCopyUsage];
    [self testTextFieldUsage];
    [self testArrayReadWhileChange];
    [self testClassCluster];
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
//    [array addObject:@"1"];
//    NSObject *obj;
//    [array addObject:obj];//** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'
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
    functionF();
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"backgroundColor"]) {
        NSLog(@"backgroundColor: %@", change);
    }
}

#pragma mark - Private Methods

- (void)testAttributeUsage {
    [AttributeUsage new];
}

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

- (void)testCopyUsage {
    [[CopyUsage new] testCopyAndMutableCopy];
}

- (void)testTextFieldUsage {
    self.aTextFiled.delegate = self;
    self.aTextFiled.hcui_inputType = HCTextFieldInputTypeFormatedCardNumber;
    self.aTextFiled.hcui_limitLegnth = 19;
}

- (void)testArrayReadWhileChange {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 10; i ++) {
        [array addObject:[TestObj new]];
    }
    // 数组的枚举函数，遍历的时候在非尾部插入元素会异常。
    [array enumerateObjectsUsingBlock:^(TestObj *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // case1:遍历的时候修改元素【不会有问题】
            NSLog(@"%@", obj);
            [array replaceObjectAtIndex:3 withObject:[TestObj new]];
        
            // case2:遍历的时候添加元素及在尾部insert
//            [array addObject:@"added"];
//            NSLog(@"%@", obj); // 会一直输出，因为执行一次添加一个元素，一直添加；Executes a given block using each object in the array, starting with the first object and continuing through the array to the last object.
        
            // case3.1:遍历的时候在数组的某个index插入；eg：index == 0
//            [array insertObject:@"added" atIndex:0]; // EXC_BAD_ACCESS (code=EXC_I386_GPFLT)
//            NSLog(@"%@", obj);
            // case3.2:遍历的时候在数组的某个index插入；eg：index == （0, count) insert的index是数组的尾部 array.count则不会闪退
//            [array insertObject:@"added" atIndex:1]; //  EXC_BAD_ACCESS (code=1, address=0x1)
//            NSLog(@"%@", obj);
        
            // case4: 遍历的时候移除数组的元素；【不会有问题】
//            [array removeObjectAtIndex:0];
//            NSLog(@"%@", obj);
    }];
    // 在for in的循环中，如果只是修改数组内部引用的元素的属性则不会有问题，如果是修改了数组内部引用或者是改变数组的大小则会闪退
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for (id obj in array) {
            // case1:遍历的时候修改元素【 EXC_BAD_ACCESS (code=EXC_I386_GPFLT)】
//            [array replaceObjectAtIndex:0 withObject:[TestObj new]];
//            NSLog(@"%@", obj);
    
            // case2:遍历的时候添加元素及在尾部insert 【*** Collection <__NSArrayM: 0x6000003c0900> was mutated while being enumerated.'】
//            [array addObject:@"added"];
//            NSLog(@"%@", obj);
    
            // case3: 遍历的时候移除数组的元素；【同上】
//            [array removeObjectAtIndex:0];
//            NSLog(@"%@", obj); // EXC_BAD_ACCESS (code=1, address=0x4ca0af4303c8)
//        }
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

#pragma mark - Cluster

- (void)testClassCluster {
    [TestClassCluster new];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [textField hcui_shouldChangeCharactersInRange:range replacementString:string];
}

@end
