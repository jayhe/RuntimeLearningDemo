//
//  BlockUsage.h
//  RuntimeLearning
//
//  Created by 贺超 on 2021/3/16.
//  Copyright © 2021 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 Block的学习
 @Discussion
 #1.捕获变量：
 @textblock
    局部变量
            static         传入指针
            auto           捕获值(基础数据类型传值，oc对象引用)
    全局变量                直接访问
            static/const
    成员变量                传入self(内部会有一个self class的对象引用self，引用类型跟修饰符有关)
    block变量              会生成block的结构体传入地址
 @/textblock
 #2.__block变量如何做到可以修改值:结构体内部有forwarding指针，forwarding是指向了自己，原对象的forwarding也会指向自己，达到堆和栈上使用的都是堆上的
 @code copy->forwarding = copy; // patch heap copy to point to itself
 src->forwarding = copy;  // patch stack to point to heap copy
 @endcode
 #3.block的循环引用产生原因：内部会有一个类的对象持有类的self，如果self持有block，那么就形成了相互持有，不打破这个环就无法释放
 @code
 BlockTest *self = __cself->self;
 @endcode
 #4.使用__weak就不会造成循环引用：内部会有一个类的对象是weak申明的，没有强引用
 @code
 BlockTest *__weak weakSelf = __cself->weakSelf; // bound by copy
 @endcode
 #5.block的几种类型
 @code
 法则：block内部有没有捕获变量 + 是否进行了强引用（strong修饰或者copy）
 GloablBlock -- 没有捕获外部变量 ： 1.不引用局部变量；2.内部引用了全局变量或者是静态变量或者常量
 MallocBlock -- 捕获了局部变量或者属性 and 被强引用[=号赋值操作]或者copy
 StackBlock  -- 捕获了局部变量或者属性 and 没有被强引用
 @endcode
 */
@interface BlockUsage : NSObject

- (void)excuteTestCase;

@end

NS_ASSUME_NONNULL_END
