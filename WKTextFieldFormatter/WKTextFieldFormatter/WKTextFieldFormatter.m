//
//  WKTextFieldFormatter.m
//
//  Created by Welkin Xie on 15/12/25.
//  Copyright © 2015年 WelkinXie. All rights reserved.
//

#import "WKTextFieldFormatter.h"

@interface WKTextFieldFormatter ()
@property (weak, nonatomic) UIViewController *viewController;
@end

@implementation WKTextFieldFormatter

NSString *const kNUMBERS = @"0123456789";
NSString *const kENGLISHALPHABET = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

- (instancetype)initWithTextField:(UITextField *)textField controller:(UIViewController *)viewController {
    if (self = [self init]) {
        textField.delegate = self;
        _viewController = viewController;
        _formatterType = WKFormatterTypeAny;
        _limitedLength = NSUIntegerMax;
        _characterSet = @"";
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
    
    if ([_viewController respondsToSelector:@selector(didEnterCharacter:currentString:)]) {
        [_viewController performSelector:@selector(didEnterCharacter:currentString:) withObject:self withObject:string];
    }
    
    return flag;
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

@end
