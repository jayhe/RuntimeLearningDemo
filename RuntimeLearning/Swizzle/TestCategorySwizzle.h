//
//  TestCategorySwizzle.h
//  RuntimeLearning
//
//  Created by hechao on 2019/2/19.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCategorySwizzle : NSObject

+ (void)testClassMethod;
- (void)testCategorySwizzle;

@end

@interface TestCategorySwizzle (Log)

- (void)log_testCategorySwizzle;

@end

@interface TestCategorySwizzle (EventTrack)

- (void)track_testCategorySwizzle;

@end

@interface TestCategorySwizzle (ClassMethod)

@end

NS_ASSUME_NONNULL_END
