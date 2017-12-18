//
//  EPShopVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPShopVC.h"
#import "EPShopCell1.h"
#import "EPShopNewsVC.h"
#import "EPShopCountVC.h"
#import "EPSetVC.h"
#import "EPOrderDetailVC.h"
#import "EPShopRevenueVC.h"
#import "EPAddBankCardVC.h"
#import "EPChargeBackVC.h"
#import "EPShopMessageVC.h"
#import "EPShopModel.h"
#define btnTag 800
@interface EPShopVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tb;

@property(nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,strong)EPShopModel * model;

@end

@implementation EPShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:2 title:@"店 铺"];
    self.tb.backgroundColor=ColorWithRGB(234,234, 234, 1);
    [self tb];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [EPTool checkNetWorkWithCompltion:^(NSInteger statusCode) {
        if (statusCode == 0)
        {
            [EPTool addMBProgressWithView:self.view style:0];
            [EPTool showMBWithTitle:@"当前网络不可用"];
            [EPTool hiddenMBWithDelayTimeInterval:1];
            [self creatFileLoad];
            [self.tb reloadData];
        }
        else
        {
            [self getShopData];
        }
    }];
}
- (void)creatFileLoad{
    FileHander *hander = [FileHander shardFileHand];
    NSDictionary *responseObject =[hander readFile:@"shopData"];
    [self loadData:responseObject];
}
- (void)getShopData{
    GetData * data=[GetData new];
    [data getOwnShopDataWithType:@"0" withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
       //CYLog(@"店铺---%@",dict);
        if ([returnCode intValue]==0) {
            FileHander *hander = [FileHander shardFileHand];
            NSString *sss=@"ss";
            [hander saveFile:dict withForName:@"shopData" withError:&sss];
            [self loadData:dict];
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
- (void)loadData:(NSDictionary *)dict{
    EPShopModel * model=[EPShopModel mj_objectWithKeyValues:dict];
    _model=model;
}
- (void)btnClick:(UIButton *)btn{
    [self switchTag:btn.tag-btnTag];
}
- (void)btnClickView:(UITapGestureRecognizer *)tap{
    [self switchTag:tap.view.tag-btnTag];
    
}
- (void)switchTag:(NSInteger)tagBtn{
    switch (tagBtn) {
        case 0:
        {
            //店铺账户
            EPShopCountVC * vc=[[EPShopCountVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            //店铺营收
            EPShopRevenueVC * vc=[[EPShopRevenueVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
//        case 2:{
//            //银行卡
//            //[EPTool addAlertViewInView:self title:@"温馨提示" message:@"待开发" count:0 doWhat:nil];
//            EPAddBankCardVC * card=[[EPAddBankCardVC alloc]init];
//            [self.navigationController pushViewController:card animated:YES];
//        }
//            break;
        case 2:{
            //退单管理
            EPChargeBackVC * vc=[[EPChargeBackVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            //订单明细
            EPOrderDetailVC * vc=[[EPOrderDetailVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{
            //跳转店铺消息
            EPShopNewsVC * vc=[[EPShopNewsVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{
            //设置
            EPSetVC * vc=[[EPSetVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }

}
#pragma MARK-----dataSource----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        EPShopCell1 * cell=[tableView dequeueReusableCellWithIdentifier:@"EPShopCell1"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (_model) {
             cell.model=_model;
        }
        return cell;
    }else{
        static NSString * cellID=@"cell";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            CGFloat btnW=ScreenWidth/3;
            CGFloat btnH=120;
//            NSArray * text=@[@"店铺账户",@"店铺营收",@"银行卡",@"退单管理",@"订单明细",@"店铺消息",@"设置"];
//            NSArray * imgArr=@[@"Account",@"revenue",@"bank_card",@"chargeback",@"detail",@"news",@"set"];
//            CGSize s=[[UIImage imageNamed:@"Account"] size];
//            for (int i=0; i<9; i++) {
//                UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
//                btn.frame=CGRectMake(i%3*btnW, i/3*btnH, btnW, btnH);
//                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//                [cell.contentView addSubview:btn];
//                if (i<=6) {
//                    btn.tag=btnTag+i;
//                    UIButton * small=[UIButton buttonWithType:UIButtonTypeCustom];
//                    small.frame=CGRectMake((btnW-s.width)/2,120-32-16-15-s.height, s.width, s.height);
//                    [small setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
//                    [small addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//                    small.tag=btnTag+i;
//                    [btn addSubview:small];
//                    
//                    UILabel * lb=[[UILabel alloc]init];
//                    lb.frame=CGRectMake(0, CGRectGetMaxY(small.frame)+15, btnW, 20);
//                    lb.text=text[i];
//                    lb.userInteractionEnabled=YES;
//                    lb.textAlignment=NSTextAlignmentCenter;
//                    lb.font=[UIFont systemFontOfSize:16];
//                    lb.tag=btnTag+i;
//                    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClickView:)];
//                    [lb addGestureRecognizer:tap];
//                    [btn addSubview:lb];
//                    
//                }
//            }
//            for (int i=0; i<2; i++) {
//                UIView * vc1=[[UIView alloc]initWithFrame:CGRectMake(btnW*(i+1), 0, 1, 360)];
//                vc1.backgroundColor=ColorWithRGB(217, 217, 217, 1);
//                [cell.contentView addSubview:vc1];
//                
//                UIView * vc2=[[UIView alloc]initWithFrame:CGRectMake(0, btnH*(i+1),ScreenWidth,1)];
//                vc2.backgroundColor=ColorWithRGB(217, 217, 217, 1);
//                [cell.contentView addSubview:vc2];
//            }
            NSArray * textArr=@[@"店铺账户",@"店铺营收",@"退单管理",@"订单明细",@"店铺消息",@"设置"];
            NSArray * imgArr=@[@"Account",@"revenue",@"chargeback",@"detail",@"news",@"set"];
            CGSize s=[UIImage imageNamed:@"Account"].size;
            for (int  i=0; i<6; i++) {
                UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [cell.contentView addSubview:btn];
                btn.frame=CGRectMake(i%3*btnW, i/3*btnH, btnW, btnH);
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag=btnTag+i;
                
                UIButton * small=[UIButton buttonWithType:UIButtonTypeCustom];
                small.frame=CGRectMake((btnW-s.width)/2,120-32-16-15-s.height, s.width, s.height);
                [small setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
                [small addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                small.tag=btnTag+i;
                [btn addSubview:small];
                
                UILabel * lb=[[UILabel alloc]init];
                lb.frame=CGRectMake(0, CGRectGetMaxY(small.frame)+15, btnW, 20);
                lb.text=textArr[i];
                lb.userInteractionEnabled=YES;
                lb.textAlignment=NSTextAlignmentCenter;
                lb.font=[UIFont systemFontOfSize:16];
                lb.tag=btnTag+i;
                UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClickView:)];
                [lb addGestureRecognizer:tap];
                [btn addSubview:lb];
            }
            for (int i=0; i<2; i++) {
                UIView * vc1=[[UIView alloc]initWithFrame:CGRectMake(btnW*(i+1), 0, 1,240)];
                vc1.backgroundColor=ColorWithRGB(217, 217, 217, 1);
                [cell.contentView addSubview:vc1];
            }
            UIView * vc2=[[UIView alloc]initWithFrame:CGRectMake(0, btnH,ScreenWidth,1)];
            vc2.backgroundColor=ColorWithRGB(217, 217, 217, 1);
            [cell.contentView addSubview:vc2];
            
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 107;
    }else{
        //return 360;
        return 240;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        EPShopMessageVC * vc=[[EPShopMessageVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UITableView *)tb{
    if (!_tb) {
        _tb=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-60) style:UITableViewStylePlain];
        _tb.dataSource=self;
        _tb.delegate=self;
        _tb.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tb registerNib:[UINib nibWithNibName:@"EPShopCell1" bundle:nil] forCellReuseIdentifier:@"EPShopCell1"];
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
