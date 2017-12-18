//
//  CYTabBar.m
//  CYQQ
//
//  Created by jeader on 16/5/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYTabBar.h"

#import "CYTabBarButton.h"
//#import "Header.h"

#define TabBarH 60
#define TextLightColor ColorWithRGB(137, 139, 160, 1)
#define TextBlueColor ColorWithRGB(24, 165, 255, 1)
@interface CYTabBar ()<CYTabBarButtonDelegate>

/**
 *  存放控制器名字的数组
 */
@property (nonatomic, strong) NSArray *nameArr;

@property (nonatomic, weak) UILabel *line;

@end

@implementation CYTabBar

- (instancetype)initWithControllerNameArray:(NSArray *)nameArr
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0,ScreenHeight-TabBarH, ScreenWidth, TabBarH);
        self.backgroundColor = [UIColor whiteColor];
        self.nameArr = nameArr;
        
        // 线
        UILabel *line = [[UILabel alloc] init];
        [self addSubview:line];
        line.backgroundColor = TextLightColor;
        _line = line;
        
        // 按钮
        for (int i = 0; i < nameArr.count; i++) {
            CGFloat w = ScreenWidth/nameArr.count, h = TabBarH, x = i*w, y = 0;
            CYTabBarButton *btn = [[CYTabBarButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
            btn.name = nameArr[i];
            btn.bar_tag = i;
            [self addSubview:btn];
            
            btn.delegate = self;

        }
    }
    return self;
}

#pragma mark - CYTabBarButton delegate
-(void)tabBarButtonClickIndex:(NSInteger)index
{
    [self selectBtnIndex:index];
    if (_tabBar) {
        _tabBar(index);
    }
}

#pragma mark - 实现block
-(void)tabBarButtonClick:(TabBarBlock)tabBar
{
    _tabBar = tabBar;
}

#pragma mark - 按钮的选中状态
-(void)selectBtnIndex:(NSInteger)index
{
    int i = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[CYTabBarButton class]]) {
            CYTabBarButton *btn = (CYTabBarButton *)view;
            if (index==i) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            i++;
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _line.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
}

-(void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
    
    int i = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[CYTabBarButton class]]) {
            CYTabBarButton *btn = (CYTabBarButton *)view;
            btn.image = [UIImage imageNamed:imageArr[i]];
            i++;
        }
    }
}
-(void)setSelectImageArr:(NSArray *)selectImageArr
{
    _selectImageArr = selectImageArr;
    
    int i = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[CYTabBarButton class]]) {
            CYTabBarButton *btn = (CYTabBarButton *)view;
            btn.selectImage = [UIImage imageNamed:selectImageArr[i]];
            i++;
        }
    }
    
    [self selectBtnIndex:1];
}

@end
