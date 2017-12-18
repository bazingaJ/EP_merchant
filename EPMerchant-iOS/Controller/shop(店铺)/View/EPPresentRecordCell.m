//
//  EPPresentRecordCell.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPPresentRecordCell.h"
#import "EPRevenueModel.h"
@implementation EPPresentRecordCell

- (void)setModel:(EPRevenueModel *)model{
    _model=model;
    self.timeLb.text=model.date;
    self.priceLb.text=[NSString stringWithFormat:@"¥%@",model.money];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
