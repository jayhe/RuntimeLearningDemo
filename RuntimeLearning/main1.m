//
//  main.m
//  DCB
//
//  Created by 贺超 on 2020/8/26.
//  Copyright © 2020 贺超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <TargetConditionals.h>

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

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    BOOL isEncrypt = isEncrypted();
    NSLog(@"check is encrypt: %d", isEncrypt);
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
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
