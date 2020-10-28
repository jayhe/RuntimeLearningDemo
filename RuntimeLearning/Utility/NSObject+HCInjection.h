//
//  NSObject+Injection.h
//  RuntimeLearning
//
//  Created by hechao on 2019/4/30.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG

#define injectBlock \
typeof(self) weakSelf = self; \
self.injectExcuteBlock = ^ \

#else

#define injectBlock \
typeof(self) weakSelf = nil; \
__weak void(^unusedBlock)(void) = ^ \

#endif

@interface NSObject (HCInjection)
#if DEBUG
@property (nonatomic, strong) void(^injectExcuteBlock)(void);
#endif
@end

NS_ASSUME_NONNULL_END
