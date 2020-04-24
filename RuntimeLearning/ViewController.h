//
//  ViewController.h
//  RuntimeLearning
//
//  Created by hechao on 2019/2/20.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface AddressInfo : NSObject

@property (nonatomic, copy) NSString *addressName;
@property (nonatomic, copy) NSString *addressNumber;
@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString *addressDesc;

- (void)logDescription;

@end

