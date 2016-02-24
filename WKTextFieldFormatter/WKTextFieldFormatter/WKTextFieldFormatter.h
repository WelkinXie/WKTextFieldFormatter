//
//  WKTextFieldFormatter.h
//
//  Created by Welkin Xie on 15/12/25.
//  Copyright © 2015年 WelkinXie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WKFormatterType) {
    WKFormatterTypeAny,                 //不过滤
    WKFormatterTypePhoneNumber,         //11位电话号码
    WKFormatterTypeNumber,              //数字
    WKFormatterTypeDecimal,             //小数
    WKFormatterTypeAlphabet,            //英文字母
    WKFormatterTypeNumberAndAlphabet,   //数字+英文字母
    WKFormatterTypeIDCard,              //18位身份证
    WKFormatterTypeCustom               //自定义
};

@interface WKTextFieldFormatter : NSObject <UITextFieldDelegate>

//格式类型
@property (assign, nonatomic) WKFormatterType formatterType;

//限制长度
@property (assign, nonatomic) NSUInteger limitedLength;

//允许的字符集
@property (copy, nonatomic) NSString *characterSet;

//小数位
@property (assign, nonatomic) NSUInteger decimalPlace;

- (instancetype)initWithTextField:(UITextField *)textField controller:(UIViewController *)viewController;

@end


@protocol WKTextFieldFormatterDelegate <NSObject>

- (void)formatter:(WKTextFieldFormatter *)formatter didEnterCharacter:(NSString *)string;

@end