//
//  CYTabBarButton.h
//  CYQQ
//
//  Created by jeader on 16/5/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYTabBarButtonDelegate <NSObject>

@optional

-(void)tabBarButtonClickIndex:(NSInteger)index;

@end

@interface CYTabBarButton : UIView
/**
 *  主题
 */
@property (nonatomic, copy) NSString *name;
/**
 *  图片
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  选中状态的图片
 */
@property (nonatomic, strong) UIImage *selectImage;

/**
 *  btn的tag值
 */
@property (nonatomic, assign) NSInteger bar_tag;

/**
 *  是否为选中状态
 */
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) id<CYTabBarButtonDelegate>delegate;


@end
