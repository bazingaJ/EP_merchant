//
//  EPOrderDetailVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPOrderDetailVC.h"
#import "EPOrderModel.h"
#define btnTag 900
@interface EPOrderDetailVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIScrollView * bgScroll;
@property(nonatomic,strong)UIView * moveLine;
@property(nonatomic,strong)NSMutableArray * dataSource;
//已使用
@property(nonatomic,strong)NSMutableArray * useArr;
//未使用
@property(nonatomic,strong)NSMutableArray * noUseArr;
//待付款
@property(nonatomic,strong)NSMutableArray * payArr;

@property(nonatomic,strong)UIView * vc;

@property(nonatomic,strong)UITableView * tb;

@property(nonatomic,assign)CGFloat cellHeight;


@end

@implementation EPOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"订单明细"];
    [self ctreatBtn];
}
- (void)creatNoOrder:(int)count{
    _bgScroll.backgroundColor=ColorWithRGB(234, 234, 234, 1);
    CGSize s=[[UIImage imageNamed:@"img_wddmx"] size];
    UIImageView * img=[[UIImageView alloc]init];
    img.size=s;
    img.x=count*ScreenWidth+ScreenWidth/2-s.width/2;
    img.y=150;
    img.image=[UIImage imageNamed:@"img_wddmx"];
    [_bgScroll addSubview:img];
    
    UILabel * lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(count*ScreenWidth, CGRectGetMaxY(img.frame)+20, ScreenWidth, 20);
    [_bgScroll addSubview:lb];
    lb.text=@"暂无订单";
    lb.font=[UIFont systemFontOfSize:14];
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=ColorWithRGB(128, 128, 128, 1);
}
- (void)getAllData{
    [self.dataSource removeAllObjects];
    GetData * data=[GetData new];
    [data getOrderDetailsWithType:@"0" withCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
       CYLog(@"获取我的订单所有%@",dict);
        if ([returnCode intValue]==0) {
            NSArray * arr=dict[@"goodsArr"];
            if (arr.count==0) {
                self.tb.hidden=YES;
                [self creatNoOrder:0];
            }else{
                self.tb.hidden=NO;
                for (NSDictionary * dic in arr) {
                    EPOrderModel * model=[EPOrderModel mj_objectWithKeyValues:dic];
                    [self.dataSource addObject:model];
                }
                [self.tb reloadData];
            }
        }
    }];
}
- (void)getUseData{
    [self.dataSource removeAllObjects];
    GetData * data=[GetData new];
    [data getOrderDetailsWithType:@"1" withCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
       CYLog(@"获取我的订单已使用%@",dict);
        if ([returnCode intValue]==0) {
            NSArray * arr=dict[@"goodsArr"];
            if (arr.count==0) {
                self.tb.hidden=YES;
                [self creatNoOrder:1];
            }else{
                self.tb.hidden=NO;
                for (NSDictionary * dic in arr) {
                    EPOrderModel * model=[EPOrderModel mj_objectWithKeyValues:dic];
                    [self.dataSource addObject:model];
                }
                [self.tb reloadData];
            }
        }
    }];
}
- (void)getNoUseData{
    [self.dataSource removeAllObjects];
    GetData * data=[GetData new];
    [data getOrderDetailsWithType:@"2" withCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        CYLog(@"获取我的订单未使用%@",dict);
        if ([returnCode intValue]==0) {
            NSArray * arr=dict[@"goodsArr"];
            if (arr.count==0) {
                self.tb.hidden=YES;
                [self creatNoOrder:2];
            }else{
                self.tb.hidden=NO;
                for (NSDictionary * dic in arr) {
                    EPOrderModel * model=[EPOrderModel mj_objectWithKeyValues:dic];
                    [self.dataSource addObject:model];
                }
                [self.tb reloadData];
            }
           }
    }];
}
- (void)getPayData{
    [self.dataSource removeAllObjects];
    GetData * data=[GetData new];
    [data getOrderDetailsWithType:@"3" withCode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
       CYLog(@"获取我的订单待付款%@",dict);
        if ([returnCode intValue]==0) {
            NSArray * arr=dict[@"goodsArr"];
            if (arr.count==0) {
                self.tb.hidden=YES;
                [self creatNoOrder:3];
            }else{
                self.tb.hidden=NO;
                for (NSDictionary * dic in arr) {
                    EPOrderModel * model=[EPOrderModel mj_objectWithKeyValues:dic];
                    [self.dataSource addObject:model];
                }
                [self.tb reloadData];
            }
        }
    }];
}
- (void)ctreatBtn{
    NSArray * arr=@[@"全部订单",@"已使用",@"未使用",@"待付款"];
    CGFloat btnW=ScreenWidth/4;
    for (int i=0; i<4; i++) {
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(btnW*i, 64, btnW, 45);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
        [btn setTitleColor:RGBColor(250, 207,131) forState:UIControlStateSelected];
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        btn.tag=btnTag+i;
        if (i==0) {
            btn.selected=YES;
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    UIView * move=[[UIView alloc]initWithFrame:CGRectMake(0, 109, btnW, 2)];
    move.backgroundColor=ColorWithRGB(250, 207, 131, 1);
    _moveLine=move;
    [self.view addSubview:move];
    
    UIScrollView *bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,109+2, ScreenWidth, ScreenHeight-109+2)];
    _bgScroll=bgScroll;
    bgScroll.contentSize = CGSizeMake(ScreenWidth*4, 0);
    _bgScroll.pagingEnabled = YES;
    _bgScroll.showsVerticalScrollIndicator = NO;
    _bgScroll.showsHorizontalScrollIndicator = NO;
    _bgScroll.delegate = self;
    _bgScroll.bounces = NO;
    [self.view addSubview:bgScroll];
    
    self.tb=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, bgScroll.height) style:UITableViewStylePlain];
    self.tb.backgroundColor=ColorWithRGB(238, 238, 238, 1);
    self.tb.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tb.dataSource=self;
    self.tb.delegate=self;
    [bgScroll addSubview:self.tb];
    [self getAllData];
    
}
- (void)btnClick:(UIButton *)btn{
    UIButton * btn1=[self.view viewWithTag:btnTag];
    UIButton * btn2=[self.view viewWithTag:btnTag+1];
    UIButton * btn3=[self.view viewWithTag:btnTag+2];
    UIButton * btn4=[self.view viewWithTag:btnTag+3];
    switch (btn.tag-btnTag) {
        case 0:{
            [UIView animateWithDuration:.2 animations:^{
                _bgScroll.contentOffset = CGPointMake(0, 0);
            } completion:^(BOOL finished) {
                btn.selected=YES;
                btn2.selected=NO;
                btn3.selected=NO;
                btn4.selected=NO;
                _moveLine.x=0;
                self.tb.x=0;
                [self getAllData];
            }];
        }
            break;
        case 1:{
            [UIView animateWithDuration:.2 animations:^{
                _bgScroll.contentOffset = CGPointMake(ScreenWidth, 0);
            } completion:^(BOOL finished) {
                btn.selected=YES;
                btn1.selected=NO;
                btn3.selected=NO;
                btn4.selected=NO;
                _moveLine.x=ScreenWidth/4;
                self.tb.x=ScreenWidth;
                [self getUseData];
            }];
            
        }
            break;
        case 2:{
            [UIView animateWithDuration:.2 animations:^{
                _bgScroll.contentOffset = CGPointMake(ScreenWidth*2, 0);
            } completion:^(BOOL finished) {
                btn.selected=YES;
                btn1.selected=NO;
                btn2.selected=NO;
                btn4.selected=NO;
                 _moveLine.x=ScreenWidth/4*2;
                self.tb.x=ScreenWidth*2;
                [self getNoUseData];
            }];
           
        }
            break;
        case 3:{
            [UIView animateWithDuration:.2 animations:^{
                _bgScroll.contentOffset = CGPointMake(ScreenWidth*3, 0);
            } completion:^(BOOL finished) {
                btn.selected=YES;
                btn2.selected=NO;
                btn3.selected=NO;
                btn1.selected=NO;
                _moveLine.x=ScreenWidth/4*3;
                self.tb.x=ScreenWidth*3;
                [self getPayData];
            }];
        }
            break;
        default:
            break;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIButton * btn1=[self.view viewWithTag:btnTag];
    UIButton * btn2=[self.view viewWithTag:btnTag+1];
    UIButton * btn3=[self.view viewWithTag:btnTag+2];
    UIButton * btn4=[self.view viewWithTag:btnTag+3];
    if (scrollView==_bgScroll) {
        CGFloat offsetX = scrollView.contentOffset.x;
        _moveLine.x = offsetX/4;
        if (offsetX==0) {
            btn1.selected=YES;
            btn2.selected=NO;
            btn3.selected=NO;
            btn4.selected=NO;
            self.tb.x=0;
            [self getAllData];
        }else if (offsetX==ScreenWidth){
            btn2.selected=YES;
            btn1.selected=NO;
            btn3.selected=NO;
            btn4.selected=NO;
            self.tb.x=ScreenWidth;
            [self getUseData];
        }else if (offsetX==ScreenWidth*2){
            btn3.selected=YES;
            btn1.selected=NO;
            btn2.selected=NO;
            btn4.selected=NO;
            self.tb.x=ScreenWidth*2;
            [self getNoUseData];
        }else if (offsetX==ScreenWidth*3){
            btn4.selected=YES;
            btn2.selected=NO;
            btn3.selected=NO;
            btn1.selected=NO;
            self.tb.x=ScreenWidth*3;
            [self getPayData];
        }
    }
    CGFloat sectionHeaderHeight = 8;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID=@"cellId";
    UITableViewCell * cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CGFloat leftX=15;
    if (self.dataSource.count>0) {
        EPOrderModel * model=[self.dataSource objectAtIndex:indexPath.section];
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
        NSString * str1=[NSString stringWithFormat:@"%@",model.orderId];
        CGSize lb1S=[self sizeWithText:str1 font:[UIFont systemFontOfSize:15] maxW:ScreenWidth-leftX-CGRectGetMaxX(lb.frame)];
        lb1.font=[UIFont systemFontOfSize:15];
        lb1.x=CGRectGetMaxX(lb.frame);
        lb1.y=13;
        lb1.width=ScreenWidth-leftX-CGRectGetMaxX(lb.frame);
        lb1.height=lb1S.height;
        lb1.text=str1;
        lb1.textColor=RGBColor(51, 51, 51);
        lb1.numberOfLines=0;
        
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
        btn.frame=CGRectMake(ScreenWidth-60-leftX, CGRectGetMaxY(goodName.frame)+20,60 ,13);
        btn.font=[UIFont systemFontOfSize:13];
        btn.textColor=RGBColor(102,102, 102);
        btn.textAlignment=NSTextAlignmentRight;
        if (model.orderState==nil) {
            btn.text=@"待付款";
        }else{
            if ([model.orderState intValue]==0) {
                btn.text=@"未使用";
            }else if ([model.orderState intValue]==1){
                btn.text=@"已使用";
            }else if ([model.orderState intValue]==2){
                btn.text=@"申请退款";
            }else if ([model.orderState intValue]==3){
                btn.text=@"已退款";
            }else if ([model.orderState intValue]==4){
                btn.text=@"商家确认";
            }
        }
        backVc.height=CGRectGetMaxY(goodImg.frame)+10;
        self.cellHeight=CGRectGetMaxY(backVc.frame);
   }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
-(NSMutableAttributedString*) changeLabelWithText2:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,5)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(5,needText.length-5)];
    
    return attrString;
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
