//
//  DynamicCallFunctionTest.m
//  RuntimeLearning
//
//  Created by hechao on 2019/4/29.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "DynamicCallFunctionTest.h"
#import "NSObject+HCInjection.h"
#import <dlfcn.h>

@interface DynamicCallFunctionTest ()

@end

@implementation DynamicCallFunctionTest

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injected) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
//        injectBlock {
//            [weakSelf testInject];
//        };
    }
    
    return self;
}

typedef void (*printf_pointer) (const char *restrict, ...);
typedef int (*add_pointer) (int a, int b);

void dynamicCallPrintfFunction(void) {
    //动态库路径
    const char *dylib_path = "/usr/lib/libSystem.dylib";
    //打开动态库
    void *handle = dlopen(dylib_path, RTLD_GLOBAL | RTLD_NOW); // 1.获取句柄
    //void *handle = dlopen(NULL, RTLD_GLOBAL | RTLD_NOW); //传个NULL也可以
    if (handle == NULL) {
        //打开动态库出错
        fprintf(stderr, "%s\n", dlerror());
    } else {
        //获取 printf 地址
        printf_pointer printf_func = dlsym(handle, "printf"); // 2.根据函数符号获取函数指针
        //地址获取成功则调用
        if (printf_func) {
            printf_func("%s\n", "dynamicCallFunction"); // 3.通过指针调用方法
        }
        dlclose(handle); //关闭句柄
    }
}

void dynamicCallAddFunction(void) {
    // 手动把lib拖到documents中模拟一下
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/libadd.a", NSHomeDirectory()];
    const char *dylib_path = [filePath cStringUsingEncoding:NSUTF8StringEncoding];
    void *handle = dlopen(dylib_path, RTLD_LOCAL | RTLD_NOW);
    if (handle == NULL) {
        fprintf(stderr, "%s\n", dlerror());
    } else {
        add_pointer add_func = dlsym(handle, "add");
        if (add_func) {
            printf("%d\n", add_func(10, 12));
        }
    }
}

- (void)injected {
    NSLog(@"injected: %@", self);
    [self testInject];
}

- (void)testInject {
    dynamicCallAddFunction();
}

@end
