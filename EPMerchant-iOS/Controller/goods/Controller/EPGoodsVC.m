//
//  EPGoodsVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPGoodsVC.h"
#import "EPGoodCollectionViewCell.h"
#import "EPGoodsManageViewController.h"
#import "EPGoodsInfo.h"
#import "SYQrCodeScanne.h"
#import "EPScanResultVC.h"
#import "EPGoodsDetailVC1.h"
@interface EPGoodsVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation EPGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNav];
    [self configureCollectionView];
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
            
        }
        else
        {
            [self getAllGoodsData];
        }
    }];
    //self.navigationController.interactivePopGestureRecognizer.enabled=NO;
}
- (void)creatFileLoad{
    FileHander *hander = [FileHander shardFileHand];
    NSDictionary *responseObject =[hander readFile:@"goodData"];
                            [self loadData:responseObject];
}
- (void)getAllGoodsData{
    [self.dataArr removeAllObjects];
     NSString * str =[NSString stringWithFormat:@"%@/getAllGoodsData.json",EPUrl];
    NSDictionary * dict=@{@"userName":USERNAME,
                          @"loginTime":LOGINTIME,
                          @"type":@"0"};
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //CYLog(@"首页商品---%@",responseObject);
        FileHander *hander = [FileHander shardFileHand];
        NSString *sss=@"ss";
        [hander saveFile:responseObject withForName:@"goodData" withError:&sss];
        [self loadData:responseObject];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CYLog(@"%@",error);
    }];
}
- (void)loadData:(NSDictionary *)responseObject{
    NSArray * arr=responseObject[@"goodsArr"];
    for (NSDictionary * dic in arr) {
        EPGoodsInfo * model=[EPGoodsInfo mj_objectWithKeyValues:dic];
        [self.dataArr addObject:model];
    }
}
- (void)creatSearch{
    UIView * vc=[[UIView alloc]init];
    vc.frame=CGRectMake(0, 64, ScreenWidth, 40);
    vc.backgroundColor=[UIColor whiteColor];
    UIButton * searchBar =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBar.frame = CGRectMake(0, 0, ScreenWidth, 40);
    [searchBar setTitle:@"搜索商品" forState:UIControlStateNormal];
    [searchBar setImage:[UIImage imageNamed:@"magnifying-glass"] forState:UIControlStateNormal];
    [searchBar setTitleColor:ColorWithRGB(178, 178, 178, 1) forState:UIControlStateNormal];
    searchBar.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchBar setBackgroundColor:[UIColor whiteColor]];
    searchBar.layer.cornerRadius = 5;
    //[searchBar addTarget:self action:@selector(goSeachV:) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:searchBar];
    [self.view addSubview:vc];
    
}
// 配置collectionview
-(void)configureCollectionView
{
    // collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((ScreenWidth-30)/2, 300/2+20);// 每个item大小
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical; // 垂直滚动
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    //flowLayout.sectionFootersPinToVisibleBounds = YES;
    //flowLayout.sectionHeadersPinToVisibleBounds = YES;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-60-64) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = ColorWithRGB(237, 237, 237, 1);
    [collectionView registerNib:[UINib nibWithNibName:@"EPGoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"EPGoodCollectionViewCell"];
}
- (void)setNav{
    [self addNavigationBar:2 title:@"易 品"];
    [self addLeftItemWithFrame:CGRectZero textOrImage:0 action:@selector(searchBtnClick) name:@"-scan_code"];
    [self addRightItemWithFrame:CGRectZero textOrImage:0 action:@selector(sweepBtnClick) name:@"commodity_management"];
}
//左边按钮点击
- (void)searchBtnClick{
    SYQrCodeScanne *VC = [[SYQrCodeScanne alloc]init];
    VC.scanneScusseBlock = ^(SYCodeType codeType, NSString *url){
        if (SYCodeTypeUnknow == codeType) {
            [EPTool addMBProgressWithView:self.view style:0];
            [EPTool showMBWithTitle:@"无法识别的二维码"];
            [EPTool hiddenMBWithDelayTimeInterval:1];
        }else if (SYCodeTypeLink == codeType) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        }else{
            EPScanResultVC * vc =[[EPScanResultVC alloc] initWithResultStr:url];
            [self.navigationController pushViewController:vc animated:YES];        }
    };
    [VC scanning];
}
- (void)sweepBtnClick{
    EPGoodsManageViewController *manageVc = [[EPGoodsManageViewController alloc] init];
    [self.navigationController pushViewController:manageVc animated:YES];
}
#pragma mark - collection view delegate & datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EPGoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EPGoodCollectionViewCell" forIndexPath:indexPath];
    if (self.dataArr.count>0) {
        cell.model=[self.dataArr objectAtIndex:indexPath.item];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count>0) {
        EPGoodsInfo * model=[self.dataArr objectAtIndex:indexPath.item];
        EPGoodsDetailVC1 *RMVC = [[EPGoodsDetailVC1 alloc] init];
        RMVC.goodsId=model.goodsId;
        CYLog(@"ID===%@",model.goodsId);
        [self.navigationController pushViewController:RMVC animated:YES];

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
