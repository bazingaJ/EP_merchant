//
//  EPSequView.m
//  EPSequeue
//
//  Created by jeader on 16/7/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPSequView.h"
#define squenTag 900
@interface EPSequView ()

@property (nonatomic, assign) CGFloat height11;

@end

@implementation EPSequView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setCount:(NSInteger)count
{
    _count = count;
    
    for (int i = 0; i < count; i++) {
        
        CGFloat x = 0, y = i*45, w = self.bounds.size.width, h = 30;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        backView.tag=800;
        [self addSubview:backView];
        backView.backgroundColor = [UIColor colorWithRed:231/255.0 green:232/255.0 blue:233/255.0 alpha:1];
        backView.layer.cornerRadius = 15;
        
        
        self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(8, 0, w-16, h)];
        self.textfield.borderStyle = UITextBorderStyleNone;
        self.textfield.tag=squenTag+i;
        CYLog(@"tag===%ld",self.textfield.tag);
        self.textfield.textAlignment=NSTextAlignmentCenter;
        [backView addSubview:self.textfield];
        
    }
    
}

-(CGFloat)height
{
    return _count*45;
}


@end
