//
//  CYTabBarButton.m
//  CYQQ
//
//  Created by jeader on 16/5/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYTabBarButton.h"

#define SWidth self.bounds.size.width
#define SHeight self.bounds.size.height
#define TextLightColor ColorWithRGB(137, 139, 160, 1)
#define TextBlueColor ColorWithRGB(29, 32, 40, 1)

@interface CYTabBarButton ()

@property (nonatomic, weak) UIImageView *imageV;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UIButton *btn;

@end

@implementation CYTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _btn = btn;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        // 图片
        UIImageView *imageV = [[UIImageView alloc] init];
        [btn addSubview:imageV];
        _imageV = imageV;
        imageV.userInteractionEnabled = NO;
        
        // 名字
        UILabel *name = [[UILabel alloc] init];
        [btn addSubview:name];
        _nameLabel = name;
        name.font = [UIFont systemFontOfSize:12];
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = TextLightColor;
        
    }
    return self;
}

// 点击按钮调用
-(void)clickBtn:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(tabBarButtonClickIndex:)]) {
        [_delegate tabBarButtonClickIndex:_bar_tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_btn setFrame:self.bounds];
    
}

-(void)setName:(NSString *)name
{
    _name = name;
    
    _nameLabel.text = name;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    
    CGSize imageS = [image size];
    
    _imageV.image = image;
    _imageV.frame = CGRectMake((SWidth-imageS.width)/2, 8, imageS.width, imageS.height);
    
    _nameLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageV.frame)+3, SWidth, 18);
}
-(void)setSelectImage:(UIImage *)selectImage
{
    _selectImage = selectImage;
}
-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        _imageV.image = _selectImage;
        _nameLabel.textColor = TextBlueColor;
    }else{
        _imageV.image = _image;
        _nameLabel.textColor = TextLightColor;
    }
}
-(void)setBar_tag:(NSInteger)bar_tag
{
    _bar_tag = bar_tag;
}

@end
