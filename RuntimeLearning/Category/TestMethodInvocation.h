//
//  TestMethodInvocation.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/3/14.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestMethodInvocation : NSObject

- (void)testKVCSetProperty;
- (void)testSetProperty;
- (void)testSetPropertyWhenChangeDeclareOrder;

@end

@interface TestMethodInvocation (Category)

@end

NS_ASSUME_NONNULL_END
