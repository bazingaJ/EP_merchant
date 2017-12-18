//
//  EPLoginView.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPLoginView.h"

#import "EPLoginTextField.h"

#import "EPLoginAnimation.h"

#define SHIYellow ColorWithRGB(255, 245, 212, 1)

#define LogoImage [UIImage imageNamed:@"logo_login"]

@interface EPLoginView ()

@property (nonatomic, weak) UIImageView *loginImageV;



@property (nonatomic, weak) UIButton *forgetPassBtn;

@property (nonatomic, weak) UILabel *line;

@property (nonatomic, weak) UIButton *loginBtn;

@property (nonatomic, weak) UIButton *beShopBtn;

@end

@implementation EPLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}
- (void)forgetBtn{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"forget" object:nil];
}
- (void)becomeShop{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"becomeShop" object:nil];
}
-(void)addSubviews
{
    // image v
    UIImageView *loginImageV = [[UIImageView alloc] init];
    [self addSubview:loginImageV];
    _loginImageV = loginImageV;
    loginImageV.image = LogoImage;
    
    
    // phone input textfield
    EPLoginTextField *phoneTextField = [[EPLoginTextField alloc] init];
    phoneTextField.imageName=@"phone_login";
    phoneTextField.placeHolder = @"请输入手机号码";
    [self addSubview:phoneTextField];
    _phoneTextField = phoneTextField;
    phoneTextField.alpha = 0;
    
    // password input textfield
    EPLoginTextField *passwordTextField = [[EPLoginTextField alloc] init];
    passwordTextField.imageName=@"lock-0_login";
    passwordTextField.placeHolder = @"请输入密码";
    [self addSubview:passwordTextField];
    _passwordTextField = passwordTextField;
    passwordTextField.textField.secureTextEntry = YES;
    passwordTextField.alpha = 0;
    
    // forget pass word button
    UIButton *forgetPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:forgetPassBtn];
    _forgetPassBtn = forgetPassBtn;
    [forgetPassBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPassBtn setTitleColor:SHIYellow forState:UIControlStateNormal];
    forgetPassBtn.titleLabel.font = TextFont;
    forgetPassBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [forgetPassBtn addTarget:self action:@selector(forgetBtn) forControlEvents:UIControlEventTouchUpInside];
    forgetPassBtn.alpha = 0;
    
    // line
    UILabel *line = [[UILabel alloc] init];
    [forgetPassBtn addSubview:line];
    _line = line;
    line.backgroundColor = SHIYellow;
    
    // login button
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:loginBtn];
    _loginBtn = loginBtn;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    loginBtn.layer.cornerRadius = 15;
    loginBtn.backgroundColor = SHIYellow;
    loginBtn.alpha = 0;
    [loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // become shopper
    UIButton *beShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:beShopBtn];
    _beShopBtn = beShopBtn;
    [beShopBtn setTitle:@"成为商家" forState:UIControlStateNormal];
    [beShopBtn setTitleColor:SHIYellow forState:UIControlStateNormal];
    beShopBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    beShopBtn.layer.cornerRadius = 15;
    beShopBtn.layer.borderColor = WhiteColor.CGColor;
    beShopBtn.layer.borderWidth = 1;
    beShopBtn.alpha = 0;
    [beShopBtn setBackgroundColor:ColorWithRGB(255, 245, 212, .15)];
    [beShopBtn addTarget:self action:@selector(becomeShop) forControlEvents:UIControlEventTouchUpInside];
    NSArray *views = @[phoneTextField,passwordTextField,forgetPassBtn,loginBtn,beShopBtn];
    [EPLoginAnimation logoMoveToTop:loginImageV subviews:views];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGSize imageS = [LogoImage size];
    
//    CGFloat ix = (CurrentViewWidth-imageS.width)/2, iy = 64, iw = imageS.width, ih = imageS.height;
//    _loginImageV.frame = CGRectMake(ix, iy, iw, ih);
//    
    CGFloat pw = 240, py = CGRectGetMaxY(_loginImageV.frame)+34, px = (CurrentViewWidth-pw)/2, ph =40;
    _phoneTextField.frame = CGRectMake(px, py, pw, ph);
    
    _passwordTextField.frame = CGRectMake(px, CGRectGetMaxY(_phoneTextField.frame)+22, pw, ph);
    
    CGFloat fw = 80, fh = 30, fx = pw+px-fw, fy = CGRectGetMaxY(_passwordTextField.frame);
    [_forgetPassBtn setFrame:CGRectMake(fx, fy, fw, fh)];
    
    _line.frame = CGRectMake(13, fh-8, fw-26, 1);
    
    CGFloat lw = 240, lh = 40, lx = (CurrentViewWidth-lw)/2, ly = CGRectGetMaxY(_passwordTextField.frame)+50;
    [_loginBtn setFrame:CGRectMake(lx, ly, lw, lh)];
    
    [_beShopBtn setFrame:CGRectMake(lx, CGRectGetMaxY(_loginBtn.frame)+15, lw, lh)];
    
}

// click login button
-(void)clickLoginBtn
{
    CYLog(@"click login button");
    if ([_delegate respondsToSelector:@selector(loginViewClickLoginButton)]) {
        [_delegate loginViewClickLoginButton];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CYLog(@"success");
    [_phoneTextField.textField resignFirstResponder];
    [_passwordTextField.textField resignFirstResponder];
}



@end
