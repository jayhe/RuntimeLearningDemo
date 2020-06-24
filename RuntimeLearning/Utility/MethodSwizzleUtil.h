//
//  MethodSwizzleUtil.h
//  RuntimeLearning
//
//  Created by hechao on 2019/2/19.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MethodSwizzleUtil : NSObject

+ (void)swizzleInstanceMethodWithClass:(Class)clazz originalSel:(SEL)original replacementSel:(SEL)replacement;
+ (void)swizzleClassMethodWithClass:(Class)clazz originalSel:(SEL)original replacementSel:(SEL)replacement;

@end

NS_ASSUME_NONNULL_END
