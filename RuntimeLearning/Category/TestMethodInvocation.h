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

@property (nonatomic, readonly, copy) NSString *address; //只会生成get方法+ivar不会生产set方法

- (void)testKVCSetProperty;
- (void)testSetProperty;
- (void)testSetPropertyWhenChangeDeclareOrder;

@end

@interface TestMethodInvocation (Category)

@end

NS_ASSUME_NONNULL_END
