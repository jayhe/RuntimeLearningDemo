//
//  HCHook.m
//  HCInject
//
//  Created by 贺超 on 2021/1/13.
//  Copyright © 2021 hechao. All rights reserved.
//

#import "HCHook.h"
#import <Dobby/dobby.h>
#import <mach-o/dyld.h>

void (*originCheckCodeSign)(NSString *identifier, NSString *teamId); // 保留原始的方法实现的指针地址
void hookCheckCodeSign(NSString *identifier, NSString *teamId); // hook的方法

@implementation HCHook

+ (void)load {
    //static uintptr_t checkCodeSignOffset = 0x1000164A0; // 这个偏移地址可以通过MachOView去查看
    static uintptr_t checkCodeSignOffset = 0x1000165B0; // 修改了代码，调整文件的编译顺序之后这个值会变化，所以这个值是需要从MachO文件的__TEXT,__text中去查找
    uintptr_t mainASLR = _dyld_get_image_vmaddr_slide(0); // 获取主程序的aslr，因为checkCodeSign函数在主程序
    uintptr_t checkCodeSignAddress = mainASLR + checkCodeSignOffset;
    DobbyHook((void *)checkCodeSignAddress, hookCheckCodeSign, (void *)&originCheckCodeSign);
}

void hookCheckCodeSign(NSString *identifier, NSString *teamId) {
    // do nothing
    NSLog(@"%s", __FUNCTION__);
}

@end
