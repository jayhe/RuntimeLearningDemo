//
//  NSObject+HCWillDealloc.m
//  RuntimeLearning
//
//  Created by hechao on 2019/2/28.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "NSObject+HCWillDealloc.h"
#import <objc/runtime.h>

static char kHCAssociatedObjectKey;

@implementation NSObject (HCWillDealloc)
//TODO:如果多次调用该方法设置，应该是执行多个回调
- (void)hc_doSthWhenDeallocWithBlock:(HCBlock)block {
    if (block) {
        HCAssociatedObject *associatedObject = [[HCAssociatedObject alloc] initWithBlock:block target:self];
        objc_setAssociatedObject(self, &kHCAssociatedObjectKey, associatedObject, OBJC_ASSOCIATION_RETAIN);
    }
}

@end

@interface HCAssociatedObject ()
/*
 void *objc_destructInstance(id obj)
 {
 if (obj) {
 // Read all of the flags at once for performance.
 bool cxx = obj->hasCxxDtor();
 bool assoc = !UseGC && obj->hasAssociatedObjects();
 bool dealloc = !UseGC;
 
 // This order is important.
 if (cxx) object_cxxDestruct(obj);
 if (assoc) _object_remove_assocations(obj); // clear association
 if (dealloc) obj->clearDeallocating(); // clear weak and other
 }
 
 return obj;
 }
 */
@property (unsafe_unretained, nonatomic) NSObject *target;//这里不用weak是由于在target释放的时候，先释放关联对象，然后有weak引用会清除weak表数据，回调的地方拿到的就是nil了，使用unsafe_unretained
@property (copy, nonatomic) HCBlock deallocBlock;

@end

@implementation HCAssociatedObject

- (instancetype)initWithBlock:(HCBlock)block target:(NSObject *)target {
    self = [super init];
    if (self) {
        _deallocBlock = block;
        _target = target;
    }
    
    return self;
}

- (void)dealloc {
    _deallocBlock ? _deallocBlock(_target) : nil;
}

@end
