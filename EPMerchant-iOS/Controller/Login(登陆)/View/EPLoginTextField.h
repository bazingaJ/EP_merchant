//
//  EPLoginTextField.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/30.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TextFont [UIFont systemFontOfSize:14]

@interface EPLoginTextField : UIView

@property (nonatomic, weak) UITextField *textField;
/**
 *  图片名称
 */
@property (nonatomic, copy) NSString *imageName;
/**
 *  返回的textfield上输入的文字
 */
@property (nonatomic, copy) NSString *textFieldText;
/**
 *  占位符
 */
@property (nonatomic, copy) NSString *placeHolder;

@end
