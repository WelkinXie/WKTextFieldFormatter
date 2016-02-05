//
//  WKTextFieldFormatter.h
//
//  Created by Welkin Xie on 15/12/25.
//  Copyright © 2015年 WelkinXie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WKFormatterTypeAny,
    WKFormatterTypePhoneNumber,
    WKFormatterTypeNumber,
    WKFormatterTypeDecimal,
    WKFormatterTypeAlphabet,
    WKFormatterTypeNumberAndAlphabet,
    WKFormatterTypeIDCard,
    WKFormatterTypeCustom
} WKFormatterType;

@interface WKTextFieldFormatter : NSObject <UITextFieldDelegate>

@property (assign, nonatomic) WKFormatterType formatterType;
@property (assign, nonatomic) NSUInteger limitedLength;
@property (copy, nonatomic) NSString *characterSet;

@property (assign, nonatomic) NSUInteger decimalPlace;

- (instancetype)initWithTextField:(UITextField *)textField controller:(UIViewController *)viewController;

@end


@protocol WKTextFieldFormatterDelegate <NSObject>

- (void)didEnterCharacter:(WKTextFieldFormatter *)formatter currentString:(NSString *)currentString;

@end