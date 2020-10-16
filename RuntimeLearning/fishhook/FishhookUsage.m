//
//  FishhookUsage.m
//  RuntimeLearning
//
//  Created by 贺超 on 2019/12/26.
//  Copyright © 2019年 hechao. All rights reserved.
//

#import "FishhookUsage.h"
#import "calculate.h"
#import <objc/runtime.h>
#import <fishhook/fishhook.h>
#import <HCDynamicTest/HCDynamicTest.h>

static char kAssociatedKey;
static void (*system_objc_setAssociatedObject)(id _Nonnull object, const void * _Nonnull key,
                                               id _Nullable value, objc_AssociationPolicy policy);
static int (*libadd_calculate_add)(int a, int b);

@implementation FishhookUsage

- (instancetype)init {
    self = [super init];
    if (self) {
        //[self testHookCocoaFrameworkMethod];
        [self testHookSelfDefineDynamicFrameworkMethod];
    }
    
    return self;
}

#pragma mark - hook Cocoa框架中的C函数符号

- (void)testHookCocoaFrameworkMethod {
    NSLog(@"before objc_setAssociatedObject hook");
    objc_setAssociatedObject(self, &kAssociatedKey, @(111), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    struct rebinding rebindingStruct;
    rebindingStruct.name = "objc_setAssociatedObject";
    rebindingStruct.replacement = (void *)hook_objc_setAssociatedObject;
    rebindingStruct.replaced = (void **)&system_objc_setAssociatedObject;
    rebind_symbols(&rebindingStruct, 1);
    
    NSLog(@"after objc_setAssociatedObject hook");
    objc_setAssociatedObject(self, &kAssociatedKey, @(222), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

void hook_objc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key,
                                   id _Nullable value, objc_AssociationPolicy policy) {
    NSLog(@"%s", __FUNCTION__);
    system_objc_setAssociatedObject(object, key, value, policy);
}

#pragma mark - hook自定义的动态库中的C函数符号

- (void)testHookSelfDefineDynamicLibraryMethod {
#if TARGET_IPHONE_SIMULATOR
    int sum = calculate_add(2, 3);
    NSLog(@"before calculate_add hook: 2 + 3 = %d", sum);
    struct rebinding rebindingStruct;
    rebindingStruct.name = "calculate_add"; // HC_Login_Action
    rebindingStruct.replacement = (void *)hook_calculate_add;
    rebindingStruct.replaced = (void **)&libadd_calculate_add;
    rebind_symbols(&rebindingStruct, 1);
    
    int sum1 = calculate_add(2, 3);
    NSLog(@"after calculate_add hook: 2 + 3 = %d", sum1);
#endif
}

int hook_calculate_add(int a, int b) {
    NSLog(@"%s", __FUNCTION__);
    int sum = libadd_calculate_add(a, b);
    NSLog(@"正确的和是：%d", sum);
    return 100;
}

static char * (*lib_hc_aes)(char *someString);
static char * (*lib_hc_des)(char *someString);

- (void)testHookSelfDefineDynamicFrameworkMethod {
    char *aseString = hc_aes("123");
    NSLog(@"before hook ase:%s", aseString);
    struct rebinding rebindingStruct;
    //rebindingStruct.name = "hc_aes";
    rebindingStruct.name = "HC_112233";
    rebindingStruct.replacement = (void *)hook_hc_aes;
    rebindingStruct.replaced = (void **)&lib_hc_aes;
    __unused int rebindAESRet =  rebind_symbols(&rebindingStruct, 1);
    
    char *aseString1 = hc_aes("123");
    NSLog(@"after hook ase:%s", aseString1);
    
    
    char *desString = hc_des("123");
    NSLog(@"before hook des:%s", desString);
    struct rebinding rebindingStruct1;
    rebindingStruct1.name = "hc_des";
    rebindingStruct1.replacement = (void *)hook_hc_des;
    rebindingStruct1.replaced = (void **)&lib_hc_des;
    __unused int rebindDESRet = rebind_symbols(&rebindingStruct1, 1);
    
    char *desString1 = hc_des("123");
    NSLog(@"after hook des:%s", desString1);
}

char * hook_hc_aes(char *someString) {
    return "someString";
}

char * hook_hc_des(char *someString) {
    return "someString";
}

@end
