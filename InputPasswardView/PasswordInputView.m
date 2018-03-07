//
//  PasswordInputView.m
//  CityDispatch
//
//  Created by HT on 17/5/10.
//  Copyright © 2017年 Linan. All rights reserved.
//

#import "PasswordInputView.h"

#define SCREENSIZE [UIScreen mainScreen].bounds.size

@interface PasswordInputView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *maskView;

@end

@implementation PasswordInputView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.textField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:self.textField];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [self showCornerWithBlackTag];
}

- (void)showCornerWithBlackTag{
    
    self.boxView1.layer.borderWidth = 1;
    self.boxView2.layer.borderWidth = 1;
    self.boxView3.layer.borderWidth = 1;
    self.boxView4.layer.borderWidth = 1;
    self.boxView5.layer.borderWidth = 1;
    self.boxView6.layer.borderWidth = 1;
    
    UIColor *color = [UIColor colorWithRed:204.0/255.0f green:204/255.0f blue:204/255.0f alpha:1.0];
    
    self.boxView1.layer.borderColor = color.CGColor;
    self.boxView2.layer.borderColor = color.CGColor;
    self.boxView3.layer.borderColor = color.CGColor;
    self.boxView4.layer.borderColor = color.CGColor;
    self.boxView5.layer.borderColor = color.CGColor;
    self.boxView6.layer.borderColor = color.CGColor;
    
    self.blackTag1.layer.cornerRadius = 6;
    self.blackTag2.layer.cornerRadius = 6;
    self.blackTag3.layer.cornerRadius = 6;
    self.blackTag4.layer.cornerRadius = 6;
    self.blackTag5.layer.cornerRadius = 6;
    self.blackTag6.layer.cornerRadius = 6;
}


+ (instancetype)loadMyView{
    
    PasswordInputView *newView = [[[NSBundle mainBundle] loadNibNamed:@"PasswordInputView" owner:self options:nil] objectAtIndex:0];
    
    return newView;
}

+(instancetype)showAlertOfLaterToPayWithSureBtnClick:(void (^)(BOOL correct))passwordCorrectBlock{
    
    PasswordInputView *newView = [self loadMyView];
    
    newView.MynewView = newView;
    
    newView.textField.delegate = newView;
    
    newView.frame = CGRectMake(SCREENSIZE.width*0.5-(SCREENSIZE.width*0.5), SCREENSIZE.height, SCREENSIZE.width, 124);
    
    newView.passwordCorrectBlock = passwordCorrectBlock;
    
    [newView.maskView addSubview:newView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:newView.maskView];
    
    return newView;
}
-(UIView *)maskView{
    
    if(!_maskView){
        
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height)];
        
        _maskView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        }];
        
    }
    
    return _maskView;
}

- (IBAction)cancleAction:(id)sender {
    
    [self.textField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.frame;
        frame.origin.y = 1700;
        self.frame = frame;
        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_maskView removeFromSuperview];
        
        [self removeFromSuperview];
    }];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = _MynewView.frame;
        frame.origin.y = SCREENSIZE.height - 124 - height;
        _MynewView.frame = frame;
        _MynewView.maskView.alpha = 1.0;
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger strLength = textField.text.length - range.length + string.length;
    
    return (strLength <= 6);
}

- (void)textFieldChanged{
    
    [self showBlockTagWithTextString:self.textField.text.length];
}

//输入密码是显示黑点
- (void)showBlockTagWithTextString:(NSInteger)textStringLength{
    
    NSLog(@"self.textField.text = %@",self.textField.text);

    self.blackTag1.hidden = textStringLength >= 1 ? NO : YES;
    self.blackTag2.hidden = textStringLength >= 2 ? NO : YES;
    self.blackTag3.hidden = textStringLength >= 3 ? NO : YES;
    self.blackTag4.hidden = textStringLength >= 4 ? NO : YES;
    self.blackTag5.hidden = textStringLength >= 5 ? NO : YES;
    self.blackTag6.hidden = textStringLength >= 6 ? NO : YES;
    
    if (self.textField.text.length == 6) {
        
        //这里调取后台接口判断输入的密码是否正确
        if ([self.textField.text isEqualToString:@"123456"]) {
            self.passwordCorrectBlock(YES);
        }else{
            self.passwordCorrectBlock(NO);
        }
    }
}

@end
