//
//  EPLoginViewController.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

//自动登录
+ (void)autoLogin;

@end
