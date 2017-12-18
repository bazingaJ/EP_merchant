//
//  EPDetailModel.h
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/18.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPDetailModel : NSObject

@property(nonatomic,copy)NSString * goodsImg;
@property(nonatomic,copy)NSString * goodsName;
@property(nonatomic,copy)NSString * goodsPrice;
@property(nonatomic,copy)NSString * goodsStar;
@property(nonatomic,copy)NSString * soldNumber;
@property(nonatomic,copy)NSString * goodsPosition;
/**商品详细图片*/
@property(nonatomic,copy)NSString * describeImg;
@property(nonatomic,strong)NSArray * detailsRecord;
@property(nonatomic,strong)NSArray * addRecord;
@property(nonatomic,strong)NSArray * record;

@end

@interface EPGetCommentModel : NSObject

/**头像*/
@property(nonatomic,copy)NSString * headImgAddress;
/**昵称*/
@property(nonatomic,copy)NSString * passengerName;
/**星级数*/
@property(nonatomic,copy)NSString *  commentStar;
/**时间*/
@property(nonatomic,copy)NSString * commentTime;
/**评论内容*/
@property(nonatomic,copy)NSString * commentContent;
///**商品名称*/
//@property(nonatomic,copy)NSString * goodsName;

@end
