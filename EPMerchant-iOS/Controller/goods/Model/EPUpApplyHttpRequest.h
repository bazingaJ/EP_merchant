//
//  EPUpApplyHttpRequest.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPUpApplyHttpRequest : NSObject

/**
 *  上架申请网络请求(上传商品信息)
 *
 *  @param name    商品名称
 *  @param price   商品价格
 *  @param images  商品图片数组
 *  @param Vc      所在视图控制器
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+(void)pushGoodsInfoApplyWithName:(NSString *)name Price:(NSString *)price Images:(NSArray *)images InVC:(UIViewController *)Vc success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
