//
//  TestCategoryOveride.h
//  RuntimeLearning
//
//  Created by hechao on 2019/3/5.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 测试如何当类别中覆盖了某方法之后，还能调用某方法
 */
@interface TestCategoryOveride : NSObject

- (void)log;

@end

NS_ASSUME_NONNULL_END
