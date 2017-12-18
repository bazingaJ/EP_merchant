//
//  EPGoodsReosityButton.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPGoodsReosityButtonView.h"

#define SWidth (ScreenWidth-30)/2
#define SHidth 35

@implementation EPGoodsReosityButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setButtonNames:(NSArray *)buttonNames
{
    _buttonNames = buttonNames;
    
    
    NSInteger count = buttonNames.count;
    
    for (int i = 0; i<count; i++) {
        
        NSString *btnName = [buttonNames[i] description];
        
        CGFloat bw=SWidth/count, bh=SHidth, bx=bw*i, by=0;
        
//        CYLog(@"%@",[self class]);
        
        // 按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn setFrame:CGRectMake(bx, by, bw, bh)];
        [btn setTitle:btnName forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        // 线
        if (i==count) return;
        CGFloat lx = bw, ly = by, lw = 1, lh = SHidth;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lx, ly, lw, lh)];
        [btn addSubview:line];
        line.backgroundColor = ColorWithRGB(217, 217, 217, 1);
        
    }
    
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    for (UIView *view in self.subviews) {
//        
//        CGFloat bw=SWidth/count, bh=SHidth, bx=bw*i, by=0;
//        
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *btn = (UIButton *)view;
//            
//            [btn setFrame:CGRectMake(bx, by, bw, bh)];
//        }
//        
//    }
//}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

-(void)clickBtn:(UIButton *)sender
{
    CYLog(@"click button--- %ld",sender.tag);
    if ([_delegate respondsToSelector:@selector(goodsReposityButtonClick:indexPath:)]) {
        [_delegate goodsReposityButtonClick:sender.tag indexPath:_indexPath];
    }
}

@end
