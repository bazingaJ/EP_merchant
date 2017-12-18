//
//  EPResultModel.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/13.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
//查询结果
@interface EPResultModel : NSObject

/**兑换码*/
@property(nonatomic,copy)NSString * vcode;
/**购买时间*/
@property(nonatomic,copy)NSString * buyTime;
/**商品图片*/
@property(nonatomic,copy)NSString * goodsImg;
/**商品名称*/
@property(nonatomic,copy)NSString * goodsName;
/**商品价格*/
@property(nonatomic,copy)NSString * goodsPrice;
/**状态*/
@property(nonatomic,copy)NSString * state;

@end
@interface EPHistoryModel : NSObject
/**兑换码*/
@property(nonatomic,copy)NSString * vcode;
/**购买时间*/
@property(nonatomic,copy)NSString * useTime;
/**商品图片*/
@property(nonatomic,copy)NSString * goodsImg;
/**商品名称*/
@property(nonatomic,copy)NSString * goodsName;
/**商品价格*/
@property(nonatomic,copy)NSString * goodsPrice;
/**状态*/
@property(nonatomic,copy)NSString * state;

@end
