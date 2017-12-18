//
//  EPPassXiuGaiVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPPassXiuGaiVC.h"
#import "EPPhoneSureVC.h"
@interface EPPassXiuGaiVC ()

@end

@implementation EPPassXiuGaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"修改登录密码"];
    self.tfNewPass.layer.masksToBounds=YES;
    self.tfNewPass.layer.cornerRadius=5;
    self.tfAgainPass.layer.masksToBounds=YES;
    self.tfAgainPass.layer.cornerRadius=5;
    
    self.submitBtn.layer.masksToBounds=YES;
    self.submitBtn.layer.cornerRadius=5;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [EPTool getPublicKey];
}
- (IBAction)submitClickBtn:(UIButton *)sender {
    if (self.tfNewPass.text.length==0||self.tfAgainPass.text.length==0) {
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"输入的内容不能为空" count:0 doWhat:nil];
    }else if([self.tfNewPass.text isEqualToString:self.tfAgainPass.text]){
        //密码一致
        if (self.isChuan==0) {
            //修改找回密码
            GetData * data=[GetData new];
            NSString * pass=[EPRSA encryptString:self.tfNewPass.text publicKey:publicKeyRSA];
            [data loginForManagementUserName:self.userName withPassword:pass withManual:nil wihLoginTime:nil withClientId:nil withApp:@"3" withType:@"3" withValidCode:self.code withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
                if ([returnCode intValue]==0) {
                    //找回密码成功
                    [self.navigationController popViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"pass" object:nil];
                }else if ([returnCode intValue]==1){
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                }if ([returnCode intValue]==2)
                {
                    [EPTool publicDeleteInfo];
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                        [EPTool otherLogin];
                    }];
                }else{
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您的网络有点问题,请重试" count:0 doWhat:nil];
                }
                
            }];
        }else{
            CYLog(@"修改密码");
            GetData * data=[GetData new];
            //新密码
            NSString * pass1=[EPRSA encryptString:self.tfNewPass.text publicKey:publicKeyRSA];
            //原密码
            NSString * pass2=[EPRSA encryptString:self.pass publicKey:publicKeyRSA];
            [data loginForManagementUserName:USERNAME withPassword:pass1 withManual:pass2 wihLoginTime:LOGINTIME withClientId:nil withApp:@"3" withType:@"2" withValidCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
                CYLog(@"%@",dict);
                if ([returnCode intValue]==0) {
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:@"修改密码成功" count:0 doWhat:^{
                        [self.navigationController popViewControllerAnimated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"passXG" object:nil];
                    }];
                }else if ([returnCode intValue]==1){
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                }if ([returnCode intValue]==2)
                {
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                }else{
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您的网络有点问题,请重试" count:0 doWhat:nil];
                }
            }];
        }
    }else{
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您两次输入的密码不一致" count:0 doWhat:nil];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
