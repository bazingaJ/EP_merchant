//
//  EPDetailCell.m
//  EPin-IOS
//
//  Created by jeaderL on 16/4/4.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import "EPDetailCell.h"
#import "EPDetailModel.h"
@implementation EPDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImg.layer.masksToBounds=YES;
    self.headImg.layer.cornerRadius=25;
}
- (void)setModel:(EPGetCommentModel *)model{
    _model=model;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.headImgAddress]];
    self.lbName.text=model.passengerName;
    NSInteger count=[model.commentStar integerValue];
    if (count==0) {
        
    }else if (count==1){
        [self addImage:self.btn1];
    }else if (count==2){
        [self addImage:self.btn1];
        [self addImage:self.btn2];
    }else if (count==3){
        [self addImage:self.btn1];
        [self addImage:self.btn2];
        [self addImage:self.btn3];
    }else if (count==4){
        [self addImage:self.btn1];
        [self addImage:self.btn2];
        [self addImage:self.btn3];
        [self addImage:self.btn4];

    }else if (count==5){
        [self addImage:self.btn1];
        [self addImage:self.btn2];
        [self addImage:self.btn3];
        [self addImage:self.btn4];
        [self addImage:self.btn5];
    }
    NSString * time=[model.commentTime substringToIndex:16];
    self.time.text=time;
    self.content.text=model.commentContent;
}
- (void)addImage:(UIButton *)btn{
    [btn setImage:[UIImage imageNamed:@"five_pointed_star"] forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
