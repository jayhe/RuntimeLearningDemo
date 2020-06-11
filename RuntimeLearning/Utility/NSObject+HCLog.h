//
//  NSObject+HCLog.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/4.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HCLog)

- (void)hc_logMethodListDescription;
- (void)hc_logIvarListDescription;

@end

NS_ASSUME_NONNULL_END
