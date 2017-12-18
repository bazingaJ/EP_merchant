//
//  EPDetailLookVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPDetailLookVC.h"
#import "EPDetailLookCell1.h"
#import "EPDetailLookCell2.h"
#import "EPRevenueModel.h"
@interface EPDetailLookVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property(nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,copy)NSString * totolMoney;
@property(nonatomic,copy)NSString * totolNumOrder;

@end

@implementation EPDetailLookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"明细查询"];
    self.tb.delegate=self;
    self.tb.dataSource=self;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.dataArr removeAllObjects];
    [super viewWillAppear:animated];
    NSArray * goodsArr=self.dataDict[@"goodsArr"];
    for (NSDictionary * dict in goodsArr) {
        EPRevenueModel * model=[EPRevenueModel mj_objectWithKeyValues:dict];
        [self.dataArr addObject:model];
    }
        self.totolMoney=[self.dataDict[@"totalMoney"] stringValue];
        self.totolNumOrder=[self.dataDict[@"totalOrderNum"] stringValue];
    [self.tb reloadData];
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
-(NSMutableAttributedString*) changeLabelWithText3:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIColor *color = ColorWithRGB(254, 0, 0, 1);
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(2, 1)];
    
    return attrString;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArr.count==0) {
        return 1;
    }else{
        return 3;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 1;
    }else{
        return self.dataArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     EPDetailLookCell1 * cell=[tableView dequeueReusableCellWithIdentifier:@"lookCell1"];
    if (indexPath.section==0) {
        EPDetailLookCell2 * cell=[tableView dequeueReusableCellWithIdentifier:@"lookCell2"];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"EPDetailLookCell2" owner:nil options:nil]objectAtIndex:0];
            NSString * str1=[NSString stringWithFormat:@"¥%@",self.totolMoney];
            [cell.totolMoney setAttributedText:[self changeLabelWithText:str1]];
            cell.totolMoney.adjustsFontSizeToFitWidth=YES;
            NSString * str2=[NSString stringWithFormat:@"%@单",self.totolNumOrder];
            [cell.totolOrderNum setAttributedText:[self changeLabelWithText2:str2]];
            cell.totolOrderNum.adjustsFontSizeToFitWidth=YES;
            NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
            cell.timeLb.text=currentDateStr;
        }
        return cell;
    }else if (indexPath.section==1) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"EPDetailLookCell1" owner:nil options:nil]objectAtIndex:0];
                cell.shopName.text=@"商品名称";
                cell.status.text=@"状态";
                cell.price.text=@"收支";
                cell.price.textColor=[UIColor blackColor];
                cell.time1.text=@"下(退)单时间";
                [cell.time1 setAttributedText:[self changeLabelWithText3:cell.time1.text]];
                cell.time2.text=@"使用时间";
                return cell;
            
        }else{
            cell=[[[NSBundle mainBundle] loadNibNamed:@"EPDetailLookCell1" owner:nil options:nil]objectAtIndex:0];
            EPRevenueModel * model=[self.dataArr objectAtIndex:indexPath.row];
            cell.shopName.text=model.goodsName;
            cell.price.text=[NSString stringWithFormat:@"¥ %@",model.balance];
            NSString * time1=[model.orderDate  substringToIndex:16];
            cell.time1.text=time1;
            cell.time2.text=[model.useDate substringToIndex:16];
            return cell;
        }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * vc=[[UIView alloc]init];
    vc.frame=CGRectMake(0, 0, ScreenWidth, 30);
    UILabel * lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(12, 0, 100, 30);
    lb.font=[UIFont systemFontOfSize:12];
    lb.textColor=ColorWithRGB(76,76, 76, 1);
    if (section==0) {
        lb.text=@"账目总览";
    }else if(section==1){
        lb.text=@"账目明细";
    }
    [vc addSubview:lb];
    return vc;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0||section==1) {
        return 30;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){
        return 150;
    }else if(indexPath.section==1){
        return 20;
    }else{
        return 40;
    }

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
