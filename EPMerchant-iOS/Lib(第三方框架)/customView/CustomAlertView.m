//
//  CustomAlertView.m
//  CustomAlertView
//
//  Created by 丁宗凯 on 16/6/22.
//  Copyright © 2016年 dzk. All rights reserved.
//

#import "CustomAlertView.h"
#define MAINSCREENwidth   [UIScreen mainScreen].bounds.size.width
#define MAINSCREENheight  [UIScreen mainScreen].bounds.size.height
#define WINDOWFirst        [[[UIApplication sharedApplication] windows] firstObject]
#define RGBa(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


//#define AlertViewHeight 248
#define AlertViewJianGe 19.5

@implementation CustomAlertView


-(instancetype)initWithAlertViewHeight:(CGFloat)height
{
    self=[super init];
    if (self) {
        CGFloat AlertViewHeight = height;
        if (self.bGView==nil) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            view.backgroundColor = [UIColor blackColor];
            view.alpha = 0.5;
            [WINDOWFirst addSubview:view];
            self.bGView =view;
        }
        
        self.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
        self.bounds = CGRectMake(0, 0, ScreenWidth, AlertViewHeight);
        [WINDOWFirst addSubview:self];
        
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(AlertViewJianGe, 0, ScreenWidth-2*AlertViewJianGe, AlertViewHeight)];
        image.image = [UIImage imageNamed:@"bg"];
        [self addSubview:image];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(AlertViewJianGe, 0, image.frame.size.width, 54);
        lab.text = @"转移订单";
        lab.font = [UIFont systemFontOfSize:21];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor whiteColor];
        [self addSubview:lab];
        self.titleLabel =lab;
        
        UITextField *tField = [[UITextField alloc] initWithFrame:CGRectMake(AlertViewJianGe+15, lab.frame.origin.x+lab.frame.size.height, MAINSCREENwidth-2*(AlertViewJianGe+15), 50)];
        tField.placeholder =@"请输入转移订单的手机号码";
        
        tField.font = [UIFont systemFontOfSize:14];
        tField.delegate = (id<UITextFieldDelegate>)self;
        [tField setValue:RGBa(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
        [tField setValue:tField.font forKeyPath:@"_placeholderLabel.font"];


        [self addSubview:tField];
        self.textField = tField;
        
        CGFloat btnWidth = (MAINSCREENwidth -2*(30+AlertViewJianGe)-41)/2;
        CGFloat btnHeight = 40;
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelButton.frame = CGRectMake(AlertViewJianGe+30, tField.frame.origin.y+tField.frame.size.height+25, btnWidth, btnHeight);
        [cancelButton setTitle:@"取消" forState:0];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        cancelButton.tag =0;
        [cancelButton setTitleColor:RGBa(102, 102, 102, 1) forState:0];
        [cancelButton setTitleColor:[UIColor blackColor] forState:0];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"box"] forState:0];
        [cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:cancelButton];
        
        UIButton *qRButton = [UIButton buttonWithType:UIButtonTypeSystem];
        qRButton.frame = CGRectMake(cancelButton.frame.origin.x+cancelButton.frame.size.width+41, cancelButton.frame.origin.y, btnWidth, btnHeight);
        [qRButton setTitle:@"确定指派" forState:0];
        [qRButton setTitleColor:RGBa(102, 102, 102, 1) forState:0];

        qRButton.titleLabel.font = cancelButton.titleLabel.font;

        [qRButton setTitleColor:[UIColor blackColor] forState:0];
        [qRButton setBackgroundImage:[UIImage imageNamed:@"dabox"] forState:0];
        [qRButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        qRButton.tag =1;
        [self addSubview:qRButton];
        [self show:YES];

    }
    return self;
}
-(void)buttonClick:(UIButton*)button
{
    [self hide:YES];
    if (self.ButtonClick) {
        self.ButtonClick(button);
    }
}
- (void)show:(BOOL)animated
{
    if (animated)
    {
        self.transform = CGAffineTransformScale(self.transform,0,0);
        __weak CustomAlertView *weakSelf = self;
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1.2,1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                weakSelf.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)hide:(BOOL)animated
{
    [self endEditing:YES];
    if (self.bGView != nil) {
        __weak CustomAlertView *weakSelf = self;
        
        [UIView animateWithDuration:animated ?0.3: 0 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1,1);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration: animated ?0.3: 0 animations:^{
                weakSelf.transform = CGAffineTransformScale(weakSelf.transform,0.2,0.2);
            } completion:^(BOOL finished) {
                [weakSelf.bGView removeFromSuperview];
                [weakSelf removeFromSuperview];
                weakSelf.bGView=nil;
            }];
        }];
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat liuHeight = MAINSCREENheight-(self.frame.origin.y+self.frame.size.height);
    if (liuHeight<216) {
        CGRect rect = self.frame;
        rect.origin.y = rect.origin.y-(216-liuHeight);
        self.frame =rect;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.center = self.superview.center;
    [self endEditing:YES];
    
    return YES;
}


@end
