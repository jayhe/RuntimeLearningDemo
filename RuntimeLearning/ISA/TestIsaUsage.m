//
//  TestIsaUsage.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/12/10.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestIsaUsage.h"

@implementation TestIsaUsage

- (NSString *)debugDescription {
    [super debugDescription];
    [self callSomeFunc];
    return @"debugDescription";
}

- (void)callSomeFunc {
    
}

@end
