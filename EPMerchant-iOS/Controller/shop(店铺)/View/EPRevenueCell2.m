//
//  EPRevenueCell2.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPRevenueCell2.h"

@implementation EPRevenueCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detailBtn.layer.masksToBounds=YES;;
    self.detailBtn.layer.cornerRadius=5;
    self.dayBtn.layer.masksToBounds=YES;
    self.dayBtn.layer.cornerRadius=18;
    self.zhouBtn.layer.masksToBounds=YES;
    self.zhouBtn.layer.cornerRadius=18;
    self.monthDay.layer.masksToBounds=YES;
    self.monthDay.layer.cornerRadius=18;
}
- (IBAction)dayClick:(UIButton *)sender {
    sender.selected=NO;
    [self setBlueColor:sender];
    self.zhouBtn.selected=NO;
    [self setTextGrayColor:self.zhouBtn];
    self.monthDay.selected=NO;
    [self setTextGrayColor:self.monthDay];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"day" object:nil];
    NSUserDefaults * us=[NSUserDefaults standardUserDefaults];
    [us setObject:@"1" forKey:@"day"];
    [us setObject:@"0" forKey:@"zhou"];
    [us setObject:@"0" forKey:@"month"];
    [us synchronize];
}
- (IBAction)zhouClick:(UIButton *)sender {
    sender.selected=YES;
    [self setBlueColor:sender];
    self.dayBtn.selected=YES;
    [self setTextGrayColor:self.dayBtn];
    self.monthDay.selected=NO;
    [self setTextGrayColor:self.monthDay];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"zhou" object:nil];
    NSUserDefaults * us=[NSUserDefaults standardUserDefaults];
    [us setObject:@"1" forKey:@"zhou"];
    [us setObject:@"0" forKey:@"day"];
    [us setObject:@"0" forKey:@"month"];
    [us synchronize];
}
- (IBAction)monthClick:(UIButton *)sender {
    sender.selected=YES;
    [self setBlueColor:sender];
    self.dayBtn.selected=YES;
    [self setTextGrayColor:self.dayBtn];
    self.zhouBtn.selected=NO;
    [self setTextGrayColor:self.zhouBtn];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"month" object:nil];
    NSUserDefaults * us=[NSUserDefaults standardUserDefaults];
    [us setObject:@"1" forKey:@"month"];
    [us setObject:@"0" forKey:@"zhou"];
    [us setObject:@"0" forKey:@"day"];
    [us synchronize];
}
- (void)setTextGrayColor:(UIButton *)btn{
    btn.backgroundColor=ColorWithRGB(237, 237, 237, 1);
}
- (void)setBlueColor:(UIButton *)btn{
    btn.backgroundColor=ColorWithRGB(0, 162, 255, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
