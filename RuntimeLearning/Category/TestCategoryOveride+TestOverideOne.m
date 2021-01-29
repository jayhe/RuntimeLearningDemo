//
//  TestCategoryOveride+TestOverideOne.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/3/16.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestCategoryOveride+TestOverideOne.h"

@implementation TestCategoryOveride (TestOverideOne)

+ (void)load {
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)log {
    NSLog(@"%s", __FUNCTION__);
}
#pragma clang diagnostic pop

@end
