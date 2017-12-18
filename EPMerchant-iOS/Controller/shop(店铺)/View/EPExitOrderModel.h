//
//  EPExitOrderModel.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/5.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPExitOrderModel : NSObject

/**订单号*/
@property(nonatomic,copy)NSString * orderId;
/**商品图片*/
@property(nonatomic,copy)NSString * goodsImg;
/**商品名称*/
@property(nonatomic,copy)NSString * goodsName;
/**商品价格*/
@property(nonatomic,copy)NSString * goodsPrice;
/**订单状态*/
@property(nonatomic,copy)NSString * orderState;
/**下单时间*/
@property(nonatomic,copy)NSString * orderDate;
/**兑换码*/
@property(nonatomic,copy)NSString * vcode;
/**退单原因*/
@property(nonatomic,copy)NSString * applyText;
@end
