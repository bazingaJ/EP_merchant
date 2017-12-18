//
//  EPShopCell1.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPShopCell1.h"
#import "EPShopModel.h"
@implementation EPShopCell1

- (void)setModel:(EPShopModel *)model{
    _model=model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.shopImg]];
    if ([model.shopRange intValue]==0) {
        self.range.text=@"经营范围: 购物";
    }else if ([model.shopRange intValue]==1){
        self.range.text=@"经营范围: 娱乐";
    }else if ([model.shopRange intValue]==2){
        self.range.text=@"经营范围: 餐饮";
    }else if ([model.shopRange intValue]==3){
        self.range.text=@"经营范围: 其他";
    }
    self.contact.text=[NSString stringWithFormat:@"联系方式: %@",model.shopPhone];
    self.address.text=[NSString stringWithFormat:@"商家地址: %@",model.shopAddress];
    self.shopName.text=[NSString stringWithFormat:@"商家名称: %@",model.shopName];
    
    
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
