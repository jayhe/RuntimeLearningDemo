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

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) DynamicCallFunctionTest *dynamicFunctionTest;
@property (weak, nonatomic) IBOutlet UITextField *aTextFiled;
@property (nonatomic, strong) NSCacheTest *testCache;

@end

@implementation ViewController

//- (void)injected {
//    [self setupUI];
//}
/*
 static void _I_ViewController_viewDidLoad(ViewController * self, SEL _cmd) {
     ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("ViewController"))}, sel_registerName("viewDidLoad"));

     NSLog((NSString *)&__NSConstantStringImpl__var_folders_r0_4tb84bbj15j3kbzrnk8hqdwm0000gn_T_ViewController_85b4cc_mi_0, __FUNCTION__);
     id cls = ((Class (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("AddressInfo"), sel_registerName("class"));
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_r0_4tb84bbj15j3kbzrnk8hqdwm0000gn_T_ViewController_85b4cc_mi_1, &cls);
     id cls1 = ((Class (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("AddressInfo"), sel_registerName("class"));
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_r0_4tb84bbj15j3kbzrnk8hqdwm0000gn_T_ViewController_85b4cc_mi_2, &cls1);
     void *obj = &cls;
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_r0_4tb84bbj15j3kbzrnk8hqdwm0000gn_T_ViewController_85b4cc_mi_3, &obj);
     ((void (*)(id, SEL))(void *)objc_msgSend)((id)(__bridgeid)obj, sel_registerName("logDescription"));
     return;
 }
 
 RuntimeLearning`-[ViewController viewDidLoad]:
     0x10b6da030 <+0>:   pushq  %rbp
     0x10b6da031 <+1>:   movq   %rsp, %rbp
     0x10b6da034 <+4>:   subq   $0x60, %rsp
     0x10b6da038 <+8>:   movq   %rdi, -0x8(%rbp)
     0x10b6da03c <+12>:  movq   %rsi, -0x10(%rbp)
 ->  0x10b6da040 <+16>:  movq   -0x8(%rbp), %rsi
     0x10b6da044 <+20>:  movq   %rsi, -0x20(%rbp)
     0x10b6da048 <+24>:  movq   0x21a41(%rip), %rsi       ; (void *)0x000000010b6fc1e0: ViewController
     0x10b6da04f <+31>:  movq   %rsi, -0x18(%rbp)
     0x10b6da053 <+35>:  movq   0x211fe(%rip), %rsi       ; "viewDidLoad"
     0x10b6da05a <+42>:  leaq   -0x20(%rbp), %rdi
     0x10b6da05e <+46>:  callq  0x10b6ec6d8               ; symbol stub for: objc_msgSendSuper2
     0x10b6da063 <+51>:  leaq   0x19b06(%rip), %rsi       ; @"%s"
     0x10b6da06a <+58>:  movq   %rsi, %rdi
     0x10b6da06d <+61>:  leaq   0x14092(%rip), %rsi       ; "-[ViewController viewDidLoad]"
     0x10b6da074 <+68>:  movb   $0x0, %al
     0x10b6da076 <+70>:  callq  0x10b6ec4c2               ; symbol stub for: NSLog
     0x10b6da07b <+75>:  movq   0x2185e(%rip), %rsi       ; (void *)0x000000010b6fc208: AddressInfo
     0x10b6da082 <+82>:  movq   0x20f6f(%rip), %rdi       ; "class"
     0x10b6da089 <+89>:  movq   %rdi, -0x50(%rbp)
     0x10b6da08d <+93>:  movq   %rsi, %rdi
     0x10b6da090 <+96>:  movq   -0x50(%rbp), %rsi
     0x10b6da094 <+100>: callq  *0x18fce(%rip)            ; (void *)0x00007fff513f7780: objc_msgSend
     0x10b6da09a <+106>: movq   %rax, %rdi
     0x10b6da09d <+109>: callq  0x10b6ec6f0               ; symbol stub for: objc_retainAutoreleasedReturnValue
     0x10b6da0a2 <+114>: leaq   0x1ac27(%rip), %rsi       ; @"&cls = %p"
     0x10b6da0a9 <+121>: movq   %rax, -0x28(%rbp)
     0x10b6da0ad <+125>: movq   %rsi, %rdi
     0x10b6da0b0 <+128>: leaq   -0x28(%rbp), %rsi
     0x10b6da0b4 <+132>: movb   $0x0, %al
     0x10b6da0b6 <+134>: callq  0x10b6ec4c2               ; symbol stub for: NSLog
     0x10b6da0bb <+139>: movq   0x2181e(%rip), %rsi       ; (void *)0x000000010b6fc208: AddressInfo
     0x10b6da0c2 <+146>: movq   0x20f2f(%rip), %rdi       ; "class"
     0x10b6da0c9 <+153>: movq   %rdi, -0x58(%rbp)
     0x10b6da0cd <+157>: movq   %rsi, %rdi
     0x10b6da0d0 <+160>: movq   -0x58(%rbp), %rsi
     0x10b6da0d4 <+164>: callq  *0x18f8e(%rip)            ; (void *)0x00007fff513f7780: objc_msgSend
     0x10b6da0da <+170>: movq   %rax, %rdi
     0x10b6da0dd <+173>: callq  0x10b6ec6f0               ; symbol stub for: objc_retainAutoreleasedReturnValue
     0x10b6da0e2 <+178>: leaq   0x1ac07(%rip), %rsi       ; @"&cls1 = %p"
     0x10b6da0e9 <+185>: movq   %rax, -0x30(%rbp)
     0x10b6da0ed <+189>: movq   %rsi, %rdi
     0x10b6da0f0 <+192>: leaq   -0x30(%rbp), %rsi
     0x10b6da0f4 <+196>: movb   $0x0, %al
     0x10b6da0f6 <+198>: callq  0x10b6ec4c2               ; symbol stub for: NSLog
     0x10b6da0fb <+203>: leaq   0x1ac0e(%rip), %rsi       ; @"&obj = %p"
     0x10b6da102 <+210>: leaq   -0x28(%rbp), %rdi
     0x10b6da106 <+214>: movq   %rdi, -0x38(%rbp)
     0x10b6da10a <+218>: movq   %rsi, %rdi
     0x10b6da10d <+221>: leaq   -0x38(%rbp), %rsi
     0x10b6da111 <+225>: movb   $0x0, %al
     0x10b6da113 <+227>: callq  0x10b6ec4c2               ; symbol stub for: NSLog
     0x10b6da118 <+232>: movq   -0x38(%rbp), %rdi
     0x10b6da11c <+236>: movq   0x2113d(%rip), %rsi       ; "logDescription"
     0x10b6da123 <+243>: callq  *0x18f3f(%rip)            ; (void *)0x00007fff513f7780: objc_msgSend
     0x10b6da129 <+249>: xorl   %ecx, %ecx
     0x10b6da12b <+251>: movl   %ecx, %esi
     0x10b6da12d <+253>: leaq   -0x30(%rbp), %rdi
     0x10b6da131 <+257>: callq  0x10b6ec70e               ; symbol stub for: objc_storeStrong
     0x10b6da136 <+262>: xorl   %ecx, %ecx
     0x10b6da138 <+264>: movl   %ecx, %esi
     0x10b6da13a <+266>: leaq   -0x28(%rbp), %rdi
     0x10b6da13e <+270>: callq  0x10b6ec70e               ; symbol stub for: objc_storeStrong
     0x10b6da143 <+275>: addq   $0x60, %rsp
     0x10b6da147 <+279>: popq   %rbp
     0x10b6da148 <+280>: retq  
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s", __FUNCTION__);
    id cls = [AddressInfo class];
    NSLog(@"&cls = %p", &cls);
    id cls1 = [AddressInfo class];
    NSLog(@"&cls1 = %p", &cls1);
    void *obj = &cls;
    NSLog(@"&obj = %p", &obj);
    /*
    020-04-20 11:25:03.692657+0800 RuntimeLearning[11725:3284998] &cls = 0x7ffee5734fe8
    2020-04-20 11:25:03.692745+0800 RuntimeLearning[11725:3284998] &cls1 = 0x7ffee5734fe0
    2020-04-20 11:25:03.692847+0800 RuntimeLearning[11725:3284998] &obj = 0x7ffee5734fd8
    [AddressInfo class]这块块区域就在内存中。你要访问它 那么你得有钥匙。&cls就是一把钥匙；void *obj = &cls 就是相当于拷贝一个钥匙
    */
    [(__bridge id)obj logDescription];
