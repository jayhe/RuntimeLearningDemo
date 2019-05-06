//
//  RuntimeLearningMacro.h
//  RuntimeLearning
//
//  Created by hechao on 2019/5/6.
//  Copyright © 2019 hechao. All rights reserved.
//

#ifndef RuntimeLearningMacro_h
#define RuntimeLearningMacro_h

#define onExit \
__strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^ \

static void blockCleanUp(__strong void(^*block)(void)) {
    (*block)();
}
// RAC的项目动态调试需要使用通知的方式
#if DEBUG

#define RL_INJECT_NOTIFICATION(sel) \
[[NSNotificationCenter defaultCenter] addObserver:self \
selector:sel \
name:@"INJECTION_BUNDLE_NOTIFICATION" \
object:nil] \

#else

#define RL_INJECT_NOTIFICATION(sel) \

#endif

#endif /* RuntimeLearningMacro_h */
