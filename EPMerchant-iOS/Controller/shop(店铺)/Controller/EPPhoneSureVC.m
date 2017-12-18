//
//  EPPhoneSureVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPPhoneSureVC.h"

@interface EPPhoneSureVC ()

@property (weak, nonatomic) IBOutlet UITextField *textCode;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBtN;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end

@implementation EPPhoneSureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"手机验证"];
    self.textCode.layer.masksToBounds=YES;
    self.textCode.layer.borderColor=[ColorWithRGB(128, 128, 128, 1) CGColor];
    self.textCode.layer.borderWidth=1;
    self.textCode.layer.cornerRadius=5;
    self.getCodeBtN.layer.masksToBounds=YES;
    self.getCodeBtN.layer.cornerRadius=5;
    self.finishBtn.layer.masksToBounds=YES;
    self.finishBtn.layer.cornerRadius=5;
}
- (IBAction)getCodeClick:(UIButton *)sender {
}
- (IBAction)finishBtnClick:(UIButton *)sender {
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
