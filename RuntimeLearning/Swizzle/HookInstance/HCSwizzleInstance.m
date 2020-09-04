//
//  HCSwizzleInstance.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/5/22.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "HCSwizzleInstance.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>

#define kHCHookPrefix   @"hc_hook_"

@implementation HCSwizzleInstance

/*
 函数的runtime内部实现
 in file objc-class.mm
 Class object_getClass(id obj)
 {
     if (obj) return obj->getIsa();
     else return Nil;
 }
 
 Class object_setClass(id obj, Class cls)
 {
     if (!obj) return nil;

     // Prevent a deadlock between the weak reference machinery
     // and the +initialize machinery by ensuring that no
     // weakly-referenced object has an un-+initialized isa.
     // Unresolved future classes are not so protected.
     if (!cls->isFuture()  &&  !cls->isInitialized()) {
         // use lookUpImpOrForward to indirectly provoke +initialize
         // to avoid duplicating the code to actually send +initialize
         lookUpImpOrForward(cls, SEL_initialize, nil,
                            YES, YES, NO);
     }

     return obj->changeIsa(cls);
 }
 
 in file NSObject.mm
 
 + (Class)class {
     return self;
 }

 - (Class)class {
     return object_getClass(self);
 }

 + (Class)superclass {
     return self->superclass;
 }

 - (Class)superclass {
     return [self class]->superclass;
 }

 + (BOOL)isMemberOfClass:(Class)cls {
     return object_getClass((id)self) == cls;
 }

 - (BOOL)isMemberOfClass:(Class)cls {
     return [self class] == cls;
 }

 + (BOOL)isKindOfClass:(Class)cls {
     for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
         if (tcls == cls) return YES;
     }
     return NO;
 }

 - (BOOL)isKindOfClass:(Class)cls {
     for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
         if (tcls == cls) return YES;
     }
     return NO;
 }

 + (BOOL)isSubclassOfClass:(Class)cls {
     for (Class tcls = self; tcls; tcls = tcls->superclass) {
         if (tcls == cls) return YES;
     }
     return NO;
 }
 
 */

void HCSwizzleHookInstance(id instance) {
    Class originalClass = object_getClass(instance);
    if ([instance class] != originalClass) {
        // 已经hook过了
        return;
    }
    Class hookClass = objc_allocateClassPair(originalClass, HCHookClassName(originalClass), 0);
    if (!hookClass) {
        // The new class, or Nil if the class could not be created (for example, the desired name is already in use).
        hookClass = object_getClass(instance);
        if (hookClass) {
            object_setClass(instance, hookClass);
            return;
        }
    }
    unsigned int count;
    Method *mList = class_copyMethodList(originalClass, &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = mList[i];
        SEL selector = method_getName(method);
        if ([NSStringFromSelector(selector) hasPrefix:kHCHookPrefix]) {
            continue;
        }
        const char *mType = method_getTypeEncoding(method);
        IMP originImp = method_getImplementation(method);
        class_addMethod(hookClass, selector, originImp, mType);
//        class_addMethod(hookClass, selector, imp_implementationWithBlock(^(void){
//            return originImp;
//        }), mType);
        // TODO:trampoline 需要一个通用的跳板来hook所有的方法
    }
    free(mList);
    for (Class class in @[hookClass, object_getClass(hookClass)]) {
        SEL classSEL = @selector(class);
        Method oldMethod = class_getInstanceMethod(class, classSEL);
        // 由于类的class的内部实现直接返回的类（self）；实例对象的class内部实现是调用的object_getClass(self)
        // 我们修改实例的isa的话，如果不做处理，就会在需要unhook的时候无法知道原class
        // 所以我们这里将类以及实例的class方法hook掉返回原始的类，此时isa的值是修改之后的值
        class_replaceMethod(class, classSEL, imp_implementationWithBlock(^(void){
            return originalClass;
        }), method_getTypeEncoding(oldMethod));
    }
    objc_registerClassPair(hookClass);
    object_setClass(instance, hookClass);
}

void HCSwizzleUnhookInstance(id instance) {
    if ([instance class] != object_getClass(instance)) {
        object_setClass(instance, [instance class]);
    }
}

void HCObserveValueForKey(id instance, NSString *key) {
    if (!key || key.length == 0) {
        return;
    }
    HCSwizzleHookInstance(instance);
    NSString *firstCharacter = [key substringToIndex:1];
    NSString *tmpKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
    SEL setSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@:", tmpKey]);
    Method oldMethod = class_getInstanceMethod([instance class], setSelector);
    if (!oldMethod) {
        return;
    }
    const char *mType = method_getTypeEncoding(oldMethod);
    IMP originImp = method_getImplementation(oldMethod);
    class_replaceMethod([instance class], setSelector, imp_implementationWithBlock(^(void){
        [instance willChangeValueForKey:key];
        ((void(*)(id, SEL, id))originImp)(instance, setSelector, @"1111");
        [instance didChangeValueForKey:key];
    }), mType);
}

#pragma mark - Private Method

static const char *HCHookClassName(Class class) {
  return [kHCHookPrefix stringByAppendingString:NSStringFromClass(class)].UTF8String;
}

@end
