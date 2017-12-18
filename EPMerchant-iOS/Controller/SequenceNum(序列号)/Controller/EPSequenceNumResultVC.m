//
//  EPSequenceNumResultVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/11.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPSequenceNumResultVC.h"
#import "EPSHistoryCell.h"
#import "EPResultModel.h"
@interface EPSequenceNumResultVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tb;
@property(nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,copy)NSString * vcode;

@end

@implementation EPSequenceNumResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBar:0 title:@"查询结果"];
    [self tb];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getLookData];
}
- (void)getLookData{
    [self.dataArr removeAllObjects];
    NSArray * arr=self.dataDict[@"array"];
    for (NSDictionary * dict in arr) {
        EPResultModel * model=[EPResultModel mj_objectWithKeyValues:dict];
        [self.dataArr addObject:model];
    }
    [self.tb reloadData];
}
//使用兑换码
- (void)useVcode{
    [EPTool addMBProgressWithView:self.view style:0];
    [EPTool showMBWithTitle:@""];
    GetData * data=[GetData new];
    [data getVcodesInfoWithType:@"2" withVcodes:_vcode withVcode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
       // CYLog(@"使用----%@",dict);
        [EPTool hiddenMBWithDelayTimeInterval:0];
        if ([returnCode intValue]==0) {
            //使用兑换码
            UIAlertController * alertControl=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"使用兑换码成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertControl addAction:OKAction];
            [self presentViewController:alertControl animated:YES completion:nil];
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
-(UITableView *)tb{
    if (!_tb) {
        _tb=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tb.delegate=self;
        _tb.dataSource=self;
        _tb.backgroundColor=ColorWithRGB(238, 238, 238, 1);
        _tb.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tb];
    }
    return _tb;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[[NSMutableArray alloc]init];
    }
    return _dataArr;
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
