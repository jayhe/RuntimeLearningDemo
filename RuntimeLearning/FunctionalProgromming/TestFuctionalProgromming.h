//
//  TestFuctionalProgromming.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/5/9.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestFuctionalProgromming : NSObject

- (TestFuctionalProgromming *(^)(NSInteger b))handleB;
- (TestFuctionalProgromming *(^)(NSInteger a))handleA;

@end

NS_ASSUME_NONNULL_END
