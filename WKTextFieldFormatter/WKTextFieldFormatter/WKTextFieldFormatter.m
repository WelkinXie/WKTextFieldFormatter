//
//  WKTextFieldFormatter.m
//
//  Created by Welkin Xie on 15/12/25.
//  Copyright © 2015年 WelkinXie. All rights reserved.
//

#import "WKTextFieldFormatter.h"

@interface WKTextFieldFormatter ()
@property (weak, nonatomic, readonly) UIViewController *viewController;
@property (weak, nonatomic, readonly) UITextField *field;
@end

@implementation WKTextFieldFormatter

- (instancetype)initWithTextField:(UITextField *)textField controller:(UIViewController *)viewController {
    if (self = [self init]) {
        textField.delegate = self;
        _field = textField;
        _viewController = viewController;
        _formatterType = WKFormatterTypeAny;
        _limitedLength = INT16_MAX;
        _characterSet = @"";
        _decimalPlace = 1;
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_viewController respondsToSelector:@selector(formatter:didEnterCharacter:)]) {
        [_viewController performSelector:@selector(formatter:didEnterCharacter:) withObject:self withObject:string];
    }
    
    NSString *regexString = @"";
    switch (_formatterType) {
        case WKFormatterTypeAny:
        {
            return YES;
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
    NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    
    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([_viewController respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_viewController performSelector:@selector(textFieldShouldBeginEditing:) withObject:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([_viewController respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_viewController performSelector:@selector(textFieldDidBeginEditing:) withObject:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_viewController respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_viewController performSelector:@selector(textFieldShouldEndEditing:) withObject:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_viewController respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_viewController performSelector:@selector(textFieldDidEndEditing:) withObject:textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([_viewController respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [_viewController performSelector:@selector(textFieldShouldClear:) withObject:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_viewController respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [_viewController performSelector:@selector(textFieldShouldReturn:) withObject:textField];
    }
    return YES;
}

@end
