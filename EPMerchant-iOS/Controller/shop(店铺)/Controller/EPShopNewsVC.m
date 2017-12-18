//
//  EPShopNewsVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPShopNewsVC.h"
#import "EPShopNewsCell.h"
#import "JDPushDataTool.h"
#import "JDPushData.h"
#import "EPNewsDetailVC.h"
@interface EPShopNewsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property(nonatomic,strong)NSArray * imgArr;
@property(nonatomic,strong)NSMutableArray * orderArr;
@property(nonatomic,strong)NSMutableArray * exitOrder;
@property(nonatomic,strong)UILabel * countLb1;
@property(nonatomic,strong)UILabel * countLb2;


@end

@implementation EPShopNewsVC
{
    int _tag1;
    int _tag2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"店铺消息"];
    [self.tb registerNib:[UINib nibWithNibName:@"EPShopNewsCell" bundle:nil] forCellReuseIdentifier:@"EPShopNewsCell"];
    self.tb.delegate=self;
    self.tb.dataSource=self;
    self.imgArr=@[@"New_Order_Single",@"chargeback_news"];
    _tag1=0;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDetailData];
}
- (void)getDetailData{
    [self.exitOrder removeAllObjects];
    [self.orderArr removeAllObjects];
    // NSLog(@"查询数据---%@",[[JDPushDataTool new] query]);
    for (NSDictionary *dict in [[JDPushDataTool new] query]) {
        JDPushData *data = [JDPushData pushDataWithDictionary:dict];
        if ([dict[@"content"] isEqualToString:@"您的店铺有一条新的退款申请！"]) {
            [self.exitOrder addObject:data];
        }
        if ([dict[@"content"] isEqualToString:@"您的店铺有一条新的订单！"]) {
            [self.orderArr addObject:data];
        }
    }
    [self.tb reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EPShopNewsCell * cell=[tableView dequeueReusableCellWithIdentifier:@"EPShopNewsCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.img.image=[UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.numLb.layer.masksToBounds=YES;
    cell.numLb.layer.cornerRadius=10;
    // NSArray * arr=@[@"订单消息",@"退单消息",@"提现消息",@"系统消息"];
    NSArray * arr=@[@"订单消息",@"退单消息"];
    if (indexPath.row==0) {
        if (self.orderArr.count==0) {
            cell.contentLb.text=@"暂无消息";
            cell.numLb.hidden=YES;
        }else{
            JDPushData *data = self.orderArr[0];
            cell.contentLb.text=data.content;
            if ([count1 intValue]==1) {
                cell.numLb.hidden=YES;
            }else{
                cell.numLb.text=ORDERNUM;
            }
        }
    }
    if (indexPath.row==1) {
        if (self.exitOrder.count==0) {
            cell.contentLb.text=@"暂无消息";
            cell.numLb.hidden=YES;
        }else{
            JDPushData *data = self.exitOrder[0];
            cell.contentLb.text=data.content;
            if ([count2 intValue]==2) {
                cell.numLb.hidden=YES;
            }else{
                cell.numLb.text=EXITNUM;
            }
        }
    }
    cell.titleLb.text=arr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EPShopNewsCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    EPNewsDetailVC * VC=[[EPNewsDetailVC alloc]init];
    if (indexPath.row==0) {
        VC.dataArr=self.orderArr;
        _tag1=1;
    }else{
        VC.dataArr=self.exitOrder;
        _tag2=1;
    }
    VC.news=cell.titleLb.text;
    [self.navigationController pushViewController:VC animated:YES];
}
-(NSMutableArray *)orderArr
{
    if (!_orderArr) {
        _orderArr = [NSMutableArray array];
    }
    return _orderArr;
}
-(NSMutableArray *)exitOrder
{
    if (!_exitOrder) {
        _exitOrder = [NSMutableArray array];
    }
    return _exitOrder;
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
