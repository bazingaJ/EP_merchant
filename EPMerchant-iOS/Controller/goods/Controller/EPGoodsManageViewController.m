//
//  EPGoodsManageViewController.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//  商品管理界面（上架申请、商品仓库）

#import "EPGoodsManageViewController.h"

@interface EPGoodsManageViewController ()
{
    NSArray *sections;
    NSArray *images;
    NSArray *classes;
}
@end

@implementation EPGoodsManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 初始化tableview的数据数组
    sections = @[@[@"上架申请"],@[@"商品仓库"]];
    images = @[@[@"ItemUpshelf."],@[@"shop_-warehouse"]];
    classes = @[@[@"EPGoodsUpViewController"],@[@"EPGoodsReposityViewController"]];
    
    [self addTableView];
}

- (void)addTableView
{
    [self addNavigationBar:0 title:@"商品管理"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [sections[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"GoodsManagecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = 0;
    }
    // Configure the cell...
    
    NSString *rowText = [sections[indexPath.section][indexPath.row] description];
    UIImage *rowImage = [UIImage imageNamed:[images[indexPath.section][indexPath.row] description]];
    
    cell.imageView.image = rowImage;
    cell.textLabel.text = rowText;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cls = NSClassFromString([classes[indexPath.section][indexPath.row] description]);
    UIViewController *Vc = [(UIViewController *)[cls alloc] init];
    [self.navigationController pushViewController:Vc animated:YES];
    
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
