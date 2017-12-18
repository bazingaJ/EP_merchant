//
//  EPResetPayPasswordVC.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPResetPayPasswordVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfNewPayPass;

@property (weak, nonatomic) IBOutlet UITextField *tfAgainPayPass;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
