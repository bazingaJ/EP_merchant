//
//  EPPayPhoneSureVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPPayPhoneSureVC.h"
#import "EPResetPayPasswordVC.h"
#import "EPPassXiuGaiVC.h"
@interface EPPayPhoneSureVC ()<UITextFieldDelegate>


@end

@implementation EPPayPhoneSureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:2 title:@"手机验证"];
    [self addLeftItemWithFrame:CGRectZero textOrImage:0 action:@selector(backPop) name:@"返回"];
    self.btnCode.layer.masksToBounds=YES;
    self.btnCode.layer.cornerRadius=5;
    self.nextBtn.layer.masksToBounds=YES;
    self.nextBtn.layer.cornerRadius=5;
    self.tfPhone.delegate=self;
    self.tfCode.delegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backPop) name:@"pass" object:nil];
}
- (void)backPop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getCode:(id)sender {
        //获取验证码
        if (self.isBool==0) {
            //忘记密码验证码
            if (self.tfPhone.text.length==0) {
                 [EPTool addAlertViewInView:self title:@"温馨提示" message:@"请输入正确的用户名或者手机号" count:0 doWhat:nil];
            }else{
                GetData * data=[GetData new];
                [data getVaildCodeForManagementUserName:self.tfPhone.text withPhoneNo:nil withLoginTime:nil withType:@"0" withCompletionBlock:^(NSString *returnCode, NSString *msg) {
                    if ([returnCode intValue]==0) {
                        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"成功发送验证码" count:0 doWhat:nil];
                        [sender startWithTime:59 title:@"重新获取" countDownTitle:@"秒后重试" mainColor:ColorWithRGB(32, 118, 229,1)  countColor:ColorWithRGB(32, 118, 229,1)];
                    }else if([returnCode intValue]==1){
                        [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                    }else if ([returnCode intValue]==2){
                        [EPTool publicDeleteInfo];
                        [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                            [EPTool otherLogin];
                        }];
                    }else{
                        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"获取失败，请稍后重试" count:0 doWhat:nil];
                    }
                }];
            }
        }else{
            if (self.tfPhone.text.length==0||[EPTool validatePhone:self.tfPhone.text]) {
                [EPTool addAlertViewInView:self title:@"温馨提示" message:@"请输入正确的手机号" count:0 doWhat:nil];
            }else{
                NSLog(@"修改支付密码");
            }
        }
}
- (IBAction)nextBtnClick:(id)sender {
    CYLog(@"%d",self.isBool);
    if (self.tfPhone.text.length==0||self.tfCode.text.length==0) {
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"输入的手机号或者验证码不能为空" count:0 doWhat:nil];
    }else{
        //下一步
        if (self.isBool==0) {
            GetData * data=[GetData new];
            [data loginForManagementUserName:self.tfPhone.text withPassword:nil withManual:nil wihLoginTime:nil withClientId:nil withApp:@"3" withType:@"6" withValidCode:self.tfCode.text withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
                NSLog(@"%@",returnCode);
                if ([returnCode intValue]==0) {
                    //重置密码
                    EPPassXiuGaiVC * vc=[[EPPassXiuGaiVC alloc]init];
                    vc.isChuan=0;
                    vc.userName=self.tfPhone.text;
                    vc.code=self.tfCode.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if([returnCode intValue]==1){
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                }else if ([returnCode intValue]==2){
                    [EPTool publicDeleteInfo];
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                        [EPTool otherLogin];
                    }];
                }else{
                    [EPTool addAlertViewInView:self title:@"温馨提示" message:@"由于网络问题,获取验证码失败，请稍后重试" count:0 doWhat:nil];
                }
                
            }];
            }else{
            //修改支付密码
            EPResetPayPasswordVC * vc=[[EPResetPayPasswordVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}
#pragma mark----UItextField的delegate-----
//限制文本框输入的字数长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField==self.tfPhone)
    {
        NSInteger loc =range.location;
        if (loc < 11)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    if (textField==self.tfCode)
    {
        NSInteger loc =range.location;
        if (loc < 6)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return YES;
    
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
