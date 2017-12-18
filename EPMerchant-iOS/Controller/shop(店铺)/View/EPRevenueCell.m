//
//  EPRevenueCell.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPRevenueCell.h"

@implementation EPRevenueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detailBtn.layer.masksToBounds=YES;;
    self.detailBtn.layer.cornerRadius=5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
