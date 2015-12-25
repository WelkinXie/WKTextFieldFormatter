//
//  WKTextFieldFormatter.m
//
//  Created by Welkin Xie on 15/12/25.
//  Copyright © 2015年 WelkinXie. All rights reserved.
//

#import "WKTextFieldFormatter.h"

@implementation WKTextFieldFormatter

NSString *const kNUMBERS = @"0123456789";
NSString *const kENGLISHALPHABET = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

- (instancetype)initWithTextField:(UITextField *)textField {
    if (self = [self init]) {
        textField.delegate = self;
        _formatterType = WKFormatterTypeAny;
        _limitedLength = NSUIntegerMax;
        _characterSet = @"";
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        return YES;
    }
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
            flag = [self charaterFilter:kNUMBERS text:string];
            break;
        }
        case WKFormatterTypeAlphabet:
        {
            flag = [self charaterFilter:kENGLISHALPHABET text:string];
            break;
        }
        case WKFormatterTypeNumberAndAlphabet:
        {
            flag = [self charaterFilter:[NSString stringWithFormat:@"%@%@", kNUMBERS, kENGLISHALPHABET] text:string];
            break;
        }
        case WKFormatterTypeCustom:
        {
            flag = [self charaterFilter:_characterSet text:string];
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
    return flag;
}

- (BOOL)charaterFilter:(NSString *)stringSet text:(NSString *)text {
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:stringSet] invertedSet];
    NSString *filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [text isEqualToString:filtered];
    if(!basicTest) {
        return NO;
    }
    return YES;
}

@end
