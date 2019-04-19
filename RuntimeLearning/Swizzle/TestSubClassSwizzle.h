//
//  TestSubClassSwizzle.h
//  RuntimeLearning
//
//  Created by hechao on 2019/2/20.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestSubClassSwizzle : NSObject

- (void)testSubClassSwizzle;
- (void)s_testSubClassSwizzle;

@end

@interface TestASubClassSwizzle : TestSubClassSwizzle

- (void)a_testSubClassSwizzle;

@end

@interface TestBSubClassSwizzle : TestASubClassSwizzle

- (void)b_testSubClassSwizzle;

@end

NS_ASSUME_NONNULL_END
