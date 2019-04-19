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

NS_ASSUME_NONNULL_END
