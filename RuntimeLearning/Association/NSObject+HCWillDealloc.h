//
//  NSObject+HCWillDealloc.h
//  RuntimeLearning
//
//  Created by hechao on 2019/2/28.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HCBlock)(NSObject *target);

@interface NSObject (HCWillDealloc)

- (void)hc_doSthWhenDeallocWithBlock:(HCBlock)block;

@end

@interface HCAssociatedObject : NSObject

- (instancetype)initWithBlock:(HCBlock)block target:(NSObject *)target;

@end

NS_ASSUME_NONNULL_END
