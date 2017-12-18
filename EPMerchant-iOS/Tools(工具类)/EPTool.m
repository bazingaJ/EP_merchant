//
//  EPTool.m
//  EPin-IOS
//
//  Created by jeader on 16/4/6.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import "EPTool.h"
#import "MBProgressHUD.h"
#import "EPLoginViewController.h"
static MBProgressHUD *_mbV;

@implementation EPTool

+ (void)addAlertViewInView:(UIViewController *)VC title:(NSString *)title message:(NSString *)message count:(int)index doWhat:(void (^)(void))what
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action = [[UIAlertAction alloc] init];
    
    UIAlertAction *action1 = [[UIAlertAction alloc] init];
    
    if(index == 0)
    {
        action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            if (what)
            {
                what();
            }
            
        }];
        action1 = nil;
    }
    else
    {
        action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            what();
        }];
        action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    }
    if (action1)
    {
        [alert addAction:action1];
    }
    [alert addAction:action];
    [VC presentViewController:alert animated:YES completion:nil];
    
}
//手机号验证合法性
+ (BOOL)validatePhone:(NSString *) textString
{
    NSString* phone=@"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phone];
    return [numberPre evaluateWithObject:textString];
}

+ (BOOL)validatePassword:(NSString *) textString
{
    NSString* password=@"^[0-9]{6}$";//^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",password];
    return [numberPre evaluateWithObject:textString];
}
//输入汉字的正则表达式
+(BOOL)validateChinese:(NSString *) textString
{
    NSString* chinese=@"^[0-9A-Za-z\u4e00-\u9fa5]+$";//^[a-zA-Z\u4e00-\u9fa5]+$     ^[\u4e00-\u9fa5]{0,}$
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chinese];
    return [numberPre evaluateWithObject:textString];
}
- (UIAlertController *)showAlertControllerWithTitle:(NSString *)title WithMessages:(NSString *)msg WithCancelTitle:(NSString *)cancelTitle
{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    return alert;
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
    
    _mbV.color = [UIColor blackColor];
    [view addSubview:_mbV];
    
    _mbV.activityIndicatorColor = [UIColor whiteColor];
    
}

+(void)showMBWithTitle:(NSString *)title
{
    _mbV.labelText = title;
    _mbV.labelFont = [UIFont systemFontOfSize:12];
    _mbV.labelColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [_mbV show:YES];
}

+(void)hiddenMBWithDelayTimeInterval:(int)interval
{
    [_mbV hide:YES afterDelay:interval];
}

+(void)checkNetWorkWithCompltion:(void(^)(NSInteger statusCode))block
{
    NSInteger __block code = 0;
    AFNetworkReachabilityManager * manager =[AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable)
        {
            code = 0;
        }
        else
        {
            code = 1;
        }
        block(code);
    }];
    
}
+ (BOOL)isLogin
{
    //判断有没有token值
    NSString * phoneNo = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    NSString * password =[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    
    if (phoneNo==nil||password==nil)
    {
        return NO;
    }
    
    return YES;
}
+ (void)getPublicKey{
    AFHTTPSessionManager  * manager =[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * url=[NSString  stringWithFormat:@"%@/getPublicKey.json",EPUrl];
   [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString * str =[responseObject objectForKey:@"publicKey"];
        //NSLog(@"公钥==%@",str);
        NSUserDefaults * userDef =[NSUserDefaults standardUserDefaults];
        [userDef setValue:str forKey:@"publicKey"];
        [userDef synchronize];
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
   }];
}
+ (void)publicDeleteInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginTime"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"publicKey"];
}
+ (void)otherLogin{
    EPLoginViewController * vc=[[EPLoginViewController alloc]init];
    UINavigationController * tabbarNav =[[UINavigationController alloc] initWithRootViewController:vc];
    tabbarNav.navigationBarHidden = YES;
    tabbarNav.navigationBar.barTintColor=ColorWithRGB(29, 32, 40, 1);
    [UIApplication sharedApplication].keyWindow.rootViewController= tabbarNav;

}
@end
