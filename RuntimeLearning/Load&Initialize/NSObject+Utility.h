//
//  NSObject+Utility.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/16.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct initailize_class {
    Class cls;
    IMP method;
};

typedef void (*initalize_imp)(id, SEL) ;

@interface NSObject (Utility)

struct initailize_class * _Nullable gatherClassMethodImps(Class gatherCls, SEL gatherSel, unsigned int *count);
// asm可以用到重命名符号:那是不是可以做一些关键函数的符号混淆
// 沿着继承链调用某个方法，排除掉自身
void callClassMethodsExceptSelfAlongChain(Class cls, SEL callSel, IMP originalImp) asm("HC_Call_Class_method");

@end

NS_ASSUME_NONNULL_END
