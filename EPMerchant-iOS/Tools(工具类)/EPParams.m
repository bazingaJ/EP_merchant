//
//  EPParams.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPParams.h"

@implementation EPParams

+(NSMutableDictionary *)params
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = USERNAME;
    params[@"loginTime"] = LOGINTIME;
    
    return params;
}

@end
