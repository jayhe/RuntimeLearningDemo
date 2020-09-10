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
#import "TestCategoryOveride+TestOveride.h"

@implementation TestCategoryOveride

+ (void)load {
    
}

+ (void)initialize {
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self callOriginalClassMethod];
        __unused BOOL isMeta = class_isMetaClass(object_getClass([NSObject class]));
        __unused BOOL isMineMeta = class_isMetaClass(object_getClass([self class])); // class->isa MetaClass
        Class cls = objc_getMetaClass("TestCategoryOveride");
        __unused BOOL isMeta1 = class_isMetaClass(cls);
        __unused BOOL responds = class_respondsToSelector(cls, @selector(log1));
        NSLog(@"cls responds to:%d", responds);
    }
    
    return self;
}

- (void)callOriginalClassMethod {
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
}

- (void)log {
    NSLog(@"orginal");
}

- (void)privateMethod {
    NSLog(@"privateMethod");
}

+ (void)log1 {
    NSLog(@"log1");
}

@end


