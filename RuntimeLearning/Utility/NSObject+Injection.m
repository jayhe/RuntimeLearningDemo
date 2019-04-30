//
//  NSObject+Injection.m
//  RuntimeLearning
//
//  Created by hechao on 2019/4/30.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "NSObject+Injection.h"
#import <objc/runtime.h>

static char *kInjectExcuteBlockKey;

@implementation NSObject (Injection)

#if DEBUG

- (void)setInjectExcuteBlock:(void (^)(void))injectExcuteBlock {
    objc_setAssociatedObject(self, &kInjectExcuteBlockKey, injectExcuteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))injectExcuteBlock {
    return objc_getAssociatedObject(self, &kInjectExcuteBlockKey);
}

- (void)injected {
    if (self.injectExcuteBlock) {
        self.injectExcuteBlock();
    }
}

#endif
@end
