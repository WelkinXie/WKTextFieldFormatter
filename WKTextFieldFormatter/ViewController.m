//
//  ViewController.m
//  WKTextFieldFormatter
//
//  Created by Welkin Xie on 15/12/25.
//  Copyright © 2015年 WelkinXie. All rights reserved.
//

#import "ViewController.h"
#import "WKTextFieldFormatter.h"

@interface ViewController () <WKTextFieldFormatterDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) WKTextFieldFormatter *formatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _formatter = [[WKTextFieldFormatter alloc] initWithTextField:_textField controller:self];
    _formatter.formatterType = WKFormatterTypeDecimal;
    _formatter.decimalPlace = 1;
    
    [_textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKTextFieldFormatterDelegate
- (void)formatter:(WKTextFieldFormatter *)formatter didEnterCharacter:(NSString *)string {
    if ([formatter isEqual:_formatter]) {
        NSLog(@"%@", string);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
