//
//  EPSetVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPSetVC.h"
#import "EPAccountManagerVC.h"
#import "EPLoginViewController.h"
#import "EPAbountUSVC.h"
#import "EPFeedBookVC.h"
#import "CustomAlertView.h"
@interface EPSetVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property(nonatomic,strong)UISwitch * swi1;
@property(nonatomic,strong)UISwitch * swi2;

@property(nonatomic,copy)NSString * restStatus;

@end

@implementation EPSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"设 置"];
    [self setTb];
}
//设置代理
- (void)setTb{
    self.tb.dataSource=self;
    self.tb.delegate=self;
    self.tb.backgroundColor=ColorWithRGB(233, 234, 235, 1);
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取营业状态
    GetData * data=[GetData new];
    [data getBusinessStatus:@"0" withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        CYLog(@"店铺状态===%@",dict);
        self.restStatus=dict[@"restStatus"];
        if ([self.restStatus intValue]==0) {
            [_swi2 setOn:NO];
        }else{
            [_swi2 setOn:YES];
        }
        [self.tb reloadData];
    }];
}
- (void)closePush:(UISwitch *)swi{
    
    if ([isColse intValue]==0) {
        [_swi1 setOn:NO];
        NSUserDefaults * us=[NSUserDefaults standardUserDefaults];
        [us setObject:@"1" forKey:@"isColse"];
        [us synchronize];
    }else if ([isColse intValue]==1){
        [_swi1 setOn:YES];
        NSUserDefaults * us=[NSUserDefaults standardUserDefaults];
        [us setObject:@"0" forKey:@"isColse"];
        [us synchronize];
        //注销远程推送
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
    
}
- (void)closeShop:(UISwitch *)swi{
    if ([self.restStatus intValue]==0) {
        //正在营业中
        [_swi2 setOn:NO];
    }else{
        [_swi2 setOn:YES];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入登录密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        
        textField.placeholder = @"密码";
        textField.secureTextEntry=YES;
        
    }];
    //添加取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    // 添加一个确定按钮
    UIAlertAction * actionOK = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //获取公钥
        [EPTool getPublicKey];
        UITextField *passTf = alertController.textFields.lastObject;
        if (passTf.text.length==0) {
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"请输入密码" count:0 doWhat:nil];
        }else{
            [EPTool addMBProgressWithView:self.view style:0];
            [EPTool showMBWithTitle:@""];
            GetData * data=[GetData new];
            NSString * pass=[EPRSA encryptString:passTf.text publicKey:publicKeyRSA];
            [data loginForManagementUserName:USERNAME withPassword:pass withManual:nil wihLoginTime:LOGINTIME withClientId:nil withApp:@"3" withType:@"5" withValidCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
                [EPTool hiddenMBWithDelayTimeInterval:0];
                if ([returnCode intValue]==0) {
                    //验证密码成功
                    GetData * data=[GetData new];
                    [data getBusinessStatus:@"1" withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
                        CYLog(@"dict---%@",dict);
                        if ([returnCode intValue]==0) {
                            if ([self.restStatus intValue]==0) {
                                //店铺停业
                                [_swi2 setOn:YES];
                                self.restStatus=@"1";
                                [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您的店铺已处于停业状态" count:0 doWhat:nil];
                            }else{
                                self.restStatus=@"0";
                                [_swi2 setOn:NO];
                                [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您的店铺已恢复正常营业" count:0 doWhat:nil];
                            }
                        }else if ([returnCode intValue]==1){
                            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                        }else if ([returnCode intValue]==2){
                            [EPTool publicDeleteInfo];
                            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                                [EPTool otherLogin];
                            }];
                        }else{
                            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接失败" count:0 doWhat:nil];
                        }
                    }];
                }else if ([returnCode intValue]==1){
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                }else if ([returnCode intValue]==2){
                    [EPTool publicDeleteInfo];
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                        [EPTool otherLogin];
                    }];
                }else{
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接失败" count:0 doWhat:nil];
                }
            }];
 
        }
    }];
    [alertController addAction:cancel];
    [alertController addAction:actionOK];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark---delegate----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 2;
    }else if(section==2){
        return 3;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    NSArray *arr=@[@"账户管理",@"消息推送",@"店铺停业",@"意见反馈",@"关于我们",@"清除缓存",@"退出登录"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UILabel * lb=[[UILabel alloc]init];
        lb.frame=CGRectMake(12, 0, 100, 50);
        lb.font=[UIFont systemFontOfSize:16];
        [cell.contentView addSubview:lb];
        UIView * vc=[[UIView alloc]initWithFrame:CGRectMake(12, 49, ScreenWidth-24, 1)];
        vc.backgroundColor=ColorWithRGB(217, 217,217, 1);
        if (indexPath.section==0) {
            lb.text=arr[0];
        }
        if (indexPath.section==1) {
            cell.accessoryType=UITableViewCellAccessoryNone;
            UISwitch * swi2 =[[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-65, 10, 60, 30)];
            swi2.onTintColor=ColorWithRGB(216, 186, 131, 1);
            [cell.contentView addSubview:swi2];
            if (indexPath.row==0) {
                lb.text=arr[1];
                [cell.contentView addSubview:vc];
                swi2.tag=111;
                if ([isColse intValue]==0) {
                    [swi2 setOn:YES];
                }else if ([isColse intValue]==1){
                    [swi2 setOn:NO];
                }
                [swi2 addTarget:self action:@selector(closePush:) forControlEvents:UIControlEventValueChanged];
                _swi1=swi2;
            }else{
                lb.text=arr[2];
                swi2.tag=222;
                [swi2 addTarget:self action:@selector(closeShop:) forControlEvents:UIControlEventValueChanged];
                _swi2=swi2;
            }
        }
        if (indexPath.section==2) {
            if (indexPath.row==0){
                lb.text=arr[3];
                [cell.contentView addSubview:vc];
            }else if (indexPath.row==1){
                lb.text=arr[4];
                [cell.contentView addSubview:vc];
            }else{
                lb.text=arr[5];
            }
        }
        if (indexPath.section==3) {
            lb.text=[arr lastObject];
        }
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }else{
        return 10;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        EPAccountManagerVC * vc=[[EPAccountManagerVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==2) {
        switch (indexPath.row) {
            case 0:
            {
                //意见反馈
                EPFeedBookVC * vc=[[EPFeedBookVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1:
            {
                //关于我们
                EPAbountUSVC * VC=[[EPAbountUSVC alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
            }
                break;
            case 2:{
                //清除缓存
                [EPTool addAlertViewInView:self title:@"温馨提示" message:@"你确定要清理缓存" count:1 doWhat:^{
                    [[SDImageCache sharedImageCache] clearDisk];
                    [[SDImageCache sharedImageCache] clearMemory];//可有可无
                    float tmpSize = [[SDImageCache sharedImageCache]getSize];
                    if (tmpSize==0.0f)
                    {
                        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"清理完成!" count:0 doWhat:nil];
                    }
                }];
                
            }
                break;
            default:
                break;
        }
    }
    if (indexPath.section==3) {
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您确定退出登录?" count:1 doWhat:^{
            [EPTool checkNetWorkWithCompltion:^(NSInteger statusCode) {
                if (statusCode==0) {
                    //无网络的情况
                    [EPTool publicDeleteInfo];
                    EPLoginViewController * vc=[[EPLoginViewController alloc]init];
                    UINavigationController * tabbarNav =[[UINavigationController alloc] initWithRootViewController:vc];
                    tabbarNav.navigationBarHidden = YES;
                    tabbarNav.navigationBar.barTintColor=ColorWithRGB(29, 32, 40, 1);
                    [UIApplication sharedApplication].keyWindow.rootViewController= tabbarNav;
                }else if(statusCode==1){
                    GetData * data=[GetData new];
                    [data loginForManagementUserName:USERNAME withPassword:nil withManual:nil wihLoginTime:LOGINTIME withClientId:nil withApp:@"3" withType:@"4" withValidCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
                        // CYLog(@"退出登录--%@",dict);
                        if ([returnCode intValue]==0) {
                            //退出登录成功
                            [EPTool publicDeleteInfo];
                            EPLoginViewController * vc=[[EPLoginViewController alloc]init];
                            UINavigationController * tabbarNav =[[UINavigationController alloc] initWithRootViewController:vc];
                            tabbarNav.navigationBarHidden = YES;
                            tabbarNav.navigationBar.barTintColor=ColorWithRGB(29, 32, 40, 1);
                            [UIApplication sharedApplication].keyWindow.rootViewController= tabbarNav;
                            
                        }else if([returnCode intValue]==1){
                            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                        }else if ([returnCode intValue]==2){
                            [EPTool publicDeleteInfo];
                            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                                [EPTool otherLogin];
                            }];
                        }else{
                            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"由于网络问题，连接中断，请稍后重试" count:0 doWhat:nil];
                        }
                    }];
                }
            }];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
