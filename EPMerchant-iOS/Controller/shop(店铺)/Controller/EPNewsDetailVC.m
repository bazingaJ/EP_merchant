//
//  EPNewsDetailVC.m
//  EPin-IOS
//
//  Created by jeaderL on 16/6/29.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import "EPNewsDetailVC.h"
#import "JDPushData.h"
#import "JDPushDataTool.h"
@interface EPNewsDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic, assign) CGFloat cellHeigh;
@end

@implementation EPNewsDetailVC
{
    NSString * _str;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"消息详情"];
    self.tb.delegate=self;
    self.tb.dataSource=self;
    self.tb.backgroundColor=ColorWithRGB(234, 234, 234,1);
//    _str=@"编辑";
//    if (!self.tb.isEditing) {
//        _str=@"编辑";
//    }else{
//        _str=@"完成";
//    }
//    [self addRightItemWithFrame:CGRectMake(20,0,44,44) textOrImage:1 action:@selector(edit) name:_str];
}
//- (void)edit{
//    [self.tb setEditing:!self.tb.isEditing animated:YES];
//    [self viewDidLoad];
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataArr.count==0) {
        [self showHaveNoMessage];
    }
    NSUserDefaults * us=[NSUserDefaults standardUserDefaults];
    if ([self.news isEqualToString:@"订单消息"]) {
        [us setObject:@"1" forKey:@"order"];
    }else if ([self.news isEqualToString:@"退单消息"]){
        [us setObject:@"2" forKey:@"exit"];
    }
    [us synchronize];
//        for (NSDictionary *dict in [[JDPushDataTool new] query]) {
//            
//            if ([self.news isEqualToString:@"易品"]) {
//                if ([dict[@"methodName"] isEqualToString:@"use"]) {
//                    JDPushData *data = [JDPushData pushDataWithDictionary:dict];
//                    [self.dataArr addObject:data];
//                }
//            }else if ([self.news isEqualToString:@"订单消息"]){
//                if ([dict[@"methodName"] isEqualToString:@"shopRest"]) {
//                    JDPushData *data = [JDPushData pushDataWithDictionary:dict];
//                    [self.dataArr addObject:data];
//                }
//            }
//            [self.tb reloadData];
//        }
//        if (self.dataArr.count) {
//            
//        }else{
//            /**
//             *  设置没有消息的界面
//             */
//            self.tb.hidden=YES;
//            [self showHaveNoMessage];
//            
//        }
}
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attri  =[NSMutableDictionary dictionary];
    attri[NSFontAttributeName] = font;
    CGSize maxSize =CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
}
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}
- (void)showHaveNoMessage{
    self.view.backgroundColor=ColorWithRGB(234, 234, 234,1);
    UILabel * lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(0, ScreenHeight/2,ScreenWidth, 20);
    lb.text=@"您当前没有任何消息";
    lb.font=[UIFont systemFontOfSize:15];
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=ColorWithRGB(128, 128, 128,1);
    [self.view addSubview:lb];
}
#pragma mark-----UITableViewDelegate-----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDPushData *data = self.dataArr[indexPath.section];
    static NSString * cellID=@"cell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=ColorWithRGB(234, 234, 234, 1);
        UIView * back=[[UIView alloc]init];
        back.layer.masksToBounds=YES;
        back.layer.cornerRadius=5;
        //back.frame=CGRectMake(20, 0, EPScreenW-40, 75);
        back.x=20;
        back.y=0;
        back.width=ScreenWidth-40;
        
        back.backgroundColor=[UIColor whiteColor];
        
        UIView * l=[[UIView  alloc]init];
        l.frame=CGRectMake(0,25, ScreenWidth-40, 1);
        l.backgroundColor=ColorWithRGB(217, 217, 217,1);
        [back  addSubview:l];
        
        UILabel * time=[[UILabel alloc]init];
        time.frame=CGRectMake(10, 0, 200, 25);
        time.font=[UIFont systemFontOfSize:12];
        time.text=data.currentTime;
        time.textColor=ColorWithRGB(128, 128, 128,1);
        [back addSubview:time];
        
        UILabel * content=[[UILabel alloc]init];
        content.font=[UIFont systemFontOfSize:14];
        content.text=data.content;
        CGSize labelSize = [self sizeWithText:data.content font:[UIFont systemFontOfSize:14] maxW:ScreenWidth-40-20];
        content.x=10;
        content.y=CGRectGetMaxY(l.frame)+5;
        content.height=labelSize.height;
        content.width=ScreenWidth-40-20;
        content.numberOfLines=0;
        
        back.height=CGRectGetMaxY(content.frame)+5;
        self.cellHeigh=CGRectGetMaxY(content.frame)+5;
        [back addSubview:content];
        [cell.contentView addSubview:back];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeigh;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * vc=[[UIView alloc]init];
    vc.frame=CGRectMake(0, 0, ScreenWidth, 15);
    vc.backgroundColor=ColorWithRGB(234, 234, 234,1);
    return vc;
}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle ==UITableViewCellEditingStyleDelete) {
//        //移除
//       // [self.tableVi reloadData];
//    }
//}
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
