//
//  EPShopModel.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/2.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPShopModel : NSObject
/**店铺图片*/
@property(nonatomic,copy)NSString * shopImg;
/**商家名称*/
@property(nonatomic,copy)NSString * shopName;
/**经营范围*/
@property(nonatomic,copy)NSString * shopRange;
/**联系方式*/
@property(nonatomic,copy)NSString * shopPhone;
/**商家地址*/
@property(nonatomic,copy)NSString * shopAddress;
@end
