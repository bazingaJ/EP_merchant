//
//  EPGoodsReposityViewController.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPGoodsReposityViewController.h"

#import "EPGoodsReposityCell.h"
#import "EPGoodsReosityButtonView.h"

#import "EPGoodsUpHttpRequest.h"

#import "EPGoodsInfo.h"

@interface EPGoodsReposityViewController () <EPGoodsReposityBtnViewDelegate>

@property(nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation EPGoodsReposityViewController

-(NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavigationBar:0 title:@"商品仓库"];
    // 配置collectionview
    [self configureCollectionView];
    
    [self getData];
    
}
-(void)getData
{
    // 商品列表
    [EPGoodsUpHttpRequest pushGoodsWithID:@"" type:@"1" InVC:self success:^(NSArray *modelArr) {
        
        [self.modelArr removeAllObjects];
        
        [self.modelArr addObjectsFromArray:modelArr];
        [self.collectionView reloadData];
        if (self.modelArr.count==0) {
            //无商品
            [self wuView];
        }
        
    } failure:^(NSError *error) {
        CYLog(@"%@",error);
    }];
}
- (void)wuView{
    UILabel * lb=[[UILabel alloc]init];
    [self.view addSubview:lb];
    lb.frame=CGRectMake(0,ScreenHeight/2-10, ScreenWidth, 20);
    lb.text=@"暂无商品";
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=[UIColor blackColor];
}
// 配置collectionview
-(void)configureCollectionView
{
    // collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((ScreenWidth-30)/2, 380/2+20);// 每个item大小
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical; // 垂直滚动
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = ColorWithRGB(237, 237, 237, 1);
    [collectionView registerClass:[EPGoodsReposityCell class] forCellWithReuseIdentifier:@"cell"];
}


#pragma mark - collection view delegate & datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EPGoodsInfo *goodsInfo = self.modelArr[indexPath.row];
    
    EPGoodsReposityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.btnView.delegate = self;
    cell.btnView.indexPath = indexPath;
    
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsInfo.goodsImg]];
    cell.nameLabel.text = goodsInfo.goodsName;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",goodsInfo.goodsPrice];
    
    return cell;
}

#pragma mark delegate goods reposity btn view
-(void)goodsReposityButtonClick:(NSInteger)index indexPath:(NSIndexPath *)indexPath
{
    EPGoodsInfo *goodsInfo = self.modelArr[indexPath.row];
    
    switch (index) {
        case 0: // 商品上架
        {
            [EPTool addMBProgressWithView:self.view style:0];
            [EPTool showMBWithTitle:@""];
            [EPGoodsUpHttpRequest pushGoodsWithID:goodsInfo.goodsId type:@"3" InVC:self success:^(NSArray *modelArr) {
                [EPTool hiddenMBWithDelayTimeInterval:0];
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"上架成功!" count:0 doWhat:^{
                    [self getData];
                    
                }];
            } failure:^(NSError *error) {
                
                
            }];
        }
            break;
        case 1: // 商品删除
        {
               [GetData addAlertViewInView:self title:@"温馨提示" message:@"确定删除？" count:1 doWhat:^{
                   [EPTool addMBProgressWithView:self.view style:0];
                   [EPTool showMBWithTitle:@""];
                [EPGoodsUpHttpRequest pushGoodsWithID:goodsInfo.goodsId type:@"6" InVC:self success:^(NSArray *modelArr) {
                    [EPTool hiddenMBWithDelayTimeInterval:0];
                    [GetData addAlertViewInView:self title:@"温馨提示" message:@"删除成功!" count:0 doWhat:^{
                        [self getData];
                    }];
                } failure:^(NSError *error) {
                    
                }];
            }];
            
        }
            break;
            
        default:
            break;
    }
}


@end
