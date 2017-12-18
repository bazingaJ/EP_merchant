//
//  EPScanResultVC.m
//  EPin-IOS
//  扫码结果
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import "EPScanResultVC.h"
#import "EPSHistoryCell.h"
#import "EPResultModel.h"
@interface EPScanResultVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString * getStr;

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property(nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,copy)NSString * vcode;

@end

@implementation EPScanResultVC

- (instancetype)initWithResultStr:(NSString *)string
{
    if (self=[super init])
    {
        self.getStr=string;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationBar:0 title:@"扫描结果"];
    [self prepareForData];
    self.tb.delegate=self;
    self.tb.dataSource=self;
}
- (void)prepareForData
{
    //获取扫描结果
    GetData * data=[GetData new];
    [data getVcodesInfoWithType:@"1" withVcodes:nil withVcode:self.getStr withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
         CYLog(@"扫描结果---%@",dict);
        if ([returnCode intValue]==0) {
            NSArray * arr=dict[@"array"];
            for (NSDictionary * dict in arr) {
                EPResultModel * model=[EPResultModel mj_objectWithKeyValues:dict];
                [self.dataArr addObject:model];
            }
            [self.tb reloadData];
        }
    }];
}
- (void)useVcode{
    //使用兑换码
    CYLog(@"_vcode==%@",_vcode);
    GetData * data=[GetData new];
    [data getVcodesInfoWithType:@"2" withVcodes:_vcode withVcode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        CYLog(@"使用----%@",dict);
        if ([returnCode intValue]==0) {
            //使用兑换码
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"验证兑换码成功,请到历史记录中查看" count:0 doWhat:^{
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
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"由于网络问题，查询失败，请稍后重试" count:0 doWhat:nil];
        }
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EPResultModel * model=[self.dataArr objectAtIndex:indexPath.section];
    EPSHistoryCell * cell = [[NSBundle mainBundle] loadNibNamed:@"EPSHistoryCell" owner:nil options:nil][0];
    cell.selectionStyle = 0;
    cell.squenLb.text=model.vcode;
    NSString * time=[model.buyTime substringToIndex:16];
    cell.timeLb.text=time;
    [cell.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.goodsImg]];
    cell.goodsName.text=model.goodsName;
    cell.priceLb.text=[NSString stringWithFormat:@"¥ %@",model.goodsPrice];
    switch ([model.state intValue]) {
        case 0:
        {
            [cell.btn setTitle:@"使 用" forState:UIControlStateNormal];
            cell.btn.backgroundColor=ColorWithRGB(0, 162, 255, 1);
            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _vcode=model.vcode;
            [cell.btn addTarget:self action:@selector(useVcode) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
            [cell.btn setTitle:@"已使用" forState:UIControlStateNormal];
            [cell.btn setTitleColor:ColorWithRGB(127, 127, 127, 1) forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [cell.btn setTitle:@"退款中" forState:UIControlStateNormal];
            [cell.btn setTitleColor:ColorWithRGB(127, 127, 127, 1) forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [cell.btn setTitle:@"已退款" forState:UIControlStateNormal];
            [cell.btn setTitleColor:ColorWithRGB(127, 127, 127, 1) forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [cell.btn setTitle:@"退款中" forState:UIControlStateNormal];
            [cell.btn setTitleColor:ColorWithRGB(127, 127, 127, 1) forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [cell.btn setTitle:@"已过期" forState:UIControlStateNormal];
            [cell.btn setTitleColor:ColorWithRGB(127, 127, 127, 1) forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
