//
//  GetData.h
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GetData : NSObject

/**
 *  请求数据
 *
 *  @param url     <#url description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)getDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  请求数据
 *
 *  @param url        url
 *  @param params     params
 *  @param Vc         做系统提示所在的控制器
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+(void)getDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params ViewController:(UIViewController *)Vc success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//上传图片到服务器
+(void)postDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params imageDatas:(NSArray *)images success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
/**
 *  登录
 *
 *  @param userName   用户名
 *  @param password   密码
 *  @param newPassword 新密码
 *  @param manual     0 自动 1自动
 *  @param loginTime  手动登录时间戳
 *  @param newPhoneNo 更换手机号
 *  @param clientId   通知识别id
 *  @param app        2 政企端 3 商户端
 *  @param type       功能区分 0代表登录
 *  @param validCode  验证码
 *  @param block      回调
 */
- (void)loginForManagementUserName:(NSString *)userName withPassword:(NSString *)password withManual:(NSString *)manual wihLoginTime:(NSString *)loginTime withClientId:(NSString *)clientId withApp:(NSString *)app withType:(NSString *)type withValidCode:(NSString *)validCode withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block;
/**
 *  请求验证码
 *
 *  @param userName   用户名
 *  @param phoneNo    手机号
 *  @param loginTime  手动登录时间戳
 *  @param type       功能区分 0 找回密码  1换手机号 2 指定号码发送验证码
 *  @param block      回调
 */
- (void)getVaildCodeForManagementUserName:(NSString *)userName withPhoneNo:(NSString *)phoneNo withLoginTime:(NSString *)loginTime  withType:(NSString *)type withCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block;
/**
 *  获取商家信息接口
 *
 *  @param type       功能区分 0 获取商家详情信息  1获取商家账户信息
 *  @param block      回调
 */
- (void)getOwnShopDataWithType:(NSString *)type  withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block;
/**
 *  获取订单明细
 *
 *  @param type       功能区分 0 获取全部订单  1已使用订单 2未使用 3待付款订单 4获取申请退款列表 5 商家同意退单确认
 *  @param vcode      兑换码
 *  @param block       回调
 */
- (void)getOrderDetailsWithType:(NSString *)type withCode:(NSString *)vcode withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block;
/**
 *  店铺营收查询
 *
 *  @param type       功能区分 0 获取商家所有营收记录  1按照日周月获取 2 按照开始结束日期获取
 *  @param dataModel  0 日 1周 2月
 *  @param startDate  开始日期
 *  @param endDate    结束日期
 *  @param block       回调
 */
- (void)getRevenueInfoWithType:(NSString *)type withDataModel:(NSString *)dataModel withStartDate:(NSString *)startDate withEndDate:(NSString *)endDate withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block;
/**
 *  兑换码查询and使用
 *
 *  @param type       功能区分 0 获取序列号信息  1扫码获取序列号信息 2 确认使用
 *  @param vcodes     序列号列表
 *  @param vcode      扫码场合发送
 *  @param block       回调
 */
- (void)getVcodesInfoWithType:(NSString *)type withVcodes:(NSString *)vcodes withVcode:(NSString *)vcode  withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block;
/**
 *  获取商家营业状态
 *
 *  @param type       功能区分 0 获取  1改变
 *  @param block       回调
 */
- (void)getBusinessStatus:(NSString *)type withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block;
/**
 *  获取UUID
 */
+(NSString *)getUniqueStrByUUID;
/**
 *  获取提现以及记录信息
 *
 *  @param type       功能区分 0 获取银行卡号  1提现 2提现历史记录
 *  @param money       提现金额
 *  @param block       回调
 */
- (void)getWithdrawRecord:(NSString *)type withMoney:(NSString *)money withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block;

/**
 *  快速创建alertView
 *
 *  @param VC      要显示在哪个控制器上面
 *  @param title   显示内容的主题
 *  @param message 显示的内容
 *  @param index   下面有几个按钮 （只有确定和取消按钮 0代表一个，其他数字代表有两个）
 *  @param what    点击确定按钮之后做得事情0
 */
+ (void)addAlertViewInView:(UIViewController *)VC title:(NSString *)title message:(NSString *)message count:(int)index doWhat:(void (^)(void))what;

+ (void)addAlertViewInVC:(UIViewController *)VC btnText1:(NSString *)text1 btnText2:(NSString *)text2 title:(NSString *)title message:(NSString *)message doWhat:(void (^)(void))what;

/**
 *  添加MBProgress
 *
 *  @param view 添加到哪个视图上
 */
+ (void)addMBProgressWithView:(UIView *)view style:(int)index;
+ (void)showMBWithTitle:(NSString *)title;
+ (void)hiddenMB;

@end
