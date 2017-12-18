//
//  NSString+StringForUrl.m
//  eTaxi-iOS
//
//  Created by jeader on 16/2/2.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "NSString+StringForUrl.h"

@implementation NSString (StringForUrl)

+(NSString *)urlWithApiName:(NSString *)apiName
{

    //zhaoyue0818.imwork.net
    
    //com-jeader-tad.6655.la:20959 123:com-jeader-tad.6655.la:10610 250:com-jeader-tad.6655.la:10397
    //http://com-jeader-tad.6655.la:80/tad/
    
    // 192.168.1.128:8080
    // com-jeader-tad.6655.la:10915 250
    // 114.55.57.237
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@.json",EPUrl,apiName];
    
    return urlStr; 
}

@end
