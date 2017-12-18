//
//  EPRevenueCell.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/6.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPRevenueModel : NSObject

/**商品名称*/
@property(nonatomic,copy)NSString * goodsName;
/**使用状态*/
@property(nonatomic,copy)NSString * orderState;
/**收支*/
@property(nonatomic,copy)NSString * balance;
/**下退单时间*/
@property(nonatomic,copy)NSString * orderDate;
/**使用时间*/
@property(nonatomic,copy)NSString * useDate;
/**总收入*/
@property(nonatomic,copy)NSString * totalMoney;
/**总单数*/
@property(nonatomic,copy)NSString * totalOrderNum;

/**提现金额*/
@property(nonatomic,copy)NSString * money;
/**提现日期*/
@property(nonatomic,copy)NSString * date;

/**银行卡号*/
@property(nonatomic,copy)NSString * bankCard;
/**开户行*/
@property(nonatomic,copy)NSString * bankShop;


@end
