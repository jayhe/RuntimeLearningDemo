//
//  TestUnsafeSwizzle.h
//  RuntimeLearning
//
//  Created by hechao on 2019/2/18.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestUnsafeSwizzle : NSObject

- (void)testMethod;

@end

@interface SubTestUnsafeSwizzle : TestUnsafeSwizzle

@end

NS_ASSUME_NONNULL_END
