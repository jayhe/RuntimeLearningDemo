//
//  TestCategoryOveride+TestOveride.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/3/13.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestCategoryOveride+TestOveride.h"

@implementation TestCategoryOveride(TestOveride)

+ (void)load {
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)log {
    NSLog(@"%s", __FUNCTION__);
}
#pragma clang diagnostic pop

@end
