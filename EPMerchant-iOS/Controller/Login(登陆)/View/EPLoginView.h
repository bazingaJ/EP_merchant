//
//  EPLoginView.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPLoginTextField.h"
@protocol EPLoginDelegate <NSObject>

@optional
-(void)loginViewClickLoginButton;

@end

@interface EPLoginView : UIView

@property (nonatomic, weak) id<EPLoginDelegate>delegate;

@property (nonatomic, weak) EPLoginTextField *phoneTextField;

@property (nonatomic, weak) EPLoginTextField *passwordTextField;

@end
