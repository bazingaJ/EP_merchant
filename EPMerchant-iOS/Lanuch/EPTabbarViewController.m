//
//
//  Created by jeaderQ on 16/3/21.
//  Copyright © 2016年 jeaderQ. All rights reserved.
//

#import "EPTabbarViewController.h"
#import "EPSequenceNumVC.h"
#import "EPGoodsVC.h"
#import "EPShopVC.h"
#import "CYTabBar.h"
#import "EPSquenceLoohStyleVC.h"
@interface EPTabbarViewController ()<UIGestureRecognizerDelegate>

@end

@implementation EPTabbarViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewController];
    [self setUpTabBar];
    
}
-(void)setUpTabBar
{
    // 先隐藏自带的tabBar
    self.tabBar.hidden = YES;
    // 添加自己的tabBar
    CYTabBar *tabBar = [[CYTabBar alloc] initWithControllerNameArray:@[@"店铺",@"商品",@"序列号"]];
     NSArray * tabBarText = @[@"shop",@"commodity",@"serial-number"];
     NSArray * tabBarText2 = @[@"shop_highlight",@"commodity_highlight",@"serial_number_highlight"];
    tabBar.imageArr = tabBarText;
    tabBar.selectImageArr = tabBarText2;
    
    [self.view addSubview:tabBar];
    
    // tabbar的点击
    [tabBar tabBarButtonClick:^(NSInteger index) {
        self.selectedIndex = index;
    }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (self.childViewControllers.count == 0) {
        // 根控制器下,不允许接受手势
        return NO;
    }
    return YES;
}
-(void)bindViewController
{
    
    EPShopVC *firstVc = [[EPShopVC alloc] init];
    
    EPGoodsVC * secondVc =[[EPGoodsVC alloc] init];
    
    EPSquenceLoohStyleVC *thirdVC = [[EPSquenceLoohStyleVC alloc] init];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:firstVc,secondVc,thirdVC, nil];

    self.viewControllers = viewControllers;
    self.selectedIndex = 1;
    
}
@end
