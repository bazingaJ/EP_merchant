//
//  CustomAlertView.h
//  CustomAlertView
//
//  Created by 丁宗凯 on 16/6/22.
//  Copyright © 2016年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

@property(nonatomic,strong)UIView *bGView;

@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *titleLabel;

@property(copy,nonatomic)void (^ButtonClick)(UIButton*);

-(instancetype)initWithAlertViewHeight:(CGFloat)height;
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end
