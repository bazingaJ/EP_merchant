//
//  EPLoginTextField.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//  输入手机号和密码的框

#import "EPLoginTextField.h"

@interface EPLoginTextField () <UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *textFieldImageV;

@property (nonatomic, weak) UILabel *placeholder;

@end

@implementation EPLoginTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubviews];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.6;
        self.layer.borderColor = WhiteColor.CGColor;
        self.layer.borderWidth = 1.f;
        
        self.backgroundColor = ColorWithRGB(255, 245, 212, .15);
        
    }
    return self;
}

-(void)addSubviews
{
    // left image
    UIImageView *textFieldImageV = [[UIImageView alloc] init];
    [self addSubview:textFieldImageV];
    _textFieldImageV = textFieldImageV;
    
    // input view
    UITextField *textfield = [[UITextField alloc] init];
    [self addSubview:textfield];
    textfield.borderStyle = 0;
    _textField = textfield;
    textfield.delegate = self;
    textfield.font = TextFont;
    textfield.tintColor = WhiteColor;
    textfield.textColor = WhiteColor;
    
    // placeholder
    UILabel *placeholder = [[UILabel alloc] init];
    [textfield addSubview:placeholder];
    _placeholder = placeholder;
    placeholder.textColor = WhiteColor;
    placeholder.font = TextFont;
    placeholder.textAlignment = NSTextAlignmentCenter;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CYLog(@"%s",__func__);
    
    CGSize imageSize = [[UIImage imageNamed:_imageName] size];
    CGFloat ix = Margin, iy = (CurrentViewHeight-imageSize.height)/2, iw = imageSize.width, ih = imageSize.height;
    _textFieldImageV.frame = CGRectMake(ix, iy, iw, ih);
    
    CGFloat tw = CurrentViewWidth-ix-iw-ix, th = 30, tx=CGRectGetMaxX(_textFieldImageV.frame)+ix, ty = (CurrentViewHeight-th)/2;
    _textField.frame = CGRectMake(tx, ty, tw, th);
    
    _placeholder.frame = CGRectMake(0, 0, tw-ix*2-iw, th);

}

#pragma mark textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _placeholder.hidden = YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
#pragma MARK------UITextField的协议方法------------
//限制文本框输入的字数长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.textField){
        NSInteger loc =range.location;
        if (loc < 20)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return YES;
    
}
#pragma mark accessor
-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    _textFieldImageV.image = [UIImage imageNamed:imageName];
    
    CYLog(@"%s",__func__);
    
}

-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    _placeholder.text = placeHolder;
}

-(NSString *)textFieldText
{
    if (self.textField.text) {
        return self.textField.text;
    }
    return nil;
}

@end
