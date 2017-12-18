//
//  EPPhoneChangeVC.m
//  EPin-IOS
//
//  Created by jeaderL on 16/6/30.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import "EPPhoneChangeVC.h"
#import "EPPassXiuGaiVC.h"
@interface EPPhoneChangeVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passTf;

@property (weak, nonatomic) IBOutlet UILabel *errorLb;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@end

@implementation EPPhoneChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:2 title:@"修改登录密码"];
    [self addLeftItemWithFrame:CGRectZero textOrImage:0 action:@selector(backClickAction) name:@"返回"];
    self.passTf.delegate=self;
    self.passTf.layer.masksToBounds=YES;
    self.passTf.layer.cornerRadius=5;
    self.nextBtn.layer.masksToBounds=YES;
    self.nextBtn.layer.cornerRadius=5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backClickAction) name:@"passXG" object:nil];
}
- (void)backClickAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextBtnClick:(UIButton *)sender {
    //点击下一步
    if (self.passTf.text.length==0) {
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"输入旧密码不能为空" count:0 doWhat:nil];
    }else{
        GetData * data=[GetData new];
        NSString * pass=[EPRSA encryptString:self.passTf.text publicKey:publicKeyRSA];
        [data loginForManagementUserName:USERNAME withPassword:pass withManual:nil wihLoginTime:LOGINTIME withClientId:nil withApp:@"3" withType:@"5" withValidCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
            if ([returnCode intValue]==0) {
                EPPassXiuGaiVC * vc=[[EPPassXiuGaiVC alloc]init];
                vc.isChuan=1;
                vc.pass=self.passTf.text;
                [self.navigationController pushViewController:vc animated:YES];
            }else if ([returnCode intValue]==1){
                [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
                self.errorLb.text=@"密码错误";
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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.passTf becomeFirstResponder];
    [EPTool getPublicKey];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.errorLb.text=@"";
}
#pragma mark----UItextField的delegate-----
//限制文本框输入的字数长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField==self.passTf)
    {
        NSInteger loc =range.location;
        if (loc < 10)
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
