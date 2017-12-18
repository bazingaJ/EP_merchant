//
//  EPGoodCollectionViewCell.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/28.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPGoodCollectionViewCell.h"

@implementation EPGoodCollectionViewCell

- (void)setModel:(EPGoodsInfo *)model{
    _model=model;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.goodsImg]];
    self.goodsName.text=model.goodsName;
    self.priceLb.text=[NSString stringWithFormat:@"¥ %@",model.goodsPrice];
    self.priceLb.adjustsFontSizeToFitWidth=YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
