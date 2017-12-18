//
//  EPShopCountVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPShopCountVC.h"
#import "EPPresentRecordVC.h"
#import "EPPresentMoneyVC.h"
@interface EPShopCountVC ()

@property (weak, nonatomic) IBOutlet UIButton *txBtn;


@end

@implementation EPShopCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"店铺账户"];
    [self addRightBtnWithFrame:CGRectMake(14, 10, 50, 30) action:@selector(tiMoney) name:@"提现记录"];
    self.txBtn.layer.masksToBounds=YES;
    self.txBtn.layer.cornerRadius=5;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [self getCountData];
}
//- (void)getCountData{
//    GetData * data=[GetData new];
//    [data getOwnShopDataWithType:@"1" withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg){
//         CYLog(@"%@",dict);
//         self.moneyCount.text=[dict[@"totalMoney"] stringValue];
//         if ([dict[@"totalMoney"] intValue]==0) {
//             self.moneyCount.text=[dict[@"totalMoney"] stringValue];
//         }else{
//             NSString * str=[NSString stringWithFormat:@"¥%@",[dict[@"totalMoney"] stringValue]];
//             [self.moneyCount setAttributedText:[self changeLabelWithText:str]];
//         }
//         self.timeLb.text=[NSString stringWithFormat:@"上次提现: %@",dict[@"lastWithdrawDate"]];
//    }];
//}
-(NSMutableAttributedString*) changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont systemFontOfSize:18];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:65] range:NSMakeRange(1,needText.length-1)];
    
    return attrString;
}
- (void)getCardMessage{
    //银行卡号和开户行
    GetData * data=[GetData new];
    [data getWithdrawRecord:@"0" withMoney:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
       // CYLog(@"获取银行卡号----%@",dict);
        if ([returnCode intValue]==0) {
            EPPresentMoneyVC * vc=[[EPPresentMoneyVC alloc]init];
            vc.moneyCount=[self.moneyCount.text floatValue];
            vc.accountNumber=dict[@"accountNumber"];
            vc.depositBank=dict[@"depositBank"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([returnCode intValue]==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您的商铺没有提供银行卡信息，不能进行提现" count:0 doWhat:^{
                
            }];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"由于网络问题，获取银行卡信息失败，请稍后重试" count:0 doWhat:nil];
        }
    }];
}
- (IBAction)tixianClick:(id)sender
{
    //去提现判断是否绑定过银行卡,如果没有绑定,无法提现
    [self getCardMessage];
}
//提现历史记录
- (void)tiMoney{
    EPPresentRecordVC * vc=[[EPPresentRecordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
