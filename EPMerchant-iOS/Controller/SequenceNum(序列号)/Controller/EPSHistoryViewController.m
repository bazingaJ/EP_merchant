//
//  EPSHistoryViewController.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPSHistoryViewController.h"

#import "EPSHistoryCell.h"
#import "EPResultModel.h"
@interface EPSHistoryViewController ()

@property(nonatomic,strong)UITableView * tb;
@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation EPSHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBar:0 title:@"历史记录"];
    [self tb];
}
- (void)wuOrderView{
    //无历史记录
    self.view.backgroundColor=ColorWithRGB(234, 234, 234, 1);
    CGSize s=[[UIImage imageNamed:@"img_wlsjl"] size];
    UIImageView * img=[[UIImageView alloc]init];
    img.size=s;
    img.centerX=self.view.centerX;
    img.centerY=self.view.centerY;
    img.image=[UIImage imageNamed:@"img_wlsjl"];
    [self.view addSubview:img];
    
    UILabel * lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(0, CGRectGetMaxY(img.frame)+20, ScreenWidth, 20);
    [self.view addSubview:lb];
    lb.text=@"暂无历史记录";
    lb.font=[UIFont systemFontOfSize:14];
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=ColorWithRGB(128, 128, 128, 1);
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getHistoryData];
}
- (void)getHistoryData{
    [self.dataArr removeAllObjects];
    GetData * data=[GetData new];
    [data getVcodesInfoWithType:@"3" withVcodes:nil withVcode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        CYLog(@"历史记录---%@",dict);
        if ([returnCode intValue]==0) {
            NSArray * arr=dict[@"array"];
            if (arr.count==0) {
                self.tb.hidden=YES;
                [self wuOrderView];
            }else{
                for (NSDictionary * dic in arr) {
                    EPHistoryModel * model=[EPHistoryModel mj_objectWithKeyValues:dic];
                    [self.dataArr addObject:model];
                }
                [self.tb reloadData];
            }
        }else if ([returnCode intValue]==1){
            //无历史记录
            self.tb.hidden=YES;
            [self wuOrderView];
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID=@"cellId";
    UITableViewCell * cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CGFloat leftX=15;
    if (self.dataArr.count>0) {
        EPHistoryModel * model=self.dataArr[indexPath.section];
        UIView * backVc=[[UIView alloc]init];
        [cell.contentView addSubview:backVc];
        backVc.frame=CGRectMake(0, 0, ScreenWidth, 141);
        backVc.backgroundColor=[UIColor whiteColor];
        UIView * line=[[UIView alloc]init];
        [backVc addSubview:line];
        line.frame=CGRectMake(leftX,60 , ScreenWidth-2*leftX, 1);
        line.backgroundColor=RGBColor(238, 238, 238);
        CGSize ss=[UIImage imageNamed:@"兑"].size;
        UIImageView *  img1=[[UIImageView alloc]init];
        [backVc addSubview:img1];
        img1.size=ss;
        img1.x=leftX;
        img1.y=leftX;
        img1.image=[UIImage imageNamed:@"兑"];
        UILabel * lb1=[[UILabel alloc]init];
        [backVc addSubview:lb1];
        CGFloat maxX=CGRectGetMaxX(img1.frame)+5;
        lb1.frame=CGRectMake(maxX, leftX, ScreenWidth-leftX-maxX, 16);
        NSString * str1=[NSString stringWithFormat:@"兑换码 %@",model.vcode];
        [lb1 setAttributedText:[self changeLabelWithText:str1]];
        CGSize lb1Size=[self sizeWithText:str1 font:[UIFont systemFontOfSize:15]];
        lb1.width=lb1Size.width;
        
        UIImageView *  img2=[[UIImageView alloc]init];
        [backVc addSubview:img2];
        img2.size=ss;
        img2.x=leftX;
        img2.y=CGRectGetMaxY(img1.frame)+10;
        img2.image=[UIImage imageNamed:@"时间-"];
        
        UILabel * lb2=[[UILabel alloc]init];
        [backVc addSubview:lb2];
        NSString * str2=[NSString stringWithFormat:@"%@",[model.useTime substringToIndex:16]];
        lb2.x=lb1.x+1;
        lb2.y=img2.y+2;
        lb2.height=13;
        lb2.width=250;
        lb2.text=str2;
        lb2.textColor=RGBColor(102, 102, 102);
        lb2.font=[UIFont systemFontOfSize:13];
        
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
        price.frame=CGRectMake(maxXImg, CGRectGetMaxY(goodName.frame)+20, goodName.width, 14);
        price.font=[UIFont boldSystemFontOfSize:14];
        price.textColor=RGBColor(255,0, 0);
        price.text=[NSString stringWithFormat:@"¥%@",model.goodsPrice];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView * vc=[[UIView alloc]init];
        vc.frame=CGRectMake(0, 0, ScreenWidth, 33);
        UILabel * lb=[[UILabel alloc]init];
        lb.frame=CGRectMake(15, 0, 120, 33);
        lb.font=[UIFont systemFontOfSize:14];
        lb.text=@"已使用";
        lb.textColor=ColorWithRGB(159, 159, 159, 1);
        [vc addSubview:lb];
        return vc;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 33;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 141;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat sectionHeaderHeight = 33;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
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
-(NSMutableAttributedString*) changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    UIFont *font = [UIFont boldSystemFontOfSize:15];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,3)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3,needText.length-3)];
    UIColor *color = ColorWithRGB(51, 51, 51, 1);
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, 3)];
    UIColor *color2 = ColorWithRGB(102, 102, 102, 1);
    [attrString addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(3, needText.length-3)];
    return attrString;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
