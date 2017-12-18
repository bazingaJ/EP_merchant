//
//  AppDelegate.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "AppDelegate.h"
#import "EPTabbarViewController.h"
#import "EPLoginViewController.h"
#import "JDPushDataTool.h"
//注册APNs服务器的时候需要的参数
NSString *const NotificationCategoryIdent = @"ACTIONABLE";
NSString *const NotificationActionOneIdent = @"FIRST_ACTIOIN";
NSString *const NotificationActionTwoIdent = @"SECOND_ACTION";
@interface AppDelegate ()

@property (nonatomic, strong)EPTabbarViewController * jtabbar;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 状态栏为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    self.jtabbar= [[EPTabbarViewController alloc]init];
    UINavigationController * tabbarNav =[[UINavigationController alloc] initWithRootViewController:self.jtabbar];
    tabbarNav.navigationBarHidden = YES;
    tabbarNav.navigationBar.barTintColor=ColorWithRGB(29, 32, 40, 1);
    if (LOGINTIME==nil) {
        [self goLogin];
    }else{
        //自动登录成功
        self.window.rootViewController=tabbarNav;
        [EPLoginViewController autoLogin];
    }
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    // 注册APNS
    [self registerUserNotification];
    [self.window makeKeyAndVisible];
    return YES;
}
// 收到内存警告的时候调用 SDWebImage
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 取消所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    //清空缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
    
}
//让项目禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)registerUserNotification
{
    //如果是ios8.0 and later
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>= 8.0)
    {
        //IOS8 新的通知机制category注册
        //执行的动作一
        UIMutableUserNotificationAction *action1 ;
        action1 =[[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeForeground];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setTitle:@"取消"];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        //执行的动作二
        UIMutableUserNotificationAction * action2 ;
        action2 =[[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setTitle:@"接收"];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        //设置categorys
        UIMutableUserNotificationCategory * actionCategorys =[[UIMutableUserNotificationCategory alloc] init];
        [actionCategorys setIdentifier:NotificationCategoryIdent];
        [actionCategorys setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];
        //将类型 装在集合里面
        NSSet * categories =[NSSet setWithObject:actionCategorys];
        UIUserNotificationType types =(UIUserNotificationTypeAlert |
                                       UIUserNotificationTypeSound |
                                       UIUserNotificationTypeBadge);
        //设置 set属性
        UIUserNotificationSettings * settings =[UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication]registerForRemoteNotifications];
        [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
    }
    else
    {
        UIRemoteNotificationType apn_type =(UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:apn_type];
    }
    
}//如果APNs注册成功了就会返回一个 ============>>DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    NSString * myToken =[[deviceToken description]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken =[myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [GeTuiSdk registerDeviceToken:myToken]; //向个推服务器注册deviceToken
}
//如果APNS 注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [GeTuiSdk registerDeviceToken:@""];
}

//个推启动成功返回clientID
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId
{
    if (clientId.length>0)
    {
        NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
        [us setValue:clientId forKey:@"clientID"];
        [us synchronize];
    }
    else
    {
        NSLog(@"没有获取到clientID");
    }
    
}
//个推遇到错误回调
- (void)GeTuiSdkDidOccurError:(NSError *)error
{
    NSLog(@"个推遇到错误 :%@",[error localizedDescription]);
}
int i=0;
int j=0;
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId
{
    
    NSData * payload =[GeTuiSdk retrivePayloadById:payloadId];
    NSString * payloadMsg =nil;
    if (payload)
    {
        payloadMsg=[[NSString alloc]initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
    
    //data类型转为JSON数据
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:payload options:0 error:nil];
    NSDictionary *dict = (NSDictionary *)json;
    
    /**
     *  如果传过来的通知是有用的就显示到消息栏，如果没用，只做推送，不展示
     */
    //获取当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY/MM/dd HH:mm:ss";
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSMutableDictionary *pushDict = [NSMutableDictionary dictionary];
    pushDict[@"title"] = dict[@"title"];
    pushDict[@"content"] = dict[@"content"];
    pushDict[@"currentTime"] = currentTime;
    pushDict[@"flag"] = @"0";
    pushDict[@"methodName"] = dict[@"methodName"];
    pushDict[@"userId"]=USERID;
    JDPushDataTool *tool = [[JDPushDataTool alloc] init];
    [tool createTable];
    if ([dict[@"content"] isEqualToString:@"您的店铺有一条新的订单！"])
    {
        //购买通知
        j++;
        NSUserDefaults * us=[NSUserDefaults standardUserDefaults];
        [us setObject:[NSString stringWithFormat:@"%d",j++] forKey:@"orderNum"];
        [us setObject:@"2" forKey:@"order"];
        [us synchronize];
        [tool insertValuesForKeysWithDictionary:pushDict];
        
    }
    if ([dict[@"content"] isEqualToString:@"您的店铺有一条新的退款申请！"])
    {
        i++;
        NSUserDefaults * us=[NSUserDefaults standardUserDefaults];
        [us setObject:[NSString stringWithFormat:@"%d",i++] forKey:@"exitNum"];
        [us setObject:@"3" forKey:@"exit"];
        [us synchronize];
        //退款通知
        [tool insertValuesForKeysWithDictionary:pushDict];
    }
    NSString * msg =[NSString stringWithFormat:@"payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>":@""];
     NSLog(@"个推收到的payload是%@",msg);
    if ([[NSString stringWithFormat:@"%@",dict[@"content"]] isEqualToString:@"已在别处登录，请注意是否为本人登录！"]){
       [EPTool publicDeleteInfo];
        UIViewController *rootVc=   [UIApplication sharedApplication].keyWindow.rootViewController;
            [EPTool addAlertViewInView:rootVc title:@"温馨提示" message:@"已在别处登录，请注意是否为本人登录！" count:0 doWhat:^{
                if ([rootVc isKindOfClass:[EPLoginViewController class]]) {
                    return ;
                }
                [self goLogin];
            }];
    }
    
}
-(void)goLogin{
    
    EPLoginViewController *loginVC = [[EPLoginViewController alloc] init];
    UINavigationController * tabbarNav =[[UINavigationController alloc] initWithRootViewController:loginVC];
    tabbarNav.navigationBarHidden = YES;
    tabbarNav.navigationBar.barTintColor=ColorWithRGB(29, 32, 40, 1);
    self.window.rootViewController=tabbarNav;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
