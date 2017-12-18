//
//  AppDelegate.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeTuiSdk.h"     // GetuiSdk头文件，需要使用的地方需要添加此代码
/// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId           @"HwW6ddUbO8Ak8FwwLzObI2"
#define kGtAppKey          @"CFZMDF7r7A6qAvhCC5MgZ8"
#define kGtAppSecret       @"7AVwO8H56cAE58TSyilEu7"

/// 需要使用个推回调时，需要添加"GeTuiSdkDelegate"

@interface AppDelegate : UIResponder <UIApplicationDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

