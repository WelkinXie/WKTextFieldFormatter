//
//  ViewController.m
//  WKTextFieldFormatter
//
//  Created by Welkin Xie on 15/12/25.
//  Copyright © 2015年 WelkinXie. All rights reserved.
//
//  Github: https://github.com/WelkinXie/WKTextFieldFormatter
//

#import "ViewController.h"
#import "WKTextFieldFormatter.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) WKTextFieldFormatter *formatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _formatter = [[WKTextFieldFormatter alloc] initWithTextField:_textField];
    _formatter.formatterType = WKFormatterTypeDecimal;
    _formatter.decimalPlace = 2;
    
    [_textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
