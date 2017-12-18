//
//  EPChargeBackVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPChargeBackVC.h"
#import "EPExitOrderModel.h"
@interface EPChargeBackVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tb;
//等待审核
@property(nonatomic,strong)NSMutableArray * dataArr1;
//已退单
@property(nonatomic,strong)NSMutableArray * dataArr2;
/**已确认*/
@property(nonatomic,strong)NSMutableArray * dataArr3;
/**提示*/
@property(nonatomic,strong)UILabel * lb;
@property(nonatomic,assign)CGFloat cellHeight;
@end

@implementation EPChargeBackVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"退单管理"];
    [self tb];
    [self tanchuView];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat sectionHeaderHeight = 33;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }
//    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}
- (void)tanchuView{
    UILabel * favorLb=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-150)/2, ScreenHeight/2,150,30)];
    favorLb.backgroundColor=[UIColor whiteColor];
    favorLb.text=@"确认退单成功";
    favorLb.font=[UIFont systemFontOfSize:14];
    favorLb.textAlignment=NSTextAlignmentCenter;
    favorLb.alpha=0.0;
    favorLb.hidden=YES;
    favorLb.layer.borderColor=[[UIColor grayColor] CGColor];
    favorLb.layer.borderWidth=1;
    favorLb.layer.cornerRadius=5;
    _lb=favorLb;
    [self.view addSubview:favorLb];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getExitOrderData];;
}
- (void)getExitOrderData{
    [self.dataArr1 removeAllObjects];
    [self.dataArr2 removeAllObjects];
    [self.dataArr3 removeAllObjects];
    GetData * data=[GetData new];
    [data getOrderDetailsWithType:@"4" withCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        CYLog(@"退单列表---%@",dict);
        if ([returnCode intValue]==0) {
            NSArray * goodsArr=dict[@"goodsArr"];
            if (goodsArr.count==0) {
                self.tb.hidden=YES;
                [self wuOrderView];
            }else{
                for (NSDictionary * dic in goodsArr) {
                    EPExitOrderModel * model=[EPExitOrderModel mj_objectWithKeyValues:dic];
                    if ([model.orderState intValue]==2) {
                        //申请退款
                        [self.dataArr1 addObject:model];
                    }else if ([model.orderState intValue]==4){
                        //已确认
                        [self.dataArr2 addObject:model];
                    }else if ([model.orderState intValue]==3){
                        //已退单
                        [self.dataArr3 addObject:model];
                    }
                }
                [self.tb reloadData];
            }
        }
    }];
}
- (void)wuOrderView{
    //无退单管理
    self.view.backgroundColor=ColorWithRGB(234, 234, 234, 1);
    CGSize s=[[UIImage imageNamed:@"img_wtdgl"] size];
    UIImageView * img=[[UIImageView alloc]init];
    img.size=s;
    img.centerX=self.view.centerX;
    img.centerY=self.view.centerY;
    img.image=[UIImage imageNamed:@"img_wtdgl"];
    [self.view addSubview:img];
    
    UILabel * lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(0, CGRectGetMaxY(img.frame)+20, ScreenWidth, 20);
    [self.view addSubview:lb];
    lb.text=@"暂无退单管理信息";
    lb.font=[UIFont systemFontOfSize:14];
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=ColorWithRGB(128, 128, 128, 1);
    
}
- (void)exitClickBtn:(UITapGestureRecognizer *)tap{
    EPExitOrderModel * model=[self.dataArr1 objectAtIndex:tap.view.tag-900];
    [EPTool addMBProgressWithView:self.view style:0];
    [EPTool showMBWithTitle:@""];
    GetData * data=[GetData new];
    [data getOrderDetailsWithType:@"5" withCode:model.vcode withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        [EPTool hiddenMBWithDelayTimeInterval:0];
        if ([returnCode intValue]==0) {
            //退单成功
            [UIView animateWithDuration:1 animations:^{
                _lb.alpha=1.0;
                _lb.hidden=NO;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:20 animations:^{
                    _lb.hidden=YES;
                    _lb.alpha=0;
                    [self getExitOrderData];
                } completion:^(BOOL finished) {
                    
                }];
            }];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.dataArr1.count;
    }else if (section==1){
        return self.dataArr2.count;
    }else{
        return self.dataArr3.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cellId";
    UITableViewCell * cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CGFloat leftX=15;
        UIView * backVc=[[UIView alloc]init];
        [cell.contentView addSubview:backVc];
        backVc.backgroundColor=[UIColor whiteColor];
        backVc.x=0;
        backVc.y=0;
        backVc.width=ScreenWidth;
        
        CGSize ss=[UIImage imageNamed:@"订-"].size;
        UIImageView *  img1=[[UIImageView alloc]init];
        [backVc addSubview:img1];
        img1.size=ss;
        img1.x=leftX;
        img1.y=leftX;
        img1.image=[UIImage imageNamed:@"订-"];
        
        UILabel * lb=[[UILabel alloc]init];
        [backVc addSubview:lb];
        CGFloat maxX=CGRectGetMaxX(img1.frame)+10;
        CGSize s=[self sizeWithText:@"订单号: " font:[UIFont boldSystemFontOfSize:15]];
        lb.x=maxX;
        lb.width=s.width;
        lb.height=15;
        lb.y=leftX;
        lb.textColor=RGBColor(51, 51, 51);
        lb.font=[UIFont boldSystemFontOfSize:15];
        lb.text=@"订单号: ";
        UILabel * lb1=[[UILabel alloc]init];
        [backVc addSubview:lb1];
        EPExitOrderModel * model=nil;
        if (indexPath.section==0) {
            if (self.dataArr1.count>0) {
                model=[self.dataArr1 objectAtIndex:indexPath.row];
            }
        }else if(indexPath.section==1){
            if (self.dataArr2.count>0) {
                model=[self.dataArr2 objectAtIndex:indexPath.row];
            }
        }else{
            if (self.dataArr3.count>0) {
                 model=[self.dataArr3 objectAtIndex:indexPath.row];
            }
        }
        NSString * str1=[NSString stringWithFormat:@"%@",model.orderId];
        CGSize lb1S=[self sizeWithText:str1 font:[UIFont systemFontOfSize:15] maxW:ScreenWidth-leftX-CGRectGetMaxX(lb.frame)];
        lb1.numberOfLines=0;
        lb1.height=lb1S.height;
        lb1.text=str1;
        lb1.font=[UIFont systemFontOfSize:15];
        lb1.x=CGRectGetMaxX(lb.frame);
        lb1.y=13;
        lb1.width=ScreenWidth-leftX-CGRectGetMaxX(lb.frame);
        lb1.textColor=RGBColor(51, 51, 51);
    
        UIImageView *  img2=[[UIImageView alloc]init];
        [backVc addSubview:img2];
        img2.size=ss;
        img2.x=leftX;
        img2.y=CGRectGetMaxY(lb1.frame)+5;
        img2.image=[UIImage imageNamed:@"时间-"];
        
        UILabel * lb2=[[UILabel alloc]init];
        [backVc addSubview:lb2];
        lb2.frame=CGRectMake(maxX,img2.y+2, ScreenWidth-leftX-maxX,14);
        NSString * str2=[NSString stringWithFormat:@"下单时间: %@",[model.orderDate substringToIndex:16]];
        [lb2 setAttributedText:[self changeLabelWithText2:str2]];
        lb2.textColor=RGBColor(102, 102, 102);
        
        UIView * line=[[UIView alloc]init];
        [backVc addSubview:line];
        line.frame=CGRectMake(leftX,CGRectGetMaxY(lb2.frame)+10, ScreenWidth-2*leftX, 1);
        line.backgroundColor=RGBColor(238, 238, 238);
        
        UIImageView * goodImg=[[UIImageView alloc]init];
        [backVc addSubview:goodImg];
        goodImg.frame=CGRectMake(leftX, CGRectGetMaxY(line.frame)+10, 92, 55);
        [goodImg sd_setImageWithURL:[NSURL URLWithString:model.goodsImg]];
        CGFloat maxXImg=CGRectGetMaxX(goodImg.frame)+15;
        UILabel * goodName=[[UILabel alloc]init];
        [backVc addSubview:goodName];
        goodName.frame=CGRectMake(maxXImg, CGRectGetMaxY(line.frame)+15, ScreenWidth-maxXImg-leftX, 15);
        goodName.font=[UIFont boldSystemFontOfSize:15];
        goodName.textColor=RGBColor(51, 51, 51);
        goodName.text=model.goodsName;
        
        UILabel * price=[[UILabel alloc]init];
        [backVc addSubview:price];
        price.frame=CGRectMake(maxXImg, CGRectGetMaxY(goodName.frame)+20, 250, 14);
        price.font=[UIFont boldSystemFontOfSize:14];
        price.textColor=RGBColor(255,0, 0);
        price.text=[NSString stringWithFormat:@"¥%@",model.goodsPrice];
        
        UILabel * btn=[[UILabel alloc]init];
        [backVc addSubview:btn];
        btn.font=[UIFont systemFontOfSize:13];
        btn.textAlignment=NSTextAlignmentRight;
    if ([model.orderState intValue]==2) {
        btn.text=@"同意";
        btn.textColor=[UIColor whiteColor];
        btn.backgroundColor=RGBColor(0, 162, 255);
        btn.textAlignment=NSTextAlignmentCenter;
        btn.height=18;
        btn.width=50;
        btn.x=ScreenWidth-50-leftX;
        btn.y=CGRectGetMaxY(goodName.frame)+20;
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=3;
        btn.userInteractionEnabled=YES;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitClickBtn:)];
        btn.tag=900+indexPath.row;
        [btn addGestureRecognizer:tap];
    }else if ([model.orderState intValue]==4){
        btn.frame=CGRectMake(ScreenWidth-60-leftX, CGRectGetMaxY(goodName.frame)+20,60 ,13);
        btn.textColor=ColorWithRGB(128, 128, 128, 1);
        btn.backgroundColor=[UIColor whiteColor];
        btn.text=@"已确认";
    }else if ([model.orderState intValue]==3){
        btn.frame=CGRectMake(ScreenWidth-60-leftX, CGRectGetMaxY(goodName.frame)+20,60 ,13);
        btn.textColor=ColorWithRGB(128, 128, 128, 1);
        btn.backgroundColor=[UIColor whiteColor];
        btn.text=@"已退单";
    }
        UIView * line2=[[UIView alloc] init];
        [backVc addSubview:line2];
        line2.frame=CGRectMake(leftX, CGRectGetMaxY(goodImg.frame)+10, ScreenWidth-2*leftX, 1);
        line2.backgroundColor=RGBColor(238, 238, 238);
        UILabel * reson=[[UILabel alloc]init];
        [backVc addSubview:reson];
        NSString * resonStr=[NSString stringWithFormat:@"退单原因: %@",model.applyText];
        CGSize resonSize=[self sizeWithText:resonStr font:[UIFont systemFontOfSize:14]];
    reson.size=resonSize;
    reson.x=ScreenWidth-leftX-resonSize.width;
    reson.y=CGRectGetMaxY(line2.frame)+10;
    reson.font=[UIFont systemFontOfSize:14];
    reson.textColor=RGBColor(102, 102, 102);
    reson.text=resonStr;
    UIImageView * tui=[[UIImageView alloc]init];
    [backVc addSubview:tui];
    tui.size=ss;
    tui.x=CGRectGetMinX(reson.frame)-10-ss.width;
    tui.y=reson.y;
    tui.image=[UIImage imageNamed:@"包退"];
    UIView * space=[[UIView alloc]init];
    [backVc addSubview:space];
    space.frame=CGRectMake(0, CGRectGetMaxY(reson.frame)+15, ScreenWidth, 8);
    space.backgroundColor=RGBColor(238, 238, 238);
    backVc.height=CGRectGetMaxY(space.frame);
    self.cellHeight=CGRectGetMaxY(backVc.frame);
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * vc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 33)];
    vc.backgroundColor=RGBColor(238, 238, 238);
    UILabel * lb=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 33)];
    lb.font=[UIFont systemFontOfSize:14];
    lb.textColor=ColorWithRGB(159, 159, 159, 1);
    if (section==0) {
        lb.text=@"等待审核";
    }
    if(section==1){
        lb.text=@"已确认";
    }
    if(section==2){
        lb.text=@"已退单";
    }
    [vc addSubview:lb];
    return vc;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if (self.dataArr1.count>0) {
            return 33;
        }else{
            return 0;
        }
    }
    if (section==1) {
        if (self.dataArr2.count>0) {
            return 33;
        }else{
            return 0;
        }
    }else{
        if (self.dataArr3.count>0) {
            return 33;
        }else{
            return 0;
        }
    }
}
-(NSMutableAttributedString*) changeLabelWithText2:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,5)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(5,needText.length-5)];
    
    return attrString;
}
- (UITableView *)tb{
    if (!_tb) {
        _tb=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)style:UITableViewStylePlain];
        _tb.delegate=self;
        _tb.dataSource=self;
        _tb.backgroundColor=ColorWithRGB(238, 238, 238, 1);
        _tb.showsVerticalScrollIndicator=NO;
        _tb.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tb.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_tb];
    }
    return _tb;
}
- (NSMutableArray *)dataArr1{
    if (!_dataArr1) {
        _dataArr1=[[NSMutableArray alloc]init];
    }
    return _dataArr1;
}
- (NSMutableArray *)dataArr2{
    if (!_dataArr2) {
        _dataArr2=[[NSMutableArray alloc]init];
    }
    return _dataArr2;
}
- (NSMutableArray *)dataArr3{
    if (!_dataArr3) {
        _dataArr3=[[NSMutableArray alloc]init];
    }
    return _dataArr3;
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
