//
//  EPGoodsDownViewController.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//  商品下架界面（目前已废弃）

#import "EPGoodsDownViewController.h"
#import "EPGoodsVC.h"
@interface EPGoodsDownViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property(nonatomic,copy)NSString * reason;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextField *tfContent;


@end

@implementation EPGoodsDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"商品下架"];
    self.commitBtn.layer.masksToBounds=YES;
    self.commitBtn.layer.cornerRadius=5;
    
    self.nameLb.text=self.goodName;
    self.reason=@"商品缺货";
}
- (IBAction)btn1Click:(id)sender {
    UIButton * btn=(UIButton *)sender;
    btn.selected=NO;
    self.btn2.selected=NO;
    self.btn3.selected=NO;
    self.reason=@"商品缺货";
}

- (IBAction)btn2Click:(id)sender {
    UIButton * btn=(UIButton *)sender;
    btn.selected=YES;
    self.btn1.selected=YES;
    self.btn3.selected=NO;
    self.reason=@"活动过期";
}
- (IBAction)btn3Click:(id)sender {
    UIButton * btn=(UIButton *)sender;
    btn.selected=YES;
    self.btn1.selected=YES;
    self.btn2.selected=NO;
    self.reason=@"其他原因";
}
- (IBAction)commitBtnClick:(id)sender {
    NSString * str =[NSString stringWithFormat:@"%@/getAllGoodsData.json",EPUrl];
    if ([self.reason isEqualToString:@"其他原因"]) {
        if (self.tfContent.text.length==0) {
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"请填写原因" count:0 doWhat:nil];
        }else{
            self.reason=self.tfContent.text;
        }
    }
    NSDictionary * dict=@{@"userName":USERNAME,
                          @"loginTime":LOGINTIME,
                          @"goodsId":self.goodsId,
                          @"type":@"5",
                          @"shelfDescribe":self.reason};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode=responseObject[@"returnCode"];
        NSString * msg=responseObject[@"msg"];
        if ([returnCode intValue]==0) {
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"商品下架成功" count:0 doWhat:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if ([returnCode intValue]==1){
             [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"由于网络问题，提交信息失败，请稍后重试" count:0 doWhat:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
