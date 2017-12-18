//
//  EPGoodsReposityCell.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPGoodsReosityButtonView;
@interface EPGoodsReposityCell : UICollectionViewCell

//@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) EPGoodsReosityButtonView *btnView;
/**
 *  商品图片
 */
@property (nonatomic, weak) UIImageView *goodsImageView;
/**
 *  商品名称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  价格
 */
@property (nonatomic, weak) UILabel *priceLabel;

@end
