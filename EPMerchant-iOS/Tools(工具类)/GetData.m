//
//  GetData.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "GetData.h"

#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface GetData ()


@end

static MBProgressHUD *_mbV;

@implementation GetData

//请求网络数据
+(void)getDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/xml",nil]];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}

// 请求数据并根据returnCode做好处理
+(void)getDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params ViewController:(UIViewController *)Vc success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/xml",nil]];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        // 根据返回值做判断
        int returnCode = [responseObject[@"returnCode"] intValue];
        NSString *msg = [responseObject[@"msg"] description];
        
        if (returnCode==0) { // 请求成功
            if (success) {
                success(responseObject);
            }
        }else if(returnCode==1){ // 请求失败
            if (!msg) return ;
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:msg count:0 doWhat:^{
                
            }];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (error) {
            
            failure(error);
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"服务器错误!" count:0 doWhat:^{
               
            }];
        }
        
    }];
}

//上传图片
+(void)postDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params imageDatas:(NSArray *)images success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/xml",nil]];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (images==nil) {
            return ;
        }
        for (UIImage *image in images) {
            NSData *imageData = UIImagePNGRepresentation(image);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            
            /*
            此方法参数
            1. 要上传的[二进制数据]
            2. 对应网站上[upload.php中]处理文件的[字段"file"]
            3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
            */
            [formData appendPartWithFileData:imageData name:@"goodsIcon" fileName:fileName mimeType:@"image/png"];
            
        }
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(responseObject);

        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}
