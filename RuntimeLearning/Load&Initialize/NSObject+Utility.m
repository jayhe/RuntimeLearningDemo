//
//  NSObject+Utility.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/16.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "NSObject+Utility.h"
#import <objc/runtime.h>

/*
 + (Class)class {
     return self;
 }

 - (Class)class {
     return object_getClass(self);
 }
 
 Class object_getClass(id obj)
 {
     if (obj) return obj->getIsa();
     else return Nil;
 }
 */

@implementation NSObject (Utility)

struct initailize_class *gatherClassMethodImps(Class gatherCls, SEL gatherSel, unsigned int *count) {
    if (gatherCls == Nil || gatherSel == nil) {
        return nil;
    }
    struct initailize_class *initailize_classes = nil;
    int used = 0, allocated = 0;
    Class cls = gatherCls;
    // 沿着继承链去从类的ias即metaClass的方法列表中获取initialize方法并存储起来
    while (cls != NSObject.class) {
        unsigned int count = 0;
        Class gatherClsIsa = object_getClass(cls);
        Method *methodList = class_copyMethodList(gatherClsIsa, &count);
        for (unsigned int i = 0; i < count; i++) {
            Method method = methodList[i];
            SEL sel = method_getName(method);
            if (sel == gatherSel) {
                IMP imp = method_getImplementation(method);
                if (used == allocated) {
                    allocated = allocated * 2 + 16;
                    initailize_classes = (struct initailize_class *)realloc(initailize_classes, sizeof(struct initailize_class) * allocated);
                }
                initailize_classes[used].cls = cls;
                initailize_classes[used].method = imp;
                used++;
            }
        }
        
        free(methodList);
        cls = [cls superclass]; // class_getSuperclass(cls);
    }
    // 倒序一下，得到的是按照继承链从上到下的顺序
    struct initailize_class *reverse_initailize_classes = calloc(used, sizeof(struct initailize_class));
    for (NSInteger i = used - 1; i >= 0; i--) {
        reverse_initailize_classes[used - i - 1].cls = initailize_classes[i].cls;
        reverse_initailize_classes[used - i - 1].method = initailize_classes[i].method;
    }
    *count = used;
    free(initailize_classes);
    initailize_classes = nil;
    return reverse_initailize_classes;
}

void callClassMethodsExceptSelfAlongChain(Class cls, SEL callSel, IMP originalImp) {
    unsigned int count = 0;
    struct initailize_class *initailize_classes = gatherClassMethodImps(cls, @selector(initialize), &count);
    for (unsigned int i = 0; i < count; i ++) {
        struct initailize_class item = initailize_classes[i];
        if (item.method != originalImp) { // 过滤调调用者的方法
            initalize_imp imp = (initalize_imp)item.method;
            imp(item.cls, @selector(initialize));
        }
    }
    if (initailize_classes) {
        free(initailize_classes);
        initailize_classes = nil;
    }
    asm("");
}

@end
