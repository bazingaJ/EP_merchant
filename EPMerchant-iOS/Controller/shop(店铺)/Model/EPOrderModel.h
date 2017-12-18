//
//  EPOrderModel.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/2.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPOrderModel : NSObject

/**商品图片*/
@property(nonatomic,copy)NSString * goodsImg;
/**商品名称*/
@property(nonatomic,copy)NSString * goodsName;
/**订单时间*/
@property(nonatomic,copy)NSString * orderDate;
/**序列号*/
@property(nonatomic,copy)NSString * orderId;
/**状态*/
@property(nonatomic,copy)NSString * orderState;
/**价格*/
@property(nonatomic,copy)NSString * goodsPrice;
@end
