//
//  UITextField+HCInputType.h
//  RuntimeLearning
//
//  Created by hechao on 2019/3/5.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "UITextField+HCInputType.h"
#import "objc/runtime.h"

static char HC_INPUTED_TYPE;
static char HC_INPUTED_LIMIT_LENGTH;
static char HC_INPUTED_MAX_VALUE;

@implementation UITextField (KNInputType)

#pragma mark - Custom Method

- (BOOL)hcui_shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    switch (self.hcui_inputType) {
        case HCTextFieldInputTypeDefault:
            return YES;
        case HCTextFieldInputTypePhoneNumber: {
            return [self hcui_phoneNumberCheckWithString:string];
        }
        case HCTextFieldInputTypeFormatedPhoneNumber: {
            return [self hcui_formatedPhoneNumberCheckWithString:string range:range];
        }
        case HCTextFieldInputTypeFormatedCardNumber: {
            return [self hcui_formatedCardCheckWithString:string range:range];
        }
        case HCTextFieldInputTypePrice: {
            return [self hcui_priceCheckWithString:string range:range];
        }
        case HCTextFieldInputTypeIdentityNo: {
            return [self hcui_identityNumberCheckWithString:string];
        }
        case HCTextFieldInputTypeNumberAuthCode: {
            return [self hcui_authCodeCheckWithString:string range:range];
        }
        case HCTextFieldInputTypePaymentPWD: {
            return [self hcui_paymentPWDCheckWithString:string];
        }
        default:
            return YES;
    }
}

#pragma mark - Private Method

- (void)configKeyboardType {
    switch (self.hcui_inputType) {
        case HCTextFieldInputTypeDefault:
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        case HCTextFieldInputTypePhoneNumber:
        case HCTextFieldInputTypeFormatedCardNumber:
        case HCTextFieldInputTypePaymentPWD:
        case HCTextFieldInputTypeFormatedPhoneNumber:
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case HCTextFieldInputTypePrice:
            self.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case HCTextFieldInputTypeNumberAuthCode:
            self.keyboardType = UIKeyboardTypeASCIICapable;
            break;
        case HCTextFieldInputTypeIdentityNo: {
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters; // 输入身份证那个大写的X
        }
            break;
        default:
            self.keyboardType = UIKeyboardTypeDefault;
            break;
    }
}

- (BOOL)hcui_phoneNumberCheckWithString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (self.text.length < 11) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)hcui_formatedPhoneNumberCheckWithString:(NSString *)string range:(NSRange)range {
    return [self _hcui_formatedNumberCheckWithString:string range:range];
}

- (BOOL)hcui_identityNumberCheckWithString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (self.text.length < 18) {
        if (self.text.length < 17) {
            NSString *regex = @"[0-9]";
            BOOL isMatched = [self hcui_predicateString:string withRegex:regex];
            return isMatched;
        } else {
            NSString *regex = @"[0-9X]";
            BOOL isMatched = [self hcui_predicateString:string withRegex:regex];
            return isMatched;
        }
    } else {
        return NO;
    }
}

