//
//  EPDetailCell.h
//  EPin-IOS
//
//  Created by jeaderL on 16/4/4.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPGetCommentModel;
@interface EPDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property(nonatomic,strong)EPGetCommentModel * model;

@end
