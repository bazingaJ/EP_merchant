//
//  EPAddBankCardVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPAddBankCardVC.h"
#import "EPBankCarCell.h"
#import "EPBankCardVC.h"
@interface EPAddBankCardVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tb;

@end

@implementation EPAddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"银行卡"];
    [self tb];
}
- (IBAction)addBtnClick:(id)sender
{
    //添加银行卡
    EPBankCardVC * vc=[[EPBankCardVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EPBankCarCell * cell=[tableView dequeueReusableCellWithIdentifier:@"EPBankCarCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        cell.cardImg.image=[UIImage imageNamed:@"Bank_of_Communications"];
    }else{
        cell.cardImg.image=[UIImage imageNamed:@"pingan_bank"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableView *)tb{
    if (!_tb) {
        _tb=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-49-80) style:UITableViewStylePlain];
        _tb.delegate=self;
        _tb.dataSource=self;
        _tb.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tb registerNib:[UINib nibWithNibName:@"EPBankCarCell" bundle:nil] forCellReuseIdentifier:@"EPBankCarCell"];
        [self.view addSubview:_tb];
    }
    return _tb;
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
