//
//  EPPresentMoneyVC.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPPresentMoneyVC : UIViewController

@property(nonatomic,assign)float moneyCount;

@property(nonatomic,copy)NSString * accountNumber;
@property(nonatomic,copy)NSString * depositBank;


@property (weak, nonatomic) IBOutlet UILabel *cardLb;

@end