//登录相关
- (void)loginForManagementUserName:(NSString *)userName withPassword:(NSString *)password withManual:(NSString *)manual wihLoginTime:(NSString *)loginTime withClientId:(NSString *)clientId withApp:(NSString *)app withType:(NSString *)type withValidCode:(NSString *)validCode withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block{
    NSString * str =[NSString stringWithFormat:@"%@/loginForManagement.json",EPUrl];
    NSDictionary * inDict=[[NSDictionary alloc]init];
    if ([type intValue]==0) {
        if ([manual intValue]==0) {
            //自动登录
            NSDictionary * dict=@{@"userName":userName,
                                  @"manual":manual,
                                  @"loginTime":loginTime,
                                  @"app":app,
                                  @"type":type};
            inDict=dict;
            
        }else{
            //手动登录
            NSDictionary * dict=@{@"userName":userName,
                                  @"password":password,
                                  @"manual":manual,
                                  @"clientId":clientId,
                                  @"app":app,
                                  @"type":type};
            inDict=dict;
        }
    }else if ([type intValue]==1){
        //修改手机号
        
    }else if ([type intValue]==2){
        //修改密码
        NSDictionary * dict=@{@"userName":userName,
                              @"loginTime":loginTime,
                              @"password":manual,
                              @"newPassword":password,
                              @"app":app,
                              @"type":type};
        inDict=dict;
        
    }else if ([type intValue]==3){
        //找回密码的修改密码
        NSDictionary * dict=@{@"userName":userName,
                              @"newPassword":password,
                              @"validCode":validCode,
                              @"app":app,
                              @"type":type};
        inDict=dict;
    }else if ([type intValue]==4){
        //用户注销
        NSDictionary * dict=@{@"userName":userName,
                              @"loginTime":loginTime,
                              @"app":app,
                              @"type":type};
        inDict=dict;
        
    }else if ([type intValue]==5){
        //验证密码
        NSDictionary * dict=@{@"userName":userName,
                              @"loginTime":loginTime,
                              @"app":app,
                              @"password":password,
                              @"type":type
                              };
        inDict=dict;
        
    }else{
        //验证验证码
        NSDictionary * dict=@{@"userName":userName,
                              @"validCode":validCode,
                              @"app":app,
                              @"type":type};
        inDict=dict;
        
    }
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:str parameters:inDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * loginTime=responseObject[@"loginTime"];
        NSString * msg =[responseObject objectForKey:@"msg"];
       if (loginTime) {
            NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
            [us setValue:loginTime forKey:@"loginTime"];
            [us synchronize];
        }
        if ([returnCode intValue]==0)
        {
            block(responseObject,returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(responseObject,returnCode,msg);
        }
        else
        {
            block(responseObject,returnCode,msg);
        }
       
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
//获取验证码
- (void)getVaildCodeForManagementUserName:(NSString *)userName withPhoneNo:(NSString *)phoneNo withLoginTime:(NSString *)loginTime  withType:(NSString *)type withCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block{
    NSString * str =[NSString stringWithFormat:@"%@/getVaildCodeForManagement.json",EPUrl];
    NSDictionary * inDict=[[NSDictionary alloc]init];
    if ([type intValue]==0) {
        NSDictionary * dict=@{@"userName":userName,
                              @"type":type};
        inDict=dict;
    }
    if ([type intValue]==1) {
        NSDictionary * dict=@{@"userName":userName,
                              @"type":type,
                              @"phoneNo":phoneNo,
                              @"loginTime":loginTime};
        inDict=dict;
    }
    CYLog(@"%@",inDict);
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:inDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        CYLog(@"%@",responseObject);
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(returnCode,msg);
        }
        else
        {
            block(returnCode,msg);
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
//获取商家详情信息
- (void)getOwnShopDataWithType:(NSString *)type  withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block{
    NSString * str =[NSString stringWithFormat:@"%@/getOwnShopData.json",EPUrl];
    NSDictionary * inDict=[[NSDictionary alloc]init];
    if ([type intValue]==0) {
        //商家详情
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }else{
        //获取商家账户信息
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
        
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:inDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(responseObject,returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(responseObject,returnCode,msg);
        }
        else
        {
            block(responseObject,returnCode,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
//获取订单明细
- (void)getOrderDetailsWithType:(NSString *)type withCode:(NSString *)vcode withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block{
    NSString * str =[NSString stringWithFormat:@"%@/getOrderDetails.json",EPUrl];
    NSDictionary * inDict=[[NSDictionary alloc]init];
    if ([type intValue]==0) {
        //获取全部订单
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }
    if ([type intValue]==1) {
        //已使用订单
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }
    if ([type intValue]==2) {
        //未使用订单
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }
    if ([type intValue]==3) {
        //待付款订单
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }
    if ([type intValue]==4) {
        //获取申请退款列表
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }
    if ([type intValue]==5) {
        //商家同意退单确认
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"vcode":vcode,
                              @"type":type};
        inDict=dict;
    }
    NSLog(@"----%@",inDict);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:inDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(responseObject,returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(responseObject,returnCode,msg);
        }
        else
        {
            block(responseObject,returnCode,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
//店铺营收查询
- (void)getRevenueInfoWithType:(NSString *)type withDataModel:(NSString *)dataModel withStartDate:(NSString *)startDate withEndDate:(NSString *)endDate withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block{
    NSString * str =[NSString stringWithFormat:@"%@/getRevenueInfo.json",EPUrl];
    NSDictionary * inDict=[[NSDictionary alloc]init];
    if ([type intValue]==0) {
        //获取商家所有营收记录
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }
    if ([type intValue]==1) {
        //按照日周月获取
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type,
                              @"dateModel":dataModel};
        inDict=dict;
    }
    if ([type intValue]==2) {
        //按照开始结束日期获取
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type,
                              @"startDate":startDate,
                              @"endDate":endDate};
        inDict=dict;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:inDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(responseObject,returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(responseObject,returnCode,msg);
        }
        else
        {
            block(responseObject,returnCode,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
//兑换码查询and使用
- (void)getVcodesInfoWithType:(NSString *)type withVcodes:(NSString *)vcodes withVcode:(NSString *)vcode  withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block{
    NSString * str =[NSString stringWithFormat:@"%@/getVcodesInfo.json",EPUrl];
    NSDictionary * inDict=[[NSDictionary alloc]init];
    if ([type intValue]==0) {
        //获取序列号信息
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type,
                              @"vcodes":vcodes};
        inDict=dict;
    }
    if ([type intValue]==1) {
        //扫码获取序列号信息
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type,
                              @"vcode":vcode};
        inDict=dict;
    }
    if ([type intValue]==2) {
        //确认使用
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type,
                              @"vcodes":vcodes};
        inDict=dict;
    }
    if ([type intValue]==3) {
        //获取历史记录
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }
    CYLog(@"兑换码-----%@",inDict);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:inDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(responseObject,returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(responseObject,returnCode,msg);
        }
        else
        {
            block(responseObject,returnCode,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
//获取营业状态
- (void)getBusinessStatus:(NSString *)type withCompletionBlock:(void(^)(NSDictionary * dict,NSString * returnCode,NSString * msg))block{
    NSString * str =[NSString stringWithFormat:@"%@/getBusinessStatus.json",EPUrl];
    NSDictionary * inDict=[[NSDictionary alloc]init];
    if ([type intValue]==0) {
        //获取运营状态
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }else{
        //改变运营
        NSDictionary * dict=@{@"userName":USERNAME,
                              @"loginTime":LOGINTIME,
                              @"type":type};
        inDict=dict;
    }
    CYLog(@"inDict===%@",inDict);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:inDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(responseObject,returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(responseObject,returnCode,msg);
        }
        else
        {
            block(responseObject,returnCode,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
+(NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    return retStr;
}
/**获取提现历史记录*/
- (void)getWithdrawRecord:(NSString *)type withMoney:(NSString *)money withCompletionBlock:(void (^)(NSDictionary *, NSString *, NSString *))block{
    NSString * str =[NSString stringWithFormat:@"%@/getWithdrawRecord.json",EPUrl];
    NSDictionary * inDict=[[NSDictionary alloc]init];
    if ([type intValue]==0) {
        //获取银行卡号
        NSDictionary * dict=@{@"userName":USERNAME,@"loginTime":LOGINTIME,@"type":type};
        inDict=dict;
    }
    if ([type intValue]==1) {
        //提现
        NSDictionary * dict=@{@"userName":USERNAME,@"loginTime":LOGINTIME,@"money":money,@"type":type};
        inDict=dict;
    }
    if ([type intValue]==2) {
        NSDictionary * dict=@{@"userName":USERNAME,@"loginTime":LOGINTIME,@"type":type};
        inDict=dict;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:inDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        CYLog(@"提现以及历史记录----->%@",responseObject);
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(responseObject,returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(responseObject,returnCode,msg);
        }
        else
        {
            block(responseObject,returnCode,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
+ (void)addAlertViewInView:(UIViewController *)VC title:(NSString *)title message:(NSString *)message count:(int)index doWhat:(void (^)(void))what
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action = [[UIAlertAction alloc] init];
    
    UIAlertAction *action1 = [[UIAlertAction alloc] init];
    
    if(index == 0){
        
        action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (what)
            {
                what();
            }
            
        }];
        
        action1 = nil;
        
    }else{
        
        action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            what();
            
        }];
        
        action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        
    }
    
    
    if (action1) {
        
        [alert addAction:action1];
        
    }
    [alert addAction:action];
    
    [VC presentViewController:alert animated:YES completion:^{
        
    }];
    
}

+(void)addAlertViewInVC:(UIViewController *)VC btnText1:(NSString *)text1 btnText2:(NSString *)text2 title:(NSString *)title message:(NSString *)message doWhat:(void (^)(void))what
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:text1 style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:text2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (what) {
            what();
        }
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [VC presentViewController:alert animated:YES completion:^{
        
    }];
    
    
}


/**
 *  添加MBProgress
 *
 *  @param view 添加到哪个视图上
 *  @param index MB展现的方式，0代表添加刷新视图，1代表不添加刷新只显示文字
 */
+(void)addMBProgressWithView:(UIView *)view style:(int)index
{
    _mbV = [[MBProgressHUD alloc] initWithView:view];
    
    if (index == 0) {
        
        _mbV.mode = MBProgressHUDModeIndeterminate;
        
    }else{
        
        _mbV.mode = MBProgressHUDModeCustomView;
        
    }
    /**
     *  自定义view
     */
//    _mbV.customView
    
    _mbV.color = [UIColor whiteColor];
    [view addSubview:_mbV];
    
    _mbV.activityIndicatorColor = [UIColor blackColor];
    
}

+(void)showMBWithTitle:(NSString *)title
{
    _mbV.labelText = title;
    _mbV.labelColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [_mbV show:YES];
}

+(void)hiddenMB
{
    [_mbV hide:YES afterDelay:0.5];
}

@end
