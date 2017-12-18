//
//  EPShopNewsCell.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPShopNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *numLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (weak, nonatomic) IBOutlet UILabel *contentLb;

@end
