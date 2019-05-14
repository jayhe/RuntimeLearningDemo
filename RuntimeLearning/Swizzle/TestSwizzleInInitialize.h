//
//  TestSwizzleInInitialize.h
//  RuntimeLearning
//
//  Created by hechao on 2019/5/14.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestSwizzleInInitialize : NSObject

- (void)testSwizzleMethod;
- (void)testLogMethod;
- (void)testTrackMethod;

@end

@interface TestSwizzleInInitializeA : TestSwizzleInInitialize

@end

@interface TestSwizzleInInitializeB : TestSwizzleInInitialize

@end

@interface TestSwizzleInInitialize (Log)

@end

@interface TestSwizzleInInitialize (Track)

@end

NS_ASSUME_NONNULL_END
