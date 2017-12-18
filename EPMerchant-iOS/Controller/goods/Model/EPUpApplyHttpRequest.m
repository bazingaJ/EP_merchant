//
//  EPUpApplyHttpRequest.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPUpApplyHttpRequest.h"

#import "NSString+StringForUrl.h"
#import "EPParams.h"

@implementation EPUpApplyHttpRequest

+(void)pushGoodsInfoApplyWithName:(NSString *)name Price:(NSString *)price Images:(NSArray *)images InVC:(UIViewController *)Vc success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [EPParams params];
    params[@"goodsName"] = name;
    params[@"goodsPrice"] = price;
    params[@"type"] = @"4";
    
    [GetData postDataWithUrl:[NSString urlWithApiName:@"getAllGoodsData"] params:params imageDatas:images success:^(id response) {
        
        // 返回值
        NSInteger returnCode = [response[@"returnCode"] integerValue];
        if (returnCode == 0) {
            if (success) {
                success();
            }
        }
        
    } failure:^(NSError *error) {
        
        if (error) {
            
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"请填写正确的信息" count:0 doWhat:nil];
            
            if (failure) {
                failure(error);
            }
        }
        
    }];
}

@end
