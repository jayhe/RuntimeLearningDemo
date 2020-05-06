//
//  KeychainUsage.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/5/6.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeychainUsage : NSObject

- (instancetype)initWithService:(nullable NSString *)service;
- (instancetype)initWithService:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;

- (void)testKeychainUsage;

@end

NS_ASSUME_NONNULL_END
