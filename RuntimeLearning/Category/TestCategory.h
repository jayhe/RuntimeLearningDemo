//
//  TestCategory.h
//  RuntimeLearning
//
//  Created by 贺超 on 2021/2/26.
//  Copyright © 2021 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCategory : NSObject

- (void)testSomeMethod;

@end

@interface TestCategory(Test1)

@end

NS_ASSUME_NONNULL_END
