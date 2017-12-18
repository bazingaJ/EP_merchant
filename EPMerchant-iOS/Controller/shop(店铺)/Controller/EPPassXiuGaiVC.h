//
//  EPPassXiuGaiVC.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPPassXiuGaiVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfNewPass;

@property (weak, nonatomic) IBOutlet UITextField *tfAgainPass;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property(nonatomic,assign)int isChuan;
@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * code;
//密码
@property(nonatomic,copy)NSString * pass;

@end
