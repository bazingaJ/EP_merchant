//
//  EPGoodsInfo.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPGoodsInfo.h"

#import "MJExtension.h"

@implementation EPGoodsInfo

+(instancetype)goodsInfoWithDIctionary:(NSDictionary *)dict
{
    id goodsData = [self mj_objectWithKeyValues:dict];
    
    return goodsData;
}

@end
