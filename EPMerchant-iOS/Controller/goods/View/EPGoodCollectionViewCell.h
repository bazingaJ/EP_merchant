//
//  EPGoodCollectionViewCell.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/28.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPGoodsInfo.h"
@interface EPGoodCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;

@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@property(nonatomic,strong)EPGoodsInfo * model;

@end
