//
//  EPGoodsReposityCell.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPGoodsReposityCell.h"

#import "EPGoodsReosityButtonView.h"

#define SWidth self.bounds.size.width
#define SHidth self.bounds.size.height

@interface EPGoodsReposityCell ()

/**
 *  线
 */
@property (nonatomic, weak) UILabel *line;

@end

@implementation EPGoodsReposityCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];

    }
    return self;
}

-(void)setUpAllChildViews
{
    // 图片
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    [self addSubview:goodsImageView];
    _goodsImageView = goodsImageView;
    goodsImageView.image = [UIImage imageNamed:@"nouse0"];
    
    // 名字
    UILabel *name = [[UILabel alloc] init];
    [self addSubview:name];
    _nameLabel = name;
    name.numberOfLines = 0;
    name.font = [UIFont systemFontOfSize:14];
    name.text = @"仙道寿司8折";
    
    // 价格
    UILabel *priceLabel = [[UILabel alloc] init];
    [self addSubview:priceLabel];
    _priceLabel = priceLabel;
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.text = @"¥322";
    priceLabel.textAlignment = NSTextAlignmentRight;
    
    // 线
    UILabel *line = [[UILabel alloc] init];
    [self addSubview:line];
    _line = line;
    line.backgroundColor = ColorWithRGB(217, 217, 217, 1);
    
    // 三个按钮shitu
    EPGoodsReosityButtonView *btnView = [[EPGoodsReosityButtonView alloc] init];
    [self addSubview:btnView];
    btnView.buttonNames = @[@"上架",@"删除"];
    _btnView = btnView;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    // 图片
    CGFloat ix = 0, iy = 0, iw = SWidth, ih = SWidth*8/10, margin = 8;
    _goodsImageView.frame = CGRectMake(ix, iy, iw, ih);
    
    // 名字 12
    CGFloat nx = margin, ny = CGRectGetMaxY(_goodsImageView.frame), nw = SWidth*3/5, nh = 25;
    _nameLabel.frame = CGRectMake(nx, ny, nw, nh);
    
    // 价格
    CGFloat py = ny, pw = SWidth-nw-nx-8, px = SWidth - pw - 8, ph = nh;
    _priceLabel.frame = CGRectMake(px, py, pw, ph);
    
    // 线
    CGFloat lx = 0 , ly = CGRectGetMaxY(_nameLabel.frame), lw = SWidth, lh = 1;
    _line.frame = CGRectMake(lx, ly, lw, lh);
    
    // 按钮视图
//    CGFloat bx = 0 , by = CGRectGetMaxY(_nameLabel.frame)+50, bw = SWidth, bh = 35;
    _btnView.frame = CGRectMake(0, CGRectGetMaxY(_nameLabel.frame)+1, SWidth, 25);
    
//    CYLog(@"%f",SWidth);
    
}

@end
