//
//  EPSquenceLoohStyleVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/17.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPSquenceLoohStyleVC.h"
#import "EPSHistoryViewController.h"
#import "EPSequenceNumVC.h"
#import "SYQrCodeScanne.h"
#import "EPScanResultVC.h"
@interface EPSquenceLoohStyleVC ()

@end

@implementation EPSquenceLoohStyleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBar:2 title:@"序列号"];
    [self addRightBtnWithFrame:CGRectMake(14, 10, 50, 30) action:@selector(clickRightBarButtonItem) name:@"历史记录"];
    [self creatUI];
}
- (void)creatUI{
    UILabel * lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(0, 117+64, ScreenWidth, 15);
    lb.text=@"请选择查询方式";
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=ColorWithRGB(128, 128, 128, 1);
    lb.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:lb];
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake((ScreenWidth-210)/2, CGRectGetMaxY(lb.frame)+24, 210, 50);
    [btn setTitle:@"扫码查询" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    btn.backgroundColor=ColorWithRGB(0, 162, 255, 1);
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=25;
    [btn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake((ScreenWidth-210)/2, CGRectGetMaxY(btn.frame)+20,210, 50);
    [btn2 setTitle:@"手动输入" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.titleLabel.font=[UIFont systemFontOfSize:18];
    btn2.backgroundColor=ColorWithRGB(0, 162, 255, 1);
    btn2.layer.masksToBounds=YES;
    btn2.layer.cornerRadius=25;
    [btn2 addTarget:self action:@selector(addBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}
// 点击NavigationBar右边按钮
-(void)clickRightBarButtonItem
{
    EPSHistoryViewController *shVc = [[EPSHistoryViewController alloc] init];
    [self.navigationController pushViewController:shVc animated:YES];
}
- (void)addBtnClick:(UIButton *)btn{
    //扫码查询
    SYQrCodeScanne *VC = [[SYQrCodeScanne alloc]init];
    VC.scanneScusseBlock = ^(SYCodeType codeType, NSString *url){
    
        if (SYCodeTypeUnknow == codeType) {
            NSLog(@"二维码无法识别");
        }else if (SYCodeTypeLink == codeType) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        }else{
            EPScanResultVC * vc =[[EPScanResultVC alloc] initWithResultStr:url];
            [self.navigationController pushViewController:vc animated:YES];        }
    };
    [VC scanning];
}
- (void)addBtnClick1:(UIButton *)btn{
    //手动输入
    EPSequenceNumVC * vc=[[EPSequenceNumVC alloc]init];
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
