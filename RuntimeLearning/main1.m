//
//  main.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/8/26.
//  Copyright © 2020 贺超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <TargetConditionals.h>
//#import "dobby.h"

//#if TARGET_IPHONE_SIMULATOR && !defined(LC_ENCRYPTION_INFO)
#if !defined(LC_ENCRYPTION_INFO)
#define LC_ENCRYPTION_INFO 0x21
struct encryption_info_command {
    uint32_t cmd;
    uint32_t cmdsize;
    uint32_t cryptoff;
    uint32_t cryptsize;
    uint32_t cryptid;
};
#endif

static BOOL isEncrypted(void);
void checkCodeSign(NSString *identifier, NSString *teamId); // 原来的方法
void (*originCheckCodeSign)(NSString *identifier, NSString *teamId); // 保留原始的方法实现的指针地址
void hookCheckCodeSign(NSString *identifier, NSString *teamId); // hook的方法

int main(int argc, char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        NSString * appDelegateClassName = NSStringFromClass([AppDelegate class]);
        BOOL isEncrypt = isEncrypted();
        NSLog(@"check is encrypt: %d", isEncrypt);
        // int DobbyHook(void *function_address, void *replace_call, void **origin_call);
        //DobbyHook(checkCodeSign, hookCheckCodeSign, (void *)&originCheckCodeSign);
        checkCodeSign(@"hc.RuntimeLearning.demo", @"9D7EH8PVAX"); // security find-identity -v -p CodeSigning 可以获取到，也可以在导出ipa包的plist中查看
        return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    }
}

static BOOL isEncrypted () {
    const struct mach_header *header;
    Dl_info dlinfo;

    /* Fetch the dlinfo for main() */
    if (dladdr(main, &dlinfo) == 0 || dlinfo.dli_fbase == NULL) {
        //NSLog(@"Could not find main() symbol (very odd)");
        return NO;
    }
    header = dlinfo.dli_fbase;

    /* Compute the image size and search for a UUID */
    struct load_command *cmd = (struct load_command *) (header+1);

    for (uint32_t i = 0; cmd != NULL && i < header->ncmds; i++) {
        /* Encryption info segment */
        if (cmd->cmd == LC_ENCRYPTION_INFO) { // 不知道真机会不会成立
            struct encryption_info_command *crypt_cmd = (struct encryption_info_command *) cmd;
            /* Check if binary encryption is enabled */
            if (crypt_cmd->cryptid < 1) {
                /* Disabled, probably pirated */
                return NO;
            }

            /* Probably not pirated <-- can't say for certain, maybe theres a way around it */
            return YES;
        }

        cmd = (struct load_command *) ((uint8_t *) cmd + cmd->cmdsize);
    }

    /* Encryption info not found */
    return NO;
}

void checkCodeSign(NSString *identifier, NSString *teamId) {
#if defined __x86_64__ || __i386__ // 模拟器不需要生成embeded.mobileprovision文件来做真机调试的配置
    // do nothing
#else
    // 描述文件路径
    NSString *embeddedPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:embeddedPath]) {
        return;
    }
    // 读取application-identifier  注意描述文件的编码要使用:NSASCIIStringEncoding
    NSString *embeddedProvisioning = [NSString stringWithContentsOfFile:embeddedPath encoding:NSASCIIStringEncoding error:nil];
    NSArray<NSString *> *embeddedProvisioningLines = [embeddedProvisioning componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (int i = 0; i < embeddedProvisioningLines.count; i++) {
        if ([embeddedProvisioningLines[i] rangeOfString:@"application-identifier"].location != NSNotFound) {
            NSString *identifierString = embeddedProvisioningLines[i + 1]; // 类似：<string>L2ZY2L7GYS.com.xx.xxx</string>
            NSRange fromRange = [identifierString rangeOfString:@"<string>"];
            NSInteger fromPosition = fromRange.location + fromRange.length;
            NSInteger toPosition = [identifierString rangeOfString:@"</string>"].location;
            NSRange range;
            range.location = fromPosition;
            range.length = toPosition - fromPosition;
            NSString *fullIdentifier = [identifierString substringWithRange:range];
            NSScanner *scanner = [NSScanner scannerWithString:fullIdentifier];
            NSString *teamIdString;
            [scanner scanUpToString:@"." intoString:&teamIdString];
            NSRange teamIdRange = [fullIdentifier rangeOfString:teamIdString];
            NSString *appIdentifier = [fullIdentifier substringFromIndex:teamIdRange.length + 1];
            // 对比签名teamID或者identifier信息
            if (![appIdentifier isEqualToString:identifier] || ![teamId isEqualToString:teamIdString]) {
                // exit(0)
                asm(
                    "mov X0,#0\n"
                    "mov w16,#1\n"
                    "svc #0x80"
                    );
            }
            break;
        }
    }
#endif
}

void hookCheckCodeSign(NSString *identifier, NSString *teamId) {
    // do nothing
    NSLog(@"%s", __FUNCTION__);
}
