//
//  UITextField+HCInputType.h
//  RuntimeLearning
//
//  Created by hechao on 2019/3/5.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HCTextFieldInputType) {
    HCTextFieldInputTypeDefault = 0, // 默认输入
    HCTextFieldInputTypePhoneNumber = 1, // 手机号码
    HCTextFieldInputTypeFormatedPhoneNumber, // 格式化的手机号（eg：150 1234 1234）
    HCTextFieldInputTypeFormatedCardNumber, // 格式化的卡号（4位1空格）
    HCTextFieldInputTypePrice, // 货币金额 限制金额通过设置kn_maxValue
    HCTextFieldInputTypeIdentityNo, // 身份证号码
    HCTextFieldInputTypeNumberAuthCode, // 验证码 限制位数通过设置hcui_limitLegnth
    HCTextFieldInputTypePaymentPWD, // 支付密码 限制位数通过设置hcui_limitLegnth
};

@interface UITextField (HCInputType)

@property (assign, nonatomic) HCTextFieldInputType hcui_inputType;
@property (assign, nonatomic) NSInteger hcui_limitLegnth;// 最大输入长度限制
@property (assign, nonatomic) double hcui_maxValue;// 最大输入值限制，在HCTextFieldInputTypePrice有效

- (BOOL)hcui_shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
