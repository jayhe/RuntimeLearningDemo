//
//  TestViewDidLoadCallStackViewController.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/4/26.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestViewDidLoadCallStackViewController.h"

@interface TestViewDidLoadCallStackViewController ()

@end

@implementation TestViewDidLoadCallStackViewController
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
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    id cls = [AddressInfo1 class];
    NSLog(@"&cls = %p", &cls);
    id cls1 = [AddressInfo1 class];
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

@implementation AddressInfo1

- (void)logDescription {
    NSLog(@"self.name = %@", self.addressName);
}

@end
