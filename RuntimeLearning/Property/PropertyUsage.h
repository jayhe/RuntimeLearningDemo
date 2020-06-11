//
//  PropertyUsage.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/4.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PropertyTestProtocol <NSObject>

@property (nonatomic, copy) NSString *addressFormate;

@end

@interface PropertyUsage : NSObject <PropertyTestProtocol>

@property (nonatomic, readonly, copy) NSString *address; //只会生成get方法+ivar不会生产set方法
@property (nonatomic, readwrite, strong) NSDate *subTest;
//@property (nonatomic, retain) NSObject *testRetainProperty;
@property (nonatomic, copy) NSArray *testCopyProperty;
@property (nonatomic, assign) NSObject *testAssignProperty;
@property (nonatomic, weak) NSObject *testWeakProperty;

- (void)testPropertyUsage;

@end

@interface PropertyUsage (TestCategory)

@property (nonatomic, strong) NSObject *categoryTest;

@end

@interface SubPropertyUsage : PropertyUsage

@property (nonatomic, strong) NSDate *subTest;

- (void)testSubClassPropertyUsage;

@end

NS_ASSUME_NONNULL_END
