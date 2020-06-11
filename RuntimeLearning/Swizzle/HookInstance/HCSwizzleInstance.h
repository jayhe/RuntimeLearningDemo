//
//  HCSwizzleInstance.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/5/22.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCSwizzleInstance : NSObject

void HCSwizzleHookInstance(id instance);
void HCSwizzleUnhookInstance(id instance);
// test
//void HCObserveValueForKey(id instance, NSString *key);

@end

NS_ASSUME_NONNULL_END
