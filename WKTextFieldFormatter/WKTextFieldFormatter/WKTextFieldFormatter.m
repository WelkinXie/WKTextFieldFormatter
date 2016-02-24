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
@property (assign, nonatomic) BOOL hasChanged;
@property (copy, nonatomic) NSString *lastText;
@end

@implementation WKTextFieldFormatter

NSString *const kNUMBERS = @"0123456789";
NSString *const kENGLISHALPHABET = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

- (instancetype)initWithTextField:(UITextField *)textField controller:(UIViewController *)viewController {
    if (self = [self init]) {
        textField.delegate = self;
        _field = textField;
        _viewController = viewController;
        _formatterType = WKFormatterTypeAny;
        _limitedLength = NSUIntegerMax;
        _characterSet = @"";
        _lastText = @"";
        _decimalPlace = 1;
        
        [textField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventAllEditingEvents];
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL flag = YES;
    switch (_formatterType) {
        case WKFormatterTypeAny:
        {
            break;
        }
        case WKFormatterTypePhoneNumber:
        {
            _limitedLength = 11;
        }
        case WKFormatterTypeNumber:
        {
            flag = [self characterFilter:kNUMBERS text:string];
            break;
        }
        case WKFormatterTypeDecimal:
        {
            if (textField.text.length == 0 && [string isEqualToString:@"."]) {
                flag = NO;
                break;
            }
            NSString *decimalComponent = kNUMBERS;
            if ([textField.text rangeOfString:@"."].location == NSNotFound) {
                decimalComponent = [decimalComponent stringByAppendingString:@"."];
            }
            else if ([textField.text substringFromIndex:[textField.text rangeOfString:@"."].location].length > _decimalPlace && ![string isEqualToString:@""]) {
                flag = NO;
                break;
            }
            
            flag = [self characterFilter:decimalComponent text:string];
            
            break;
        }
        case WKFormatterTypeAlphabet:
        {
            flag = [self characterFilter:kENGLISHALPHABET text:string];
            break;
        }
        case WKFormatterTypeNumberAndAlphabet:
        {
            flag = [self characterFilter:[NSString stringWithFormat:@"%@%@", kNUMBERS, kENGLISHALPHABET] text:string];
            break;
        }
        case WKFormatterTypeIDCard:
        {
            if ([textField.text stringByReplacingCharactersInRange:range withString:string].length < 18) {
                flag = [self characterFilter:kNUMBERS text:string];
            }
            else {
                flag = [self characterFilter:[NSString stringWithFormat:@"%@xX", kNUMBERS] text:string];
            }
            _limitedLength = 18;
            break;
        }
        case WKFormatterTypeCustom:
        {
            flag = [self characterFilter:_characterSet text:string];
            break;
        }
        default:
            break;
    }
    NSString *tempString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (tempString.length > _limitedLength) {
        textField.text = [tempString substringToIndex:_limitedLength];
        flag = NO;
    }
    
    if ([_viewController respondsToSelector:@selector(formatter:didEnterCharacter:)]) {
        [_viewController performSelector:@selector(formatter:didEnterCharacter:) withObject:self withObject:string];
    }
    _hasChanged = flag;
    
//    NSLog(@"(%lu,%lu) %@", (unsigned long)range.location, (unsigned long)range.length, string);
    return flag;
}

- (void)textChanged {
    _lastText = _field.text = _hasChanged ? _field.text : _lastText;
    _hasChanged = NO;
}

- (BOOL)characterFilter:(NSString *)stringSet text:(NSString *)text {
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:stringSet] invertedSet];
    NSString *filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [text isEqualToString:filtered];
    if(!basicTest) {
        return NO;
    }
    return YES;
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
