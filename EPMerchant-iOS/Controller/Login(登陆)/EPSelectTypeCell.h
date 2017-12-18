//
//  EPSelectTypeCell.h
//  EPin-IOS
//
//  Created by jeaderL on 16/4/8.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPSelectTypeCell : UITableViewCell

/**选择类型*/
@property (weak, nonatomic) IBOutlet UILabel *selectLb;
/**待选中的圆圈*/
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
