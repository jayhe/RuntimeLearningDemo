//
//  HCTestProtocolImp.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/9/9.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "HCTestProtocolImp.h"

@implementation HCTestProtocolImp

// Auto property synthesis will not synthesize property 'testName' declared in protocol 'HCTestProtocol'
@synthesize testName;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.testName = @"testName";
    }
    
    return self;
}

+ (NSString *)moduleName {
    NSAssert(NO, @"sub class should overide moduleName");
    return nil;
}

@end

@implementation HCTestSubAProtocolImp

+ (NSString *)moduleName {
    return @"A";
}

@end

@implementation HCTestSubBProtocolImp

+ (NSString *)moduleName {
    return @"B";
}

@end
