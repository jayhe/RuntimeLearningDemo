//
//  NSObject+Safe.h
//  RuntimeLearning
//
//  Created by hechao on 2019/1/29.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 在release模式下，当收到unrecognized selector异常的时候，转发selector为nilMessage，防止闪退
 */
@interface NSObject (RLSafe)

@end

// 这里也可以参照系统的返回一个NSException对象，可以包含调用的堆栈信息；往往项目中如果自己处理这些信息的话，会按照自己的格式去采集异常堆栈信息，这里就返回一个函数的描述；可以在自定义handler内部再采集异常堆栈信息然后按照格式拼装数据上传
typedef void RLUnrecognizedSelectorExceptionHandler(NSDictionary<NSString *, NSString *> *unrecognizedSelectorInfo);
FOUNDATION_EXPORT NSString const *RLUnrecognizedSelectorMessageKey; // unrecognizedSelectorInfo对应的key

FOUNDATION_EXPORT RLUnrecognizedSelectorExceptionHandler * _Nullable RLGetUnrecognizedSelectorExceptionHandler(void);
FOUNDATION_EXPORT void RLSetUnrecognizedSelectorExceptionHandler(RLUnrecognizedSelectorExceptionHandler * _Nullable);

@protocol RLCatchUnrecognizedSelectorProtocol <NSObject>

@optional
/// 默认是YES：不实现则当作YES
- (BOOL)shouldCatch;

@end



NS_ASSUME_NONNULL_END
