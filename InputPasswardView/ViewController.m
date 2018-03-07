//
//  ViewController.m
//  InputPasswardView
//
//  Created by HT on 2018/3/6.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "ViewController.h"
#import "PasswordInputView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)showViewAction:(UIButton *)sender {

    [PasswordInputView showAlertOfLaterToPayWithSureBtnClick:^(BOOL correct) {
        NSLog(@"%@",correct ? @"密码正确" : @"密码不正确");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
