//
//  LaterToPayView.h
//  CityDispatch
//
//  Created by HT on 17/5/10.
//  Copyright © 2017年 Linan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PasswordCorrectBlock)(BOOL correct);

@interface PasswordInputView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tip_lab;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIView *blackTag1;
@property (weak, nonatomic) IBOutlet UIView *blackTag2;
@property (weak, nonatomic) IBOutlet UIView *blackTag3;
@property (weak, nonatomic) IBOutlet UIView *blackTag4;
@property (weak, nonatomic) IBOutlet UIView *blackTag5;
@property (weak, nonatomic) IBOutlet UIView *blackTag6;

@property (weak, nonatomic) IBOutlet UIView *boxView1;
@property (weak, nonatomic) IBOutlet UIView *boxView2;
@property (weak, nonatomic) IBOutlet UIView *boxView3;
@property (weak, nonatomic) IBOutlet UIView *boxView4;
@property (weak, nonatomic) IBOutlet UIView *boxView5;
@property (weak, nonatomic) IBOutlet UIView *boxView6;

@property (nonatomic, strong) PasswordInputView *MynewView;

@property (nonatomic, strong) PasswordCorrectBlock passwordCorrectBlock;

+ (instancetype)showAlertOfLaterToPayWithSureBtnClick:(void(^)(BOOL correct))passwordCorrectBlock;

@end
