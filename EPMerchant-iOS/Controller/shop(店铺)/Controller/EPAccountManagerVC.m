//
//  EPAccountManagerVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPAccountManagerVC.h"
#import "EPPhoneChangeVC.h"
#import "EPPayPhoneSureVC.h"
@interface EPAccountManagerVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb;


@end

@implementation EPAccountManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"账户管理"];
    self.tb.delegate=self;
    self.tb.dataSource=self;
}
#pragma mark------delegate-------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 2;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str=@"cell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UILabel * lb=[[UILabel alloc]init];
        lb.frame=CGRectMake(12, 0, 200, 50);
        lb.font=[UIFont systemFontOfSize:16];
//        if (indexPath.row==0) {
            lb.text=@"修改登录密码";
            UIView * line=[[UIView alloc]init];
            line.frame=CGRectMake(12, 49, ScreenWidth-24, 1);
            line.backgroundColor=ColorWithRGB(217, 217, 217, 1);
            [cell.contentView addSubview:line];
//        }else{
//            lb.text=@"修改支付密码";
//        }
        [cell.contentView addSubview:lb];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==0) {
        //修改登录密码
        EPPhoneChangeVC * vc=[[EPPhoneChangeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        //修改支付密码
//        EPPayPhoneSureVC * vc=[[EPPayPhoneSureVC alloc]init];
//        vc.isBool=1;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
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
