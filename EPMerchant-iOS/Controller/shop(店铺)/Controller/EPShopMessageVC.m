//
//  EPShopMessageVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPShopMessageVC.h"
#import "EPShopMessageCell1.h"
#import "EPShopCell2.h"
#import "EPShopCell3.h"
#import "EPShopModel.h"
@interface EPShopMessageVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tb;

@property(nonatomic,strong)EPShopModel * model;

@end

@implementation EPShopMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"店铺信息"];
    [self tb];
    [self setTableViewFoot];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getShopDetailData];
}
- (void)getShopDetailData{
    GetData * data=[GetData new];
    [data getOwnShopDataWithType:@"0" withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        //CYLog(@"店铺消息--%@",dict);
        if ([returnCode intValue]==0) {
            EPShopModel * model=[EPShopModel mj_objectWithKeyValues:dict];
            _model=model;
            [self.tb reloadData];
        }else if([returnCode intValue]==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接中断，数据获取失败" count:0 doWhat:nil];
        }
    }];
    
}
- (void)setTableViewFoot{
    UIView * vc=[[UIView alloc]init];
    vc.frame=CGRectZero;
    vc.backgroundColor=[UIColor whiteColor];
    self.tb.tableFooterView=vc;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
       EPShopMessageCell1 * cell=[tableView dequeueReusableCellWithIdentifier:@"EPShopMessageCell1"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.img sd_setImageWithURL:[NSURL URLWithString:_model.shopImg]];
        return cell;
    }else if (indexPath.row==4){
        EPShopCell3 * cell=[tableView dequeueReusableCellWithIdentifier:@"EPShopCell3"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (_model) {
            if ([_model.shopRange intValue]==0) {
                cell.btn1.selected=YES;
            }else if ([_model.shopRange intValue]==1){
                cell.btn2.selected=YES;
            }else if ([_model.shopRange intValue]==2){
                cell.btn3.selected=YES;
            }else if ([_model.shopRange intValue]==3){
                cell.btn4.selected=YES;
            }
        }
        return cell;
    }else{
        EPShopCell2 * cell=[tableView dequeueReusableCellWithIdentifier:@"EPShopCell2"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.row==1) {
            cell.nameLb.text=@"店铺名称";
            cell.lbName.text=_model.shopName;
        }else if (indexPath.row==2){
            cell.nameLb.text=@"店铺地址";
            cell.lbName.text=_model.shopAddress;
            cell.lbName.adjustsFontSizeToFitWidth=YES;
        }else{
            cell.nameLb.text=@"联系方式";
            cell.lbName.text=_model.shopPhone;
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0||indexPath.row==4) {
        return 90;
    }
    else{
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (UITableView *)tb{
    if (!_tb) {
        _tb=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)style:UITableViewStylePlain];
        _tb.delegate=self;
        _tb.dataSource=self;
        _tb.backgroundColor=ColorWithRGB(234, 234, 234, 1);
        //_tb.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tb registerNib:[UINib nibWithNibName:@"EPShopMessageCell1" bundle:nil] forCellReuseIdentifier:@"EPShopMessageCell1"];
        [_tb registerNib:[UINib nibWithNibName:@"EPShopCell2" bundle:nil] forCellReuseIdentifier:@"EPShopCell2"];
        [_tb registerNib:[UINib nibWithNibName:@"EPShopCell3" bundle:nil] forCellReuseIdentifier:@"EPShopCell3"];
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
