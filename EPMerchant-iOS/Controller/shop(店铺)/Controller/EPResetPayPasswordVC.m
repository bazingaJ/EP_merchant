//
//  EPResetPayPasswordVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPResetPayPasswordVC.h"

@interface EPResetPayPasswordVC ()

@end

@implementation EPResetPayPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"修改支付密码"];
    self.tfNewPayPass.layer.masksToBounds=YES;
    self.tfNewPayPass.layer.cornerRadius=5;
    self.tfAgainPayPass.layer.masksToBounds=YES;
    self.tfAgainPayPass.layer.cornerRadius=5;
    self.submitBtn.layer.masksToBounds=YES;
    self.submitBtn.layer.cornerRadius=5;
    
}
- (IBAction)submitClckBtn:(UIButton *)sender {
    //提交支付密码
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
