//
//  EPPresentRecordCell.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPRevenueModel;
@interface EPPresentRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLb;

@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@property(nonatomic,strong)EPRevenueModel * model;

@end
