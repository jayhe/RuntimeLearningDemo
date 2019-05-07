//
//  DispatchGroupLeaveTest.m
//  RuntimeLearning
//
//  Created by hechao on 2019/5/7.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "DispatchGroupLeaveTest.h"

@implementation DispatchGroupLeaveTest

- (instancetype)init {
    self = [super init];
    if (self) {
        [self testGroupLeaveCrash];
    }
    
    return self;
}
// xcrun -sdk iphonesimulator clang -S DispatchGroupLeaveTest.m
- (void)testGroupLeaveCrash {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_leave(group);
    dispatch_group_leave(group); // "BUG IN CLIENT OF LIBDISPATCH: Unbalanced call to dispatch_group_leave()
}

@end
