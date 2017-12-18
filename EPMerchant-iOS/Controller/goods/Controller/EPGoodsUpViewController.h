//
//  EPGoodsUpViewController.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPGoodsUpViewController : UIViewController
/**
 *  修改商品名称textfield
 */
@property (weak, nonatomic) IBOutlet UITextField *goodsNameTextField;
/**
 *  修改商品价格textfield
 */
@property (weak, nonatomic) IBOutlet UITextField *goodsPriceTextField;
/**
 *  商品图片按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *goodsIconButton;
/**
 *  提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end
