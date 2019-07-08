//
//  CopyUsage.h
//  RuntimeLearning
//
//  Created by hechao on 2019/7/3.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CopyUsage : NSObject

- (void)testCopyAndMutableCopy;

@end

NS_ASSUME_NONNULL_END

@interface TestObj : NSObject

@property (nonatomic, copy) NSString *name;

@end
