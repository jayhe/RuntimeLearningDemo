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

void objc_setWeakAssociatedObject(id _Nonnull object, const void * _Nonnull key, id _Nullable value) {
    if (value) {
        //__weak typeof(object) weakObj = object;
        [value hc_doSthWhenDeallocWithBlock:^(NSObject *__unsafe_unretained  _Nonnull target) {
            objc_setAssociatedObject(object, key, nil, OBJC_ASSOCIATION_ASSIGN); // clear association
        }];
    }
    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_ASSIGN); // call system imp
}

@implementation NSObject (HCWillDealloc)

- (void)hc_doSthWhenDeallocWithBlock:(HCBlock)block {
    if (block) {
        // 这里尝试过设置一个HCBlock就生成一个HCAssociatedObject对象，然后将其追加到对象已有的NSMutableArray<HCAssociatedObject *>数组中，后面调试发现，在kvo remove observer的时候会crash；采用下面这种方式则没有该问题
        HCAssociatedObject *associatedObject = objc_getAssociatedObject(self, &kHCAssociatedObjectKey);
        if (!associatedObject) {
            associatedObject = [[HCAssociatedObject alloc] initWithTarget:self];
            objc_setAssociatedObject(self, &kHCAssociatedObjectKey, associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            // 这里用下面这句，在测试移除kvo的时候会异常。TODO：什么原因
            // objc_setAssociatedObject(self, &kHCAssociatedObjectKey, associatedObject, OBJC_ASSOCIATION_RETAIN);
        }
        [associatedObject addActionBlock:block];
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
@property (nonatomic, unsafe_unretained) NSObject *target;//这里不用weak是由于在target释放的时候，先释放关联对象，然后有weak引用会清除weak表数据，回调的地方拿到的就是nil了，使用unsafe_unretained
//@property (nonatomic, copy) HCBlock deallocBlock;
@property (nonatomic, strong) NSMutableArray<HCBlock> *deallocBlocks;

@end

@implementation HCAssociatedObject

- (instancetype)initWithTarget:(NSObject *)target {
    self = [super init];
    if (self) {
        _deallocBlocks = [NSMutableArray arrayWithCapacity:0];
        _target = target;
    }
    
    return self;
}

- (void)addActionBlock:(HCBlock)block {
    [self.deallocBlocks addObject:[block copy]];
}

//- (instancetype)initWithBlock:(HCBlock)block target:(NSObject *)target {
//    self = [super init];
//    if (self) {
//        _deallocBlock = block;
//        _target = target;
//    }
//
//    return self;
//}

- (void)dealloc {
    [_deallocBlocks enumerateObjectsUsingBlock:^(HCBlock  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj ? obj(_target) : nil;
    }];
}

@end
