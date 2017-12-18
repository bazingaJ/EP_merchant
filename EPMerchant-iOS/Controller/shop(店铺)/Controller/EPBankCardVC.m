//
//  EPBankCardVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPBankCardVC.h"
#import "EPCardMessageVC.h"
@interface EPBankCardVC ()

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@end

@implementation EPBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"填写卡号"];
    self.view.backgroundColor=ColorWithRGB(233, 234, 235, 1);
    self.nextBtn.layer.masksToBounds=YES;
    self.nextBtn.layer.cornerRadius=5;
}
- (IBAction)nextStep:(id)sender {
    //填写卡信息
    EPCardMessageVC * VC=[[EPCardMessageVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
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
