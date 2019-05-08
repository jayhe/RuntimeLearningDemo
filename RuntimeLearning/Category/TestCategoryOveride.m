//
//  TestCategoryOveride.m
//  RuntimeLearning
//
//  Created by hechao on 2019/3/5.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestCategoryOveride.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation TestCategoryOveride

- (instancetype)init {
    self = [super init];
    if (self) {
        unsigned int count;
        Method *mList = class_copyMethodList(self.class, &count);
        unsigned int findIndex = 0;
        for (unsigned int i = 0; i < count; i++) {
            Method method = mList[i];
            struct objc_method_description *description = method_getDescription(method);
            NSLog(@"%@", NSStringFromSelector(description->name));
            if (description->name == @selector(log)) {
                findIndex = i;
            }
        }
        if (findIndex) {
            Method method = mList[findIndex];
            SEL selector = method_getName(method);
            IMP imp = method_getImplementation(method);
            ((void (*)(id, SEL))imp)(self,selector);//_objc_msgForward
            //            ((void (*)(id,SEL))objc_msgSend)(self, selector);
        }
        
        free(mList);
        
        __unused BOOL isMeta = class_isMetaClass(object_getClass([NSObject class]));
        Class cls = objc_getMetaClass("TestCategoryOveride");
        __unused BOOL isMeta1 = class_isMetaClass(cls);
        __unused BOOL responds = class_respondsToSelector(cls, @selector(log1));
    }
    
    return self;
}

- (void)log {
    NSLog(@"orginal");
}

+ (void)log1 {
    NSLog(@"log1");
}

@end

@interface TestCategoryOveride (TestOveride)


@end

@implementation TestCategoryOveride(TestOveride)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)log {
    NSLog(@"category");
}
#pragma clang diagnostic pop

@end
