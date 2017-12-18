//
//  EPRevenueCell2.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPRevenueCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;

@property (weak, nonatomic) IBOutlet UIButton *zhouBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthDay;
//收入
@property (weak, nonatomic) IBOutlet UILabel *incomeLb;
//总单数
@property (weak, nonatomic) IBOutlet UILabel *totolOrder;

@property (weak, nonatomic) IBOutlet UILabel *timeLb;

@end
