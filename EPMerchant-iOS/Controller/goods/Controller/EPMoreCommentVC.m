//
//  EPMoreCommentVC.m
//  EPin-IOS
//
//  Created by jeaderL on 16/5/9.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import "EPMoreCommentVC.h"
#import "EPDetailModel.h"
#import "EPDetailCell.h"
@interface EPMoreCommentVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tb;

@end

@implementation EPMoreCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString * title=[NSString stringWithFormat:@"评价(%ld)",self.commentArr.count];
    [self addNavigationBar:0 title:title];
    [self tb];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tb reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EPDetailCell * cell5=[tableView dequeueReusableCellWithIdentifier:@"EPDetailCell"];
    cell5.selectionStyle=UITableViewCellSelectionStyleNone;
    EPGetCommentModel * model=[self.commentArr objectAtIndex:indexPath.row];
    cell5.model=model;
    return cell5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableView *)tb{
    if (!_tb) {
        _tb=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tb.delegate=self;
        _tb.dataSource=self;
        _tb.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tb.backgroundColor=ColorWithRGB(234, 234, 234, 1);
        //注册cell
        [_tb registerNib:[UINib nibWithNibName:@"EPDetailCell" bundle:nil] forCellReuseIdentifier:@"EPDetailCell"];
        [self.view addSubview:_tb];
    }
    return _tb;
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
