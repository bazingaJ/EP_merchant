//
//  CYTabBar.h
//  CYQQ
//
//  Created by jeader on 16/5/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TabBarBlock)(NSInteger index);

@interface CYTabBar : UIView

/**
 *  正常状态下的图片名称数组
 */
@property (nonatomic, strong) NSArray *imageArr;
/**
 *  选中状态下的图片名称数组
 */
@property (nonatomic, strong) NSArray *selectImageArr;

@property (nonatomic, strong) TabBarBlock tabBar;

-(instancetype)initWithControllerNameArray:(NSArray *)nameArr;

-(void)tabBarButtonClick:(TabBarBlock)tabBar;

@end
