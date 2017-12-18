//
//  EPFeedBookVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPFeedBookVC.h"

@interface EPFeedBookVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) IBOutlet UILabel *feedLb;

@end

@implementation EPFeedBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"意见反馈"];
    self.commitBtn.layer.masksToBounds=YES;
    self.commitBtn.layer.cornerRadius=5;
    self.textView.layer.masksToBounds=YES;
    self.textView.layer.cornerRadius=5;
    self.textView.delegate=self;
}
- (void)registLocalNotification{
    //注册本地通知
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 通知内容
    notification.alertBody =  @"谢谢您的反馈，我们会努力修改的";
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"谢谢您的反馈，我们会努力修改的" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
- (IBAction)commitBtnClick:(UIButton *)sender {
    //CYLog(@"内容--%@",self.textView.text);
    if ([self.textView.text isEqualToString:@" "]) {
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"您尚未填写反馈内容!!!" count:0 doWhat:nil];
    }else{
        //提交反馈
        [EPTool addMBProgressWithView:self.view style:0];
        [EPTool showMBWithTitle:@"提交中..."];
        [EPTool hiddenMBWithDelayTimeInterval:3];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
        CYLog(@"%@",timer);
    }
}
-(void)timerFired{
    [EPTool addAlertViewInView:self title:@"温馨提示" message:@"提交反馈成功" count:0 doWhat:^{
        [self registLocalNotification];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.text.length==0) {
        self.feedLb.hidden=NO;
    }else{
        self.feedLb.hidden=YES;
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
