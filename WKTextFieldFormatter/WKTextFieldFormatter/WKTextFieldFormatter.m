//
//  WKTextFieldFormatter.m
//
//  Created by Welkin Xie on 15/12/25.
//  Copyright © 2015年 WelkinXie. All rights reserved.
//
//  Github: https://github.com/WelkinXie/WKTextFieldFormatter
//

#import "WKTextFieldFormatter.h"

@interface WKTextFieldFormatter ()

@property (copy, nonatomic) NSString *currentText;

@end

@implementation WKTextFieldFormatter

- (instancetype)initWithTextField:(UITextField *)textField {
    if (self = [self init]) {
        _formatterType = WKFormatterTypeAny;
        _limitedLength = INT16_MAX;
        _characterSet = @"";
        _decimalPlace = 1;
        _currentText = @"";
        
        [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)textChanged:(UITextField *)textField {    
    NSString *regexString = @"";
    switch (_formatterType) {
        case WKFormatterTypeAny:
        {
            _currentText = textField.text;
            return;
        }
        case WKFormatterTypePhoneNumber:
        {
            regexString = @"^\\d{0,11}$";
            break;
        }
        case WKFormatterTypeNumber:
        {
            regexString = @"^\\d*$";
            break;
        }
        case WKFormatterTypeDecimal:
        {
            regexString = [NSString stringWithFormat:@"^(\\d+)\\.?(\\d{0,%lu})$", _decimalPlace];
            break;
        }
        case WKFormatterTypeAlphabet:
        {
            regexString = @"^[a-zA-Z]*$";
            break;
        }
        case WKFormatterTypeNumberAndAlphabet:
        {
            regexString = @"^[a-zA-Z0-9]*$";
            break;
        }
        case WKFormatterTypeIDCard:
        {
            regexString = @"^\\d{1,17}[0-9Xx]?$";
            break;
        }
        case WKFormatterTypeCustom:
        {
            regexString = [NSString stringWithFormat:@"^[%@]{0,%lu}$", _characterSet, _limitedLength];
            break;
        }
        default:
            break;
    }
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    if (!([regexTest evaluateWithObject:textField.text] || textField.text.length == 0)) {
        textField.text = self.currentText;
    } else {
        self.currentText = textField.text;
    }
}

@end
