//
//  EPGoodsInfo.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPGoodsInfo : NSObject

@property (nonatomic, copy) NSString *goodsId;

@property (nonatomic, copy) NSString *goodsImg;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *goodsPrice;

+(instancetype)goodsInfoWithDIctionary:(NSDictionary *)dict;

@end
