//
//  EPSHistoryCell.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPSHistoryCell.h"

@implementation EPSHistoryCell

- (void)awakeFromNib {
    // Initialization code
    self.btn.layer.masksToBounds=YES;
    self.btn.layer.cornerRadius=13;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