//    return;
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"2222" forKey:@"111"]; // dict的hash返回的就是count
    [dict setValue:nil forKey:@"111"]; // 如果value是nil则内部调用remove CoreFoundation`-[__NSDictionaryM removeObjectForKey:]:
    
    [self testCacheUsage];
    [TestSwift testSwiftMethod];
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
    [HCClangTrace generateOrderFile];
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
    self.aTextFiled.hcui_inputType = HCTextFieldInputTypeIdentityNo;
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

#pragma mark - Cluster

- (void)testClassCluster {
    [TestClassCluster new];
}

#pragma mark - Cache

- (void)testCacheUsage {
    self.testCache = [NSCacheTest new];
    [self.testCache test];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [textField hcui_shouldChangeCharactersInRange:range replacementString:string];
}

@end


@implementation AddressInfo

- (void)logDescription {
    /*
     1. obj已经满足了构成一个objc对象的全部要求（首地址指向ClassObject），遂能够正常走消息机制；由于这个人造的对象在栈上，而取self.addressName的操作本质上是self指针在内存向高位地址偏移（64位下一个指针是8字节），按viewDidLoad执行时各个变量入栈顺序从高到底为（self, _cmd, self.class, self, obj）（前两个是方法隐含入参，随后两个为super调用的两个压栈参数），遂栈低地址的obj+8取到了self。
     2. [SomeClass class] 内部实现返回的是self；self转成指针，首地址就是isa的地址；对象的方法列表是在类的isa中
     3.
     // objc_msgSendSuper2() takes the current search class, not its superclass.
     OBJC_EXPORT id objc_msgSendSuper2(struct objc_super *super, SEL op, ...)
         __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_2_0);
     4.
     struct objc_super {
         /// Specifies an instance of a class.
         __unsafe_unretained id receiver;

         /// Specifies the particular superclass of the instance to message.
     #if !defined(__cplusplus)  &&  !__OBJC2__
         __unsafe_unretained Class class;
     #else
         __unsafe_unretained Class super_class;
     #endif
     };
     #endif
     */
    /*
     地址由高到低
     |self       |
     |_cmd       |
     |super_class|
     |self       |
     |obj        | <--- sp
     */
    NSLog(@"self.name = %@", self.addressName);
    // 2020-04-16 14:35:19.912864+0800 RuntimeLearning[63814:1887914] self.name = <ViewController: 0x7f96b170bdc0>
    NSLog(@"self.description = %@", self.description);
    // 2020-04-16 14:38:24.022511+0800 RuntimeLearning[63851:1890041] self.description = <AddressInfo: 0x7ffee3889fe8>
    NSLog(@"self.addressNumber = %@", self.addressNumber);
    // 2020-04-16 14:39:36.469594+0800 RuntimeLearning[63880:1891104] self.addressNumber = ViewController
    //NSLog(@"self.addressId = %@", self.addressId);
    // Thread 1: EXC_BAD_ACCESS (code=EXC_I386_GPFLT)
    NSLog(@"self.addressDesc = %@", self.addressDesc);
    // 2020-04-20 11:14:58.234131+0800 RuntimeLearning[11587:3275641] self.addressDesc = <ViewController: 0x7fdb8bc0f5c0>
}

@end
