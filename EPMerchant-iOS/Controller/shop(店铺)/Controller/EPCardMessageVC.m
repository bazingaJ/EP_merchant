//
//  EPCardMessageVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPCardMessageVC.h"
#import "EPPhoneSureVC.h"
@interface EPCardMessageVC ()

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@end

@implementation EPCardMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"填写卡信息"];
    self.nextBtn.layer.masksToBounds=YES;
    self.nextBtn.layer.cornerRadius=5;
}
- (IBAction)selectBtn:(id)sender
{
    UIButton * btn=(UIButton *)sender;
    btn.selected=!btn.selected;
}

- (IBAction)nextBtn:(id)sender
{
    //手机验证
    EPPhoneSureVC * vc=[[EPPhoneSureVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
