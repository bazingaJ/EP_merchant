//
//  EPShopRevenueVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPShopRevenueVC.h"
#import "EPRevenueCell.h"
#import "EPRevenueCell2.h"
#import "EPDetailLookVC.h"
#import "YTDatePick.h"
#import "EPRevenueModel.h"
@interface EPShopRevenueVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property(nonatomic,strong)UITextField * startTf;
@property(nonatomic,strong)UITextField * endTf;
@property (nonatomic, copy) UIView *bgView;
@property (nonatomic, copy) NSString *deliver_timesString;
@property(nonatomic,copy)NSString * endString;
@property(nonatomic,strong)EPRevenueModel * model;


@end

@implementation EPShopRevenueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self addNavigationBar:0 title:@"店铺营收"];
    [self addNavigationBar:2 title:@"店铺营收"];
    [self addLeftItemWithFrame:CGRectZero textOrImage:0 action:@selector(dismiss) name:@"返回"];
    self.tb.delegate=self;
    self.tb.dataSource=self;
}
- (void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"day"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zhou"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"month"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dayLook) name:@"day" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhouLook) name:@"zhou" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monthLook) name:@"month" object:nil];
    [self createCancleNotifation];
    [self createNotifation];
    if (DAY==nil&&ZHOU==nil&&MONTH==nil) {
        [self dayLook];
    }
    if ([DAY intValue]==1) {
        [self dayLook];
    }
    if ([ZHOU intValue]==1) {
        [self zhouLook];
    }
    if ([MONTH intValue]==1) {
        [self monthLook];
    }
}
- (void)detailAllLook{
    GetData * data=[GetData new];
    [data getRevenueInfoWithType:@"0" withDataModel:nil withStartDate:nil withEndDate:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        CYLog(@"明细所有查询--%@",dict);
        if ([returnCode intValue]==0) {
            EPDetailLookVC * vc=[[EPDetailLookVC alloc]init];
            vc.dataDict=dict;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([returnCode intValue]==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接中断，请稍后重试" count:0 doWhat:nil];
        }
    }];
}
- (void)dayLook{
    GetData * data=[GetData new];
    [data getRevenueInfoWithType:@"1" withDataModel:@"0" withStartDate:nil withEndDate:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        //CYLog(@"日查询----%@",dict);
        if ([returnCode intValue]==0) {
            //查询成功
            EPRevenueModel * model=[EPRevenueModel mj_objectWithKeyValues:dict];
             _model=model;
            [self.tb reloadData];
        }else if ([returnCode intValue]==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接中断，请稍后重试" count:0 doWhat:nil];
        }
    }];
}
- (void)zhouLook{
    GetData * data=[GetData new];
    [data getRevenueInfoWithType:@"1" withDataModel:@"1" withStartDate:nil withEndDate:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        //CYLog(@"周查询----%@",dict);
        if ([returnCode intValue]==0) {
            //查询成功
            EPRevenueModel * model=[EPRevenueModel mj_objectWithKeyValues:dict];
            _model=model;
            [self.tb reloadData];
        }else if ([returnCode intValue]==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接中断，请稍后重试" count:0 doWhat:nil];
        }
    }];
}
- (void)monthLook{
    GetData * data=[GetData new];
    [data getRevenueInfoWithType:@"1" withDataModel:@"2" withStartDate:nil withEndDate:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        //CYLog(@"月查询----%@",dict);
        if ([returnCode intValue]==0) {
            //查询成功
            EPRevenueModel * model=[EPRevenueModel mj_objectWithKeyValues:dict];
            _model=model;
            [self.tb reloadData];
        }else if ([returnCode intValue]==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接中断，请稍后重试" count:0 doWhat:nil];
        }
    }];
}
- (void)orderDetailClick{
    if (_startTf.text.length==0||_endTf.text.length==0) {
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"请输入完整的日期" count:0 doWhat:nil];
    }else{
        GetData * data=[GetData new];
        [data getRevenueInfoWithType:@"2" withDataModel:nil withStartDate:self.deliver_timesString withEndDate:self.endString  withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
            //CYLog(@"明细查询----%@",dict);
            if ([returnCode intValue]==0) {
                //明细查询
                EPDetailLookVC * vc=[[EPDetailLookVC alloc]init];
                vc.dataDict=dict;
                [self.navigationController pushViewController:vc animated:YES];
            }else if ([returnCode intValue]==1){
                [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
            }else if ([returnCode intValue]==2){
                [EPTool publicDeleteInfo];
                [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                    [EPTool otherLogin];
                }];
            }else{
                [EPTool addAlertViewInView:self title:@"温馨提示" message:@"网络连接失败，请稍后重试" count:0 doWhat:nil];
            }
        }];
    }
}
-(NSMutableAttributedString*) changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont systemFontOfSize:18];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36] range:NSMakeRange(1,needText.length-1)];
    
    return attrString;
}
-(NSMutableAttributedString*) changeLabelWithText2:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont systemFontOfSize:36];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,needText.length-1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(needText.length-1,1)];
    
    return attrString;
}
#pragma------tableView的delegate-----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        EPRevenueCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"EPRevenueCell2" owner:nil options:nil]objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
            cell.timeLb.text=currentDateStr;
        }
        if (_model) {
            NSString * str1=[NSString stringWithFormat:@"¥%@",_model.totalMoney];
            [cell.incomeLb setAttributedText:[self changeLabelWithText:str1]];
            cell.incomeLb.adjustsFontSizeToFitWidth=YES;
            NSString * str2=[NSString stringWithFormat:@"%@单",_model.totalOrderNum];
            [cell.totolOrder setAttributedText:[self changeLabelWithText2:str2]];
            cell.totolOrder.adjustsFontSizeToFitWidth=YES;
        }
        [cell.detailBtn addTarget:self action:@selector(detailAllLook) forControlEvents:UIControlEventTouchUpInside];
       return cell;

    }else{
        EPRevenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if(!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"EPRevenueCell" owner:nil options:nil]objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell.detailBtn addTarget:self action:@selector(orderDetailClick) forControlEvents:UIControlEventTouchUpInside];
            _startTf=cell.startTf;
            cell.startTf.delegate=self;
            _endTf=cell.endTf;
            cell.endTf.delegate=self;
        }
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * vc=[[UIView alloc]init];
    vc.backgroundColor=ColorWithRGB( 234, 234, 234, 1);
    vc.frame=CGRectMake(0, 0, ScreenWidth, 30);
    UILabel * lb=[[UILabel alloc]init];
    lb.x=12;
    lb.y=0;
    lb.width=120;
    lb.height=30;
    lb.textColor=ColorWithRGB(102, 102, 102, 1);
    lb.font=[UIFont systemFontOfSize:12];
    if (section==0) {
        lb.text=@"营收统计";
    }else{
        lb.text=@"账目查询";
    }
    [vc addSubview:lb];
    return vc;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 196;
    }else{
        return 171;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==_startTf) {
        [self.view endEditing:YES];
        
        [self createBackgroundView];
        
        [YTDatePick showPickWithMakeSure:^(id year, id month, id day) {
            _startTf.text=[NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            self.deliver_timesString = [NSString stringWithFormat:@"%@%@%@",year,month,day];
            NSLog(@"deliver_timesString = %@",self.deliver_timesString);
         }];
    }
    if (textField==_endTf) {
        [self.view endEditing:YES];
        [self createBackgroundView];
        
        [YTDatePick showPickWithMakeSure:^(id year, id month, id day) {
            _endTf.text=[NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            self.endString = [NSString stringWithFormat:@"%@%@%@",year,month,day];
            
        }];

    }
    return NO;
}
-(void)createBackgroundView{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.3;
    _bgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgView];
}
-(void)createCancleNotifation{
    if([self respondsToSelector:@selector(setCancleValueChanges)]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCancleValueChanges) name:@"setCancleValueChanges" object:nil];
    }
}


-(void)createNotifation{
    if([self respondsToSelector:@selector(setCancleValueChanges)]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCancleValueChanges) name:@"setInfor" object:nil];
    }
}
-(void)setCancleValueChanges {
    [_bgView removeFromSuperview];
    //NSLog(@"取消了。。。");
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
