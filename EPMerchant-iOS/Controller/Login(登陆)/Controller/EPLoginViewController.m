//
//  EPLoginViewController.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPLoginViewController.h"

#import "EPLoginView.h"

#import "EPTabbarViewController.h"
#import "EPPayPhoneSureVC.h"
#import "EPCoopViewController.h"
#import "EPTabbarViewController.h"
@interface EPLoginViewController () <EPLoginDelegate>

@property(nonatomic,strong)EPLoginView * loginView;

@end

@implementation EPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    EPLoginView *loginView = [[EPLoginView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    loginView.delegate = self;
    _loginView=loginView;
    [self.imageV addSubview:loginView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgerToClick) name:@"forget" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeShop) name:@"becomeShop" object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [EPTool getPublicKey];
}
- (void)forgerToClick{
    EPPayPhoneSureVC * vc=[[EPPayPhoneSureVC alloc]init];
    vc.isBool=0;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)becomeShop{
    EPCoopViewController * vc=[[EPCoopViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark login view delegate
-(void)loginViewClickLoginButton
{
    NSString * phone=_loginView.phoneTextField.textField.text;
    NSString * pass=_loginView.passwordTextField.textField.text;
    if (phone.length==0||pass.length==0) {
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"输入的用户名或者密码为空" count:0 doWhat:nil];
    }else {
        
        [EPTool addMBProgressWithView:self.view style:0];
        [EPTool showMBWithTitle:@"登录中..."];
        GetData *data=[GetData new];
        NSString * password=[EPRSA encryptString:pass publicKey:publicKeyRSA];
        [data loginForManagementUserName:phone withPassword:password withManual:@"1" wihLoginTime:nil withClientId:CLIENTID withApp:@"3" withType:@"0" withValidCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
           // CYLog(@"登录信息---%@",dict);
            if ([returnCode intValue]==0) {
                [EPTool hiddenMBWithDelayTimeInterval:0];
                NSString * useID=[dict[@"userId"] stringValue];
                NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
                [us setValue:phone forKey:@"userName"];
                [us setValue:useID forKey:@"userId"];
                [us synchronize];
                //登录成功
                EPTabbarViewController * jtabbar= [[EPTabbarViewController alloc]init];
                UINavigationController * tabbarNav =[[UINavigationController alloc] initWithRootViewController:jtabbar];
                tabbarNav.navigationBarHidden = YES;
                tabbarNav.navigationBar.barTintColor=ColorWithRGB(29, 32, 40, 1);
                [UIApplication sharedApplication].keyWindow.rootViewController=tabbarNav;
            }else if ([returnCode intValue]==1){
                [EPTool hiddenMBWithDelayTimeInterval:1];
                [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
            }else if ([returnCode intValue]==2){
                [EPTool hiddenMBWithDelayTimeInterval:1];
                [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
            }else{
                [EPTool hiddenMBWithDelayTimeInterval:1];
                [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接中断，请稍后重试" count:0 doWhat:nil];
            }
        }];

    }
}
+ (void)autoLogin{
    GetData *data=[GetData new];
    [data loginForManagementUserName:USERNAME withPassword:nil withManual:@"0" wihLoginTime:LOGINTIME withClientId:nil withApp:@"3" withType:@"0" withValidCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg){
        CYLog(@"自动登录%@",returnCode);
    }];
}

@end
