//
//  EPGoodsDetailVC1.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/7/19.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPGoodsDetailVC1.h"
#import "EPDetailModel.h"
#import "EPDetailCell.h"
#import "EPGoodsDownViewController.h"
#import "EPMoreCommentVC.h"
@interface EPGoodsDetailVC1 ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tabVi;

@property(nonatomic,strong)EPDetailModel * model;

@property(nonatomic,strong)NSMutableArray * commentArr;

@end

@implementation EPGoodsDetailVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationBar:0 title:@"商品详情"];
    [self tabVi];
    self.tabVi.hidden=YES;
}
- (void)tapDownGoods{
    EPGoodsDownViewController * vc=[[EPGoodsDownViewController alloc]init];
    vc.goodName=_model.goodsName;
    vc.goodsId=self.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)creatTableViewFooter{
    UIView * vc=[[UIView alloc]init];
    vc.userInteractionEnabled=YES;
    vc.frame=CGRectMake(0, 0, ScreenWidth, 30);
    vc.backgroundColor=[UIColor whiteColor];
    UIView * line=[[UIView alloc]init];
    [vc addSubview:line];
    line.frame=CGRectMake(20, 0, ScreenWidth-40, 1);
    line.backgroundColor=ColorWithRGB(217, 217, 217, 1);
    UILabel * lb=[[UILabel alloc]init];
    [vc addSubview:lb];
    lb.frame=CGRectMake(20, 0, ScreenWidth-40,30 );
    lb.font=[UIFont systemFontOfSize:13];
    lb.textColor=ColorWithRGB(0, 0, 0, 1);
    lb.text=@"查看全部网友点评>";
    lb.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreComment)];
    [lb addGestureRecognizer:tap];
    self.tabVi.tableFooterView=vc;
}
- (void)moreComment{
    //跳转到更多评价
    EPMoreCommentVC * vc=[[EPMoreCommentVC alloc]init];
    vc.commentArr=self.commentArr;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addView{
    UIView * vc=[[UIView alloc]init];
    vc.frame=CGRectMake(0, ScreenHeight-50, ScreenWidth, 50);
    vc.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:vc];
    vc.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDownGoods)];
    [vc addGestureRecognizer:tap];
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.width=80;
    btn.height=50;
    btn.y=0;
    btn.centerX=vc.centerX+20;
    [btn setTitle:@"商品下架" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn addTarget:self action:@selector(tapDownGoods) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:btn];
    
    CGSize s=[[UIImage imageNamed:@"ItemDownshelf."] size];
    UIButton * img=[UIButton buttonWithType:UIButtonTypeCustom];
    img.x=CGRectGetMinX(btn.frame)-5-s.width;
    img.y=(50-s.height)/2;
    img.size=s;
    [img setImage:[UIImage imageNamed:@"ItemDownshelf."] forState:UIControlStateNormal];
    [img addTarget:self action:@selector(tapDownGoods) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:img];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDetailData];
    [self getCommentData];
}
//获取详情数据
- (void)getDetailData{
    [EPTool addMBProgressWithView:self.view style:0];
    [EPTool showMBWithTitle:@"加载中..."];
    NSString * str =[NSString stringWithFormat:@"%@/getAllGoodsData.json",EPUrl];
    NSDictionary * dict=@{@"userName":USERNAME,
                          @"loginTime":LOGINTIME,
                          @"goodsId":self.goodsId,
                          @"type":@"2"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       // CYLog(@"商品详情---%@",responseObject);
        [EPTool hiddenMBWithDelayTimeInterval:0];
        int returnCode=[responseObject[@"returnCode"] intValue];
        NSString * msg=responseObject[@"msg"];
        if (returnCode==0) {
            self.tabVi.hidden=NO;
            EPDetailModel * model=[EPDetailModel mj_objectWithKeyValues:responseObject];
            _model=model;
            [self.tabVi reloadData];
            [self addView];
        }else if(returnCode==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"该商品已经下架或删除" count:0 doWhat:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if (returnCode==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"由于网络问题，获取数据失败，请稍后重试" count:0 doWhat:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
- (void)getCommentData{
    [self.commentArr removeAllObjects];
    NSString * str =[NSString stringWithFormat:@"%@/getCommentInfo.json",EPUrl];
    NSDictionary * dict=@{@"userName":USERNAME,
                          @"loginTime":LOGINTIME,
                          @"goodsId":self.goodsId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       // CYLog(@"评论数据--%@",responseObject);
        NSArray * commentArr=responseObject[@"commentArr"];
        for (NSDictionary * dict in commentArr) {
            EPGetCommentModel * model=[EPGetCommentModel mj_objectWithKeyValues:dict];
            [self.commentArr addObject:model];
        }
        if (self.commentArr.count>=3) {
            [self creatTableViewFooter];
        }
        [self.tabVi reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.commentArr.count==0) {
        return 2;
    }else{
        return 3;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        if (self.commentArr.count>=3) {
            return 3;
        }else{
            return self.commentArr.count;
        }
    }
    if(section==1){
        return _model.detailsRecord.count;
    }
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    CGFloat leftX=12;
    if (indexPath.section==0) {
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        if (_model) {
            UIImageView * img=[[UIImageView alloc]init];
            img.frame=CGRectMake(0, 0, ScreenWidth, HEIGHT(175.0, 667));
            [img sd_setImageWithURL:[NSURL URLWithString:_model.goodsImg]];
            [cell.contentView addSubview:img];
            
            UIView * white=[[UIView alloc]init];
            white.frame=CGRectMake(0, CGRectGetMaxY(img.frame), ScreenWidth, 65);
            white.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:white];
            UILabel * name=[[UILabel alloc]init];
            name.text=_model.goodsName;
            name.x=12;
            name.y=10;
            name.font=[UIFont systemFontOfSize:17];
            name.height=17;
            name.width=ScreenWidth-24;
            [white addSubview:name];
            
            UILabel * price=[[UILabel alloc]init];
            price.y=CGRectGetMaxY(name.frame)+5;
            price.height=36;
            price.width=100;
            price.x=ScreenWidth-12-100;
            price.text=[NSString stringWithFormat:@"¥%@",_model.goodsPrice];
            price.font=[UIFont systemFontOfSize:24];
            price.textColor=ColorWithRGB(244, 64, 29, 1);
            price.textAlignment=NSTextAlignmentRight;
            price.adjustsFontSizeToFitWidth=YES;
            [white addSubview:price];
            
            int count=[_model.goodsStar intValue];
            CGSize starS=[[UIImage imageNamed:@"空心五角星"] size];
            for (int i=0; i<5; i++) {
                UIImageView * star=[[UIImageView alloc]init];
                star.x=12+i*(starS.width+6);
                star.y=CGRectGetMaxY(name.frame)+12;
                star.size=starS;
                if (i<count) {
                    star.image=[UIImage imageNamed:@"five_pointed_star"];
                }else{
                    star.image=[UIImage imageNamed:@"空心五角星"];
                }
                [white addSubview:star];
            }
            
            UILabel * soldNumber=[[UILabel alloc]init];
            soldNumber.y=CGRectGetMaxY(name.frame)+15;
            soldNumber.width=200;
            soldNumber.height=13;
            soldNumber.x=12+4*6+starS.width*5+15;
            soldNumber.text=[NSString stringWithFormat:@"已售%@份",_model.soldNumber];
            soldNumber.font=[UIFont systemFontOfSize:12];
            soldNumber.textColor=ColorWithRGB(128,128, 128, 1);
            [white addSubview:soldNumber];
        }
        return cell;
    }else if (indexPath.section==1){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //优化方案
        if (_model.detailsRecord>0) {
            for (int i=0; i<2; i++) {
                UILabel * lb=[[UILabel alloc]init];
                [cell.contentView addSubview:lb];
                if (i==0) {
                    lb.x=leftX;
                    lb.width=ScreenWidth-24-80;
                }else{
                    lb.x=ScreenWidth-leftX-80;
                    lb.width=80;
                }
                lb.y=0;
                lb.height=30;
                lb.font=[UIFont systemFontOfSize:12];
                if (i==0) {
                    lb.text=_model.detailsRecord[indexPath.row][@"label"];
                }else if (i==1){
                    lb.textAlignment=NSTextAlignmentRight;
                    lb.text=[NSString stringWithFormat:@"%@",_model.detailsRecord[indexPath.row][@"value"]];
                }
            }
        }
        return cell;
    }else{
        //用户评价
        EPDetailCell * cell5=[tableView dequeueReusableCellWithIdentifier:@"EPDetailCell"];
        cell5.selectionStyle=UITableViewCellSelectionStyleNone;
        if (self.commentArr.count>0) {
            EPGetCommentModel * model=[self.commentArr objectAtIndex:indexPath.row];
            cell5.model=model;
        }
        return cell5;
        
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * vc=[[UIView alloc]init];
    vc.frame=CGRectMake(0, 0, ScreenWidth,30);
    vc.backgroundColor=[UIColor whiteColor];
    UILabel * lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(12,0, 200, 30);
    lb.font=[UIFont systemFontOfSize:14];
    [vc addSubview:lb];
    if (_model.detailsRecord.count>0) {
        if (section==1) {
            lb.text=@"团购详情";
            UILabel * l=[[UILabel alloc]initWithFrame:CGRectMake(12, 29, ScreenWidth-24, 1)];
            l.backgroundColor=ColorWithRGB(217,217,217,1);
            [vc addSubview:l];
        }
    }
    if (section==2){
        lb.text=@"用户评价";
    }
    return vc;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    if (section==1) {
        if (_model.detailsRecord.count>0) {
            return 30;
        }else{
            return 0;
        }
    }else{
        if (self.commentArr.count>0) {
            return 30;
        }else{
            return 0;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        if (_model.detailsRecord.count>0) {
            return 5;
        }else{
            return 0;
        }
    }
    if (section==1) {
        if (self.commentArr.count>0) {
            return 5;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return HEIGHT(175.0, 667)+65;
    }else if (indexPath.section==1){
        return 30;
    }else{
        return 80;
    }
}
- (UITableView *)tabVi{
    if (_tabVi==nil) {
        _tabVi=[[UITableView alloc]initWithFrame:CGRectMake(0,64,ScreenWidth,ScreenHeight-20-49-50) style:UITableViewStylePlain];
        _tabVi.showsVerticalScrollIndicator=NO;
        _tabVi.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tabVi.backgroundColor=ColorWithRGB(238, 238, 238, 1);
        _tabVi.delegate=self;
        _tabVi.dataSource=self;
        [_tabVi registerNib:[UINib nibWithNibName:@"EPDetailCell" bundle:nil] forCellReuseIdentifier:@"EPDetailCell"];
        [self.view addSubview:_tabVi];
    }
    return _tabVi;
}
- (NSMutableArray *)commentArr{
    if (!_commentArr) {
        _commentArr=[[NSMutableArray alloc]init];
    }
    return _commentArr;
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
