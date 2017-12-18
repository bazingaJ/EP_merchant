//
//  EPPresentRecordVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPPresentRecordVC.h"
#import "EPPresentRecordCell.h"
#import "EPRevenueModel.h"
@interface EPPresentRecordVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tb;
@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation EPPresentRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"提现记录"];
    self.tb.dataSource=self;
    self.tb.delegate=self;
    [self setTableViewFoot];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getTIxianRecoredData];
}
//获取提现历史记录数据
- (void)getTIxianRecoredData{
    GetData * data=[GetData new];
    [data getWithdrawRecord:@"2" withMoney:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        CYLog(@"提现历史记录--->%@",dict);
        if ([returnCode intValue]==0) {
            NSArray * arr=dict[@"moneyTransferArr"];
            if (arr.count==0) {
                //暂无历史记录
                self.tb.hidden=YES;
                [self creatPlaceHoldView];
            }else{
                for (NSDictionary * dictM in arr) {
                    EPRevenueModel * model=[EPRevenueModel mj_objectWithKeyValues:dictM];
                    [self.dataArr addObject:model];
                }
                [self.tb reloadData];
            }
            
        }else if ([returnCode intValue]==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接失败，获取数据失败" count:0 doWhat:nil];
        }
    }];
}
- (void)creatPlaceHoldView{
    UILabel * lb=[[UILabel alloc]init];
    [self.view addSubview:lb];
    lb.frame=CGRectMake(0, ScreenHeight/2-10, ScreenWidth, 20);
    lb.text=@"暂无提现记录";
    lb.textAlignment=NSTextAlignmentCenter;
    lb.font=[UIFont systemFontOfSize:14];
    lb.textColor=ColorWithRGB(128, 128, 128, 1);
}
- (void)setTableViewFoot{
    UIView * vc=[[UIView alloc]init];
    vc.frame=CGRectZero;
    vc.backgroundColor=[UIColor whiteColor];
    self.tb.tableFooterView=vc;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EPPresentRecordCell * cell=[tableView dequeueReusableCellWithIdentifier:@"recordCell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"EPPresentRecordCell" owner:nil options:nil]objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    EPRevenueModel * model=[self.dataArr objectAtIndex:indexPath.row];
    cell.model=model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
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
