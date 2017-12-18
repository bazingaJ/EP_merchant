//
//  EPGoodsUpHttpRequest.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//  商品上架的网络请求

#import "EPGoodsUpHttpRequest.h"
#import "EPParams.h"
#import "NSString+StringForUrl.h"

#import "EPGoodsInfo.h"

@implementation EPGoodsUpHttpRequest

+(void)pushGoodsWithID:(NSString *)goodsID type:(NSString *)type InVC:(UIViewController *)Vc success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [EPParams params];
    if ([type isEqualToString:@"3"]||[type isEqualToString:@"6"]) { // 上架和删除
        params[@"goodsId"] = goodsID;
    }
    params[@"type"] = type;
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"getAllGoodsData"] params:params ViewController:Vc success:^(id response) {
        
        NSInteger typeNum = [type integerValue];
        if (typeNum==3||typeNum==6) {
            if (success) {
                success(nil);
            }
        }else if (typeNum==1){
            
            NSArray *array = response[@"goodsArr"];
            NSMutableArray *modelArr = [NSMutableArray array];
            // 字典转模型
            for (NSDictionary *dict in array) {
                EPGoodsInfo *goodsInfo = [EPGoodsInfo goodsInfoWithDIctionary:dict];
                
                [modelArr addObject:goodsInfo];
            }
            
            if (success) {
                // 返回模型数组
                success(modelArr);
            }
            
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
