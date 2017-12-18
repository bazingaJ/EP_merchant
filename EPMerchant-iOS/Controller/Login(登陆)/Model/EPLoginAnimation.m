//
//  EPLoginAnimation.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPLoginAnimation.h"

#define LogoImage [UIImage imageNamed:@"logo_login"]

@implementation EPLoginAnimation

+(void)logoMoveToTop:(UIView *)view subviews:(NSArray *)views
{
    CGSize imageS = [LogoImage size];
    CGFloat x = (ScreenWidth-imageS.width)/2, y = 64, w = imageS.width, h = imageS.height;
    
    view.frame = CGRectMake((ScreenWidth-w-30)/2, (ScreenHeight-h-30)/2, w+30, h+30);
    
    for (UIView *subview in views) {
        subview.y += 50;
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        // logo 移动
        [UIView animateWithDuration:1.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:0 animations:^{
            
            view.frame = CGRectMake(x, y, w, h);
            
        } completion:^(BOOL finished) {
            // 完成之后显示所有的显示
            [UIView animateWithDuration:1.0 animations:^{
                for (UIView *subview in views) {
                    subview.alpha ++;
                }
            }];
            
//            for (int i = 0; i < views.count; i++) {
//                [UIView animateWithDuration:1.0 delay:i/10 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:0 animations:^{
//                   
//                    UIView *subview = (UIView *)views[i];
//                    subview.y -=50 ;
//                    
//                } completion:^(BOOL finished) {
//                    
//                }];
//            }
            
            
        }];
        
//    });
    
}

@end
