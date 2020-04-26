//
//  TestViewDidLoadCallStackViewController.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/4/26.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestViewDidLoadCallStackViewController : UIViewController

@end

@interface AddressInfo : NSObject

@property (nonatomic, copy) NSString *addressName;
@property (nonatomic, copy) NSString *addressNumber;
@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString *addressDesc;

- (void)logDescription;

@end

NS_ASSUME_NONNULL_END
