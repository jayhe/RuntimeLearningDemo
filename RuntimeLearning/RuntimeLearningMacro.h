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

#endif /* RuntimeLearningMacro_h */
