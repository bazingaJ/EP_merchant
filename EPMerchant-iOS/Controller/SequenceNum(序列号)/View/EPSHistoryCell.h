//
//  EPSHistoryCell.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPSHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *squenLb;

@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@end
