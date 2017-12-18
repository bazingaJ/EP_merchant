//
//  EPPresentMoneyVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPPresentMoneyVC.h"

@interface EPPresentMoneyVC ()

@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIButton *clickTiXianBtn;

@property (weak, nonatomic) IBOutlet UIButton *allMoneyBtn;

@end

@implementation EPPresentMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"提 现"];
    self.tf.layer.masksToBounds=YES;
    self.tf.layer.cornerRadius=5;
    self.clickTiXianBtn.layer.masksToBounds=YES;
    self.clickTiXianBtn.layer.cornerRadius=5;
    if (self.moneyCount==0) {
        self.allMoneyBtn.hidden=YES;
    }
    CYLog(@"银行卡号--%@",self.accountNumber);
    CYLog(@"开户行----%@",self.depositBank);
    NSString * str=[self.accountNumber substringFromIndex:self.accountNumber.length-4];
    self.cardLb.text=[NSString stringWithFormat:@"银行卡 %@ (%@)",self.depositBank,str];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (IBAction)clickAllMoneyPresent:(id)sender
{
    self.tf.text=[NSString stringWithFormat:@"%.2f",self.moneyCount];
}
- (IBAction)clickTiXian:(id)sender
{
    if ([self.tf.text isEqualToString:@""])
    {
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"请输入金额" count:0 doWhat:nil];
    }
    else
    {
        float inputMoney=[self.tf.text floatValue];
        if (inputMoney==0)
        {
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"金额不能为零" count:0 doWhat:nil];
        }
        else
        {
            if (inputMoney>self.moneyCount)
            {
                [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您的账户余额不足，请重新输入" count:0 doWhat:nil];
            }
            else
            {
                //提现
                [self getWithDrawMoney:inputMoney];
            }
        }
    }
}
- (void)getWithDrawMoney:(NSInteger)count{
    NSString * money=[NSString stringWithFormat:@"%ld",(long)count];
    GetData * data=[GetData new];
    [data getWithdrawRecord:@"1" withMoney:money withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        CYLog(@"提现----->%@",dict);
        if ([returnCode intValue]==0)
        {
            self.tf.text = @"0.00";
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"申请提现成功,资金将在2-3个工作日到账，请耐心等待......" count:0 doWhat:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else if ([returnCode intValue]==1)
        {
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }
        else if ([returnCode intValue]==2)
        {
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }
        else
        {
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"由于网络问题，申请提现失败，请稍后重试" count:0 doWhat:nil];
        }
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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