- (BOOL)hcui_priceCheckWithString:(NSString *)string range:(NSRange)range {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([string isEqualToString:@"."]) { // 输入小数点
        NSRange dotRange = [self.text rangeOfString:@"."];
        if (self.text.length < 1) { // 第一位不能为小数点
            self.text = @"0.";
            return NO;
        } else if (self.text.length >= 1 && dotRange.location == NSNotFound) { // 没有输入过小数点
            if (self.text.length - range.location - range.length <= 2) {// 防止输入了一串数字，然后移动光标到某个位置插入小数点，这里小数点允许插入到最多两位小数
                return YES;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else {
        // 如果是小数，小数点后最多两位小数，前面位数限制
        NSRange dotRange = [self.text rangeOfString:@"."];
        if (dotRange.location != NSNotFound) {
            if (range.location > dotRange.location) { // 在小数后面插入
                if (self.text.length + string.length - dotRange.location - dotRange.length <= 2) {
                    return YES;
                } else {
                    return NO;
                }
            }
        }
        // 如果第一位输入的是0
        if (self.text.length == 0 && [string isEqualToString:@"0"]) {
            self.text = @"0.";
            return NO;
        }
        // 判断是否超过最大输入金额限制
        NSMutableString *tmpValue = self.text.mutableCopy;
        [tmpValue insertString:string atIndex:range.location];
        if ([tmpValue doubleValue] <= self.hcui_maxValue) {
            return YES;
        } else {
            return NO;
        }
        return YES;
    }
}

- (BOOL)hcui_formatedCardCheckWithString:(NSString *)string range:(NSRange)range {
    return [self _hcui_formatedNumberCheckWithString:string range:range];
}

- (NSInteger)hcui_blankCountAfterCursorWithRange:(NSRange)range {
    NSString *stringBeforeCursor = [self.text substringFromIndex:range.location];
    if (stringBeforeCursor.length) {
        NSArray *tmpArray = [stringBeforeCursor componentsSeparatedByString:@" "];
        return tmpArray.count - 1;
    }
    
    return 0;
}

/**
 短信验证码检查输入

 @param string 输入字符
 @return 是否能输入
 */
- (BOOL)hcui_authCodeCheckWithString:(NSString *)string range:(NSRange)range {
    /*
     短信验证码规则：
     1.最多十位,最少4位；
     2.可包含数字、字母，不可包含特殊字符
     */
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (self.text.length < self.hcui_limitLegnth) {
        NSString *regex = @"[a-zA-Z0-9]";
        BOOL isMatched = [self hcui_predicateString:string withRegex:regex];
        return isMatched;
    } else {
        return NO;
    }
}

- (BOOL)hcui_paymentPWDCheckWithString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (self.text.length < self.hcui_limitLegnth) {
        NSString *regex = @"[0-9]";
        BOOL isMatched = [self hcui_predicateString:string withRegex:regex];
        return isMatched;
    } else {
        return NO;
    }
}

- (BOOL)hcui_predicateString:(NSString *)string withRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

- (NSString *)hcui_formatedCardNo:(NSString *)originalCardNo {
    NSString *noSpaceCardNo = [originalCardNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (noSpaceCardNo.length <= 4) {
        return noSpaceCardNo;
    }
    
    NSMutableArray *fourNumbers = [NSMutableArray array];
    NSInteger count = ceil(noSpaceCardNo.length / 4.0);
    for (NSInteger i = 0; i < count; i ++) {
        NSRange range = NSMakeRange(i * 4, MIN(noSpaceCardNo.length - i * 4, 4));
        NSString *fourNumber = [noSpaceCardNo substringWithRange:range];
        [fourNumbers addObject:fourNumber];
    }
    
    return [fourNumbers componentsJoinedByString:@" "];
}

- (NSString *)hcui_formatedPhoneNo:(NSString *)originalPhoneNo {
    NSString *noSpacePhoneNo = [originalPhoneNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (noSpacePhoneNo.length <= 3) {
        return noSpacePhoneNo;
    }
    
    NSMutableArray *numbers = [NSMutableArray array];
    NSString *threeNumber = [noSpacePhoneNo substringWithRange:NSMakeRange(0, 3)];
    [numbers addObject:threeNumber];
    NSString *fourNumbersString = [noSpacePhoneNo substringFromIndex:3];
    NSInteger fourNumbersCount = ceil((fourNumbersString.length) / 4.0);
    for (NSInteger i = 0; i < fourNumbersCount; i ++) {
        NSRange range = NSMakeRange(i * 4, MIN(fourNumbersString.length - i * 4, 4));
        NSString *fourNumber = [fourNumbersString substringWithRange:range];
        [numbers addObject:fourNumber];
    }
    
    return [numbers componentsJoinedByString:@" "];
}

- (BOOL)_hcui_formatedNumberCheckWithString:(NSString *)string range:(NSRange)range {
    NSMutableString *numbers = [NSMutableString stringWithString:self.text];
    // 删除或剪切
    if (!string.length) {
        if (numbers.length > 1) {
            NSInteger offset;
            NSString *deleteChar = [numbers substringWithRange:range];
            if ([deleteChar isEqualToString:@" "]) {
                [numbers replaceCharactersInRange:NSMakeRange(range.location - 1, 2) withString:@""];
                offset = range.location - 1;
            } else {
                [numbers replaceCharactersInRange:range withString:@""];
                offset = range.location;
            }
            self.text = [self _hcui_formatedNumbers:numbers];
            // 设置光标的位置
            UITextPosition *position = [self positionFromPosition:self.beginningOfDocument inDirection:UITextLayoutDirectionRight offset:offset];
            [self setSelectedTextRange:[self textRangeFromPosition:position toPosition:position]];
            [self sendActionsForControlEvents:UIControlEventEditingChanged];
            return NO;
        }
        return YES;
    } else {
        // 粘贴或者输入
        NSString *tempCardString = [numbers stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *tempString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (tempCardString.length + tempString.length > self.hcui_limitLegnth) {
            return NO;
        }
        NSInteger beforeBlankCount = [self hcui_blankCountAfterCursorWithRange:range];
        UITextPosition *prePosition = self.selectedTextRange.end; // 记录上一次光标的位置
        NSInteger preLength = numbers.length;
        [numbers insertString:string atIndex:range.location];
        self.text = [self _hcui_formatedNumbers:numbers];
        NSInteger afterLength = self.text.length;
        NSInteger addedCount = afterLength - preLength; // 字符插入前后，文字的长度变化
        NSInteger afterBlankCount = [self hcui_blankCountAfterCursorWithRange:NSMakeRange(range.location + addedCount, 0)];
        NSInteger blankCountAddedAfterCursor = afterBlankCount - beforeBlankCount; // 计算在插入前后，预设置的光标的后面的空格增加数
        NSInteger offset = addedCount - blankCountAddedAfterCursor; // 文字长度变化 - 在光标之后生成的空格 = 光标实际的偏移量
        // 设置光标的位置
        UITextPosition *position = [self positionFromPosition:prePosition inDirection:UITextLayoutDirectionRight offset:offset];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setSelectedTextRange:[self textRangeFromPosition:position toPosition:position]];// 延时是为了修改直接复制粘贴文本的时候，设置光标位置不生效的问题 https://blog.csdn.net/feinifi/article/details/84941280
        });
        [self sendActionsForControlEvents:UIControlEventEditingChanged]; // 代理返回NO之后，通知和event会失效，手动触发事件
        return NO;// 手动设置了text，所以返回NO
    }
}

- (NSString *)_hcui_formatedNumbers:(NSString *)numbers {
    NSString *formatedString;
    switch (self.hcui_inputType) {
        case HCTextFieldInputTypeFormatedPhoneNumber:
            formatedString = [self hcui_formatedPhoneNo:numbers];
            break;
        case HCTextFieldInputTypeFormatedCardNumber:
            formatedString = [self hcui_formatedCardNo:numbers];
            break;
        default:
            formatedString = numbers;
            break;
    }
    
    return formatedString;
}

#pragma mark - Associated Object

- (HCTextFieldInputType)hcui_inputType {
    id type = objc_getAssociatedObject(self, &HC_INPUTED_TYPE);
    return [type integerValue];
}

- (void)setHcui_inputType:(HCTextFieldInputType)hcui_inputType {
    objc_setAssociatedObject(self, &HC_INPUTED_TYPE, @(hcui_inputType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configKeyboardType];
}

- (NSInteger)hcui_limitLegnth {
    id limitLegnth = objc_getAssociatedObject(self, &HC_INPUTED_LIMIT_LENGTH);
    if (limitLegnth) {
        return [limitLegnth integerValue];
    }
    
    return NSIntegerMax; // 没有设置就是不限制输入长度
}

- (void)setHcui_limitLegnth:(NSInteger)hcui_limitLegnth {
    objc_setAssociatedObject(self, &HC_INPUTED_LIMIT_LENGTH, @(hcui_limitLegnth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (double)hcui_maxValue {
    id maxValue = objc_getAssociatedObject(self, &HC_INPUTED_MAX_VALUE);
    if (maxValue) {
        return [maxValue doubleValue];
    }
    
    return MAXFLOAT;
}

- (void)setHcui_maxValue:(double)hcui_maxValue {
    objc_setAssociatedObject(self, &HC_INPUTED_MAX_VALUE, @(hcui_maxValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
