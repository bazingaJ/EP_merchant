//
//  EPSequenceView.m
//  EPSequeue
//
//  Created by jeader on 16/7/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPSequenceView.h"

#import "EPSequView.h"
@implementation EPSequenceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.sequenceLB = [[UILabel alloc] init];
        [self addSubview:self.sequenceLB];
        self.sequenceLB.text = @"请输入兑换码";
        self.sequenceLB.font = [UIFont systemFontOfSize:18];
        self.sequenceLB.textAlignment = NSTextAlignmentCenter;
        
        // 输入框
        self.sequView = [[EPSequView alloc] initWithFrame:CGRectMake(30,147+21+24, self.width-60, 45)];
        self.sequView.tag=700;
        [self addSubview:self.sequView];
        [self.sequView setCount:1];
        
        // 添加按钮
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.addButton];
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        self.addButton.titleLabel.font = [UIFont systemFontOfSize:25];
        [self.addButton setTitleColor:ColorWithRGB(116, 115, 115, 1) forState:UIControlStateNormal];
        self.addButton.layer.masksToBounds = YES;
        self.addButton.layer.cornerRadius =20.0;
        self.addButton.layer.borderColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor;
        self.addButton.layer.borderWidth = 1;
        [self.addButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        
        // 查询按钮
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.searchBtn];
        [self.searchBtn setTitle:@"查 询" forState:UIControlStateNormal];
        self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.searchBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:162/255.0 blue:255/255.0 alpha:1]];
        self.searchBtn.layer.masksToBounds = YES;
        self.searchBtn.layer.cornerRadius = 25.0;
        [self.searchBtn addTarget:self action:@selector(lookBtnClick) forControlEvents:UIControlEventTouchUpInside];
     }
    return self;
}
- (void)lookBtnClick{
    //查询通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lookVcode" object:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setFrameW];
    
}

-(void)setFrameW
{
    self.sequenceLB.frame = CGRectMake(0, 130, self.bounds.size.width, 21);
    
    NSLog(@"%f",self.sequView.height);
    self.sequenceLB.textAlignment=NSTextAlignmentCenter;
    CGFloat sx = 30, sy = CGRectGetMaxY(self.sequenceLB.frame)+24, sw = self.bounds.size.width-60, sh = self.sequView.height;
    self.sequView.frame = CGRectMake(sx, sy, sw, sh);
    [self.addButton setFrame:CGRectMake(30, CGRectGetMaxY(self.sequView.frame), sw, 38)];
    
    [self.searchBtn setFrame:CGRectMake((self.bounds.size.width-100)/2, CGRectGetMaxY(self.addButton.frame)+20, 100, 44)];
}

-(void)clickButton
{
    if (self.sequView.count<5) {
        self.sequView.count ++;
       }
    [self setFrameW];
    
}

@end
