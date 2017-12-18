//
//  EPGoodsUpHttpRequest.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPGoodsUpHttpRequest : NSObject

/**
 *  上架/删除/仓库商品列表
 *
 *  @param goodsID <#goodsID description#>
 *  @param type    3：上架  6：删除  1:仓库商品列表
 *  @param Vc      <#Vc description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)pushGoodsWithID:(NSString *)goodsID type:(NSString *)type InVC:(UIViewController *)Vc success:(void(^)(NSArray *modelArr))success failure:(void(^)(NSError *error))failure;

@end
