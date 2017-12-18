//
//  EPGoodsReosityButton.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EPGoodsReposityBtnViewDelegate <NSObject>

@optional
-(void)goodsReposityButtonClick:(NSInteger)index indexPath:(NSIndexPath *)indexPath;

@end

@interface EPGoodsReosityButtonView : UIView
/**
 *  按钮名称数组
 */
@property (nonatomic, strong) NSArray *buttonNames;

@property (nonatomic, weak) id<EPGoodsReposityBtnViewDelegate>delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
