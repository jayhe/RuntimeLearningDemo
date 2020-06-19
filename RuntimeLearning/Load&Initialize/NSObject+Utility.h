//
//  NSObject+Utility.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/16.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct initailize_class {
    Class cls;
    IMP method;
};

typedef void (*initalize_imp)(id, SEL) ;

@interface NSObject (Utility)

struct initailize_class * _Nullable gatherClassMethodImps(Class gatherCls, SEL gatherSel, unsigned int *count);
void callClassMethods(Class cls, SEL callSel, IMP originalImp);

@end

NS_ASSUME_NONNULL_END
