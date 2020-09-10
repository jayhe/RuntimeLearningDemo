//
//  TestCategoryOveride+TestOveride.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/3/13.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestCategoryOveride.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCategoryOveride (TestOveride)

// 测试类别将私有方法公开化，比如第三方的库中的私有方法，我们要调用就是使用performSelector或者objc_msgSend的方式
- (void)privateMethod;

@end

NS_ASSUME_NONNULL_END
