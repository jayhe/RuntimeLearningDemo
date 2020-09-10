//
//  HCTestProtocol.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/9/9.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HCTestProtocol <NSObject>

@property (nonatomic, copy) NSString *testName;

+ (NSString *)moduleName;

@end

#pragma mark - Modules

@protocol HCModuleATestProtocol <HCTestProtocol>


@end

@protocol HCModuleBTestProtocol <HCTestProtocol>


@end

#pragma mark - Test

@protocol HCTestAProtocol <HCModuleATestProtocol>


@end

@protocol HCTestBProtocol <HCModuleBTestProtocol>


@end

NS_ASSUME_NONNULL_END
