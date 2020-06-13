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

@interface AddressInfo1 : NSObject
// isa 8字节
@property (nonatomic, copy) NSString *addressName; // 8字节
@property (nonatomic, assign) int countryCode; // 4字节
@property (nonatomic, assign) int cityCode; // 4字节
//@property (nonatomic, assign) int provinceCode; // 4字节
/*
 case 1:
 [  isa                  ]
 [countryCode   cityCode ]
 [addressName            ]
 */

- (void)logDescription;

@end

NS_ASSUME_NONNULL_END
