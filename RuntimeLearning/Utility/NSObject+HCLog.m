//
//  NSObject+HCLog.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/4.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "NSObject+HCLog.h"
#import <objc/runtime.h>
/*
 objc runtime.h中的定义

struct objc_ivar {
    char * _Nullable ivar_name                               OBJC2_UNAVAILABLE;
    char * _Nullable ivar_type                               OBJC2_UNAVAILABLE;
    int ivar_offset                                          OBJC2_UNAVAILABLE;
#ifdef __LP64__
    int space                                                OBJC2_UNAVAILABLE;
#endif
}

 struct objc_method {
     SEL _Nonnull method_name                                 OBJC2_UNAVAILABLE;
     char * _Nullable method_types                            OBJC2_UNAVAILABLE;
     IMP _Nonnull method_imp                                  OBJC2_UNAVAILABLE;
 }
*/

typedef struct HCMethod {
    SEL _Nonnull method_name;
    char * _Nullable method_types;
    IMP _Nonnull method_imp;
} *HCMethodLayout;

@implementation NSObject (HCLog)

- (void)hc_logMethodListDescription {
    unsigned int count;
    Method *mList = class_copyMethodList(self.class, &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = mList[i];
        struct objc_method_description *description = method_getDescription(method);
        NSLog(@"Method: %@", NSStringFromSelector(description->name));
        //HCMethodLayout layout = (HCMethodLayout)method;
        //NSLog(@"Method Layout: method_name = %s method_imp = %s", layout->method_name, layout->method_imp);
    }
    free(mList);
}

- (void)hc_logIvarListDescription {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(self.class, &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSLog(@"Ivar: %@", [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding]);
    }
    free(ivarList);
}

@end
