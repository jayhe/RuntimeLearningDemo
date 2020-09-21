//
//  NSObject+HCWillDealloc.h
//  RuntimeLearning
//
//  Created by hechao on 2019/2/28.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 设置关联对象不支持weak的方式
/// @param object 宿主对象
/// @param key 关联key
/// @param value 关联的对象
extern void objc_setWeakAssociatedObject(id _Nonnull object, const void * _Nonnull key, id _Nullable value);

typedef void(^HCBlock)(__unsafe_unretained NSObject *target);

/// 这个类主要是实现一些Association的应用场景
@interface NSObject (HCWillDealloc)

- (void)hc_doSthWhenDeallocWithBlock:(HCBlock)block;

@end

@interface HCAssociatedObject : NSObject

- (instancetype)initWithTarget:(NSObject *)target;
//- (instancetype)initWithBlock:(HCBlock)block target:(NSObject *)target;
- (void)addActionBlock:(HCBlock)block;

@end

NS_ASSUME_NONNULL_END
