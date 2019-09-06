//
//  TestTaggedPointer.m
//  RuntimeLearning
//
//  Created by hechao on 2019/8/19.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestTaggedPointer.h"
#import <objc/runtime.h>

@implementation TestTaggedPointer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self taggedPointerTest];
    }
    
    return self;
}

- (void)taggedPointerTest {
    NSMutableString *mutable = [NSMutableString string];
    NSString *immutable;
    char c = 'a';
    do {
        [mutable appendFormat: @"%c", c++];
        immutable = [mutable copy];
        NSLog(@"0x%6lx %@ %@", immutable, immutable, object_getClass(immutable));
    } while(((uintptr_t)immutable & 1) == 1);
}

@end
