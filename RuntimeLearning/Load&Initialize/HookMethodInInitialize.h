//
//  HookMethodInInitialize.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/16.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 父类
@interface SuperHookMethodInInitialize : NSObject
// 需要被hook的方法
- (void)methodToBeHooked;

@end
/// 本类
@interface HookMethodInInitialize : SuperHookMethodInInitialize

@end
/// 子类
@interface SubHookMethodInInitialize : HookMethodInInitialize

@end
/// 分类A
@interface HookMethodInInitialize(CategoryA)

@end
/// 分类B
@interface HookMethodInInitialize(CategoryB)

@end
/// 分类C
@interface HookMethodInInitialize(CategoryC)

@end

NS_ASSUME_NONNULL_END
