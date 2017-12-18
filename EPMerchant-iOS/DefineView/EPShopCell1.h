//
//  EPShopCell1.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPShopModel;
@interface EPShopCell1 : UITableViewCell

@property(nonatomic,strong)EPShopModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *range;
@property (weak, nonatomic) IBOutlet UILabel *contact;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end
