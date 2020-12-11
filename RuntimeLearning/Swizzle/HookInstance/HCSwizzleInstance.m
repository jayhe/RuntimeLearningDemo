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
#import <libffi-iOS/ffi.h>

#define kHCHookPrefix   @"hc_hook_"

@interface HCKVOSetter : NSObject

- (void)testSetter:(id)obj;

@end

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
    _HCSwizzleHookInstance(instance, true);
}

void _HCSwizzleHookInstance(id instance, bool hookMethods) {
    Class originalClass = object_getClass(instance);
    if ([instance class] != originalClass) {
        // 已经hook过了
        return;
    }
    Class hookClass = objc_allocateClassPair(originalClass, HCHookClassName(originalClass), 0);
    if (!hookClass) {
        // The new class, or Nil if the class could not be created (for example, the desired name is already in use).
        hookClass = objc_getClass(HCHookClassName(originalClass));
        if (hookClass) {
            object_setClass(instance, hookClass);
            return;
        }
    }
    if (hookMethods) {
        // 这里如果需要对该实例的所有方法都做hook的话，比如用来记录一些执行的信息；那么就可以将方便列表遍历进行hook，但是需要一个统一的跳板来处理不同方法的不同参数及参数个数
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
            class_addMethod(hookClass, selector, imp_implementationWithBlock(^(void){
                return originImp;
            }), mType);
            // TODO:trampoline 需要一个通用的跳板来hook所有的方法
        }
        free(mList);
    }
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
    Class hookClass = object_getClass(instance);
    if ([instance class] != hookClass) {
        object_setClass(instance, [instance class]);
        //const char *name = class_getName(hookClass);
        //objc_duplicateClass(hookClass, name, 0);
    }
}

static void
trampolineCall(ffi_cif *cif, void *retp, void **args, void *user) {
  id obj;
  SEL sel;
  Class c;
  void (*imp)(id,SEL,void*);
    
  obj = (__bridge id)args[0];
  sel = *(SEL *)args[1];
  c = [obj class];
  imp = (void (*)(id,SEL,void*))[c instanceMethodForSelector: sel];
  ffi_call(cif, (void*)imp, retp, args);
}

#pragma mark - Test KVO

void HCObserveValueForKey(id instance, NSString *key) {
    if (!key || key.length == 0) {
        return;
    }
    _HCSwizzleHookInstance(instance, false);
    NSString *firstCharacter = [key substringToIndex:1];
    NSString *tmpKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
    SEL setSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@:", tmpKey]);
    Method oldMethod = class_getInstanceMethod([instance class], setSelector);
    if (!oldMethod) {
        return;
    }
    const char *mType = method_getTypeEncoding(oldMethod);
    /*
    IMP originImp = method_getImplementation(oldMethod);
    class_replaceMethod([instance class], setSelector, imp_implementationWithBlock(^(void){
        [instance willChangeValueForKey:key];
        ((void(*)(id, SEL, id))originImp)(instance, setSelector, @"1111");
        [instance didChangeValueForKey:key];
    }), mType);
    */
    Method hookImpMethod = class_getInstanceMethod(HCKVOSetter.class, @selector(testSetter:));
    IMP hookImp = method_getImplementation(hookImpMethod);
    if (class_addMethod(object_getClass(instance), setSelector, hookImp, mType) == NO) {
        class_replaceMethod(object_getClass(instance), setSelector, hookImp, mType);
    }
}

void HCRemoveObserveValueForKey(id instance, NSString *key) {
    // 这里应该将hook的setter方法的实现修改回去
    if (!key || key.length == 0) {
        return;
    }
    NSString *firstCharacter = [key substringToIndex:1];
    NSString *tmpKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
    SEL setSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@:", tmpKey]);
    Method oldMethod = class_getInstanceMethod([instance class], setSelector); // 拿到父类中的方法实现，也就是set方法
    Method hookedMethod = class_getInstanceMethod(object_getClass(instance), setSelector); // 拿到kvo类的方法
    if (!oldMethod) {
        return;
    }
    method_setImplementation(hookedMethod, method_getImplementation(oldMethod)); // 将kvo类的set方法的实现修改成之前的实现
}

#pragma mark - Private Method

static const char *HCHookClassName(Class class) {
  return [kHCHookPrefix stringByAppendingString:NSStringFromClass(class)].UTF8String;
}

@end

@implementation HCKVOSetter

static  NSString * _Nullable getKey(SEL cmd);

- (void)testSetter:(id)obj {
    NSString *key = getKey(_cmd);
    if (!key) {
        return;
    }
    Class cls = [self class];
    void (*imp)(id, SEL, id);
    Method originMethod = class_getInstanceMethod(cls, _cmd);
    imp = (void(*)(id, SEL, id))method_getImplementation(originMethod); // 拿到原始函数的imp
    if ([cls automaticallyNotifiesObserversForKey:key]) {
        //[self willChangeValueForKey:key]; // 走系统的那一套，找到observer去执行
        imp(self, _cmd, obj);
        //[self didChangeValueForKey:key];
        [self observeValueForKeyPath:key ofObject:obj change:@{} context:nil];
    } else {
        imp(self, _cmd, obj);
    }
}

NSString *getKey(SEL cmd) {
    //const char *selName = sel_getName(cmd);
    NSString *selString = NSStringFromSelector(cmd);
    if (!selString) {
        return nil;
    }
    NSString *lowerSelString = selString.lowercaseString;
    BOOL checkIsVaildSetter = [lowerSelString containsString:@"set"] && [lowerSelString containsString:@":"];
    if (!checkIsVaildSetter) {
        return nil;
    }
    
    NSRange setRange = [lowerSelString rangeOfString:@"set"];
    NSInteger keyStart = setRange.location + setRange.length;
    NSRange colonRange = [lowerSelString rangeOfString:@":"];
    NSInteger keyEnd = colonRange.location;
    if (keyEnd < keyStart) {
        return nil;
    }
    NSString *tmpKeyString = [selString substringWithRange:NSMakeRange(keyStart, keyEnd - keyStart)];
    NSString *firstCharacter = [tmpKeyString substringToIndex:1];
    NSString *key = [tmpKeyString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.lowercaseString];
    return key;
}

@end
