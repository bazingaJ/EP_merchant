//
//  EPSequenceNumVC.m
//  EPMerchant-iOS
//
//  Created by jeaderL on 16/6/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPSequenceNumVC.h"
#import "EPSequenceNumResultVC.h"
#import "EPSHistoryViewController.h"
@interface EPSequenceNumVC ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton * addBtn;
@property(nonatomic,strong)UIButton * searchBtn;
@property(nonatomic,assign)CGFloat maxY;
@property(nonatomic,strong)UILabel * tanchu;

@end

@implementation EPSequenceNumVC
{
    int _i;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _i=0;
    [self addNavigationBar:0 title:@"序列号"];
    UILabel * lb=[[UILabel alloc]init];
    lb.frame=CGRectMake(0, 120, ScreenWidth, 20);
    lb.font=[UIFont systemFontOfSize:18];
    lb.textAlignment=NSTextAlignmentCenter;
    lb.text=@"请输入序列号";
    [self.view addSubview:lb];
    CGFloat maxY=CGRectGetMaxY(lb.frame);
    UITextField * tf=[[UITextField alloc]init];
    tf.frame=CGRectMake(35,maxY+15 , ScreenWidth-70,30);
    tf.keyboardType=UIKeyboardTypeNumberPad;
    tf.layer.masksToBounds=YES;
    tf.layer.cornerRadius=20;
    tf.tag=900;
    tf.backgroundColor=ColorWithRGB(237, 237, 237, 1);
    tf.textAlignment=NSTextAlignmentCenter;
    tf.clearButtonMode=UITextFieldViewModeWhileEditing;
    tf.delegate=self;
    [self.view addSubview:tf];
    _maxY=CGRectGetMaxY(tf.frame);
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(35,maxY+15+30+10, ScreenWidth-70, 30);
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=20;
    btn.layer.borderWidth=1;
    btn.layer.borderColor=[ColorWithRGB(237, 237, 237, 1) CGColor];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn setTitleColor:ColorWithRGB(116, 115, 115, 1) forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:20];
    [btn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    _addBtn=btn;
    UIButton * searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:searchBtn];
    CGFloat spaceJiaY=CGRectGetMaxY(btn.frame);
    searchBtn.frame=CGRectMake((ScreenWidth-151)/2, spaceJiaY+10, 151, 50);
    [searchBtn setTitle:@"查 询" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor=ColorWithRGB(0, 162, 255, 1);
    searchBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    searchBtn.layer.masksToBounds=YES;
    searchBtn.layer.cornerRadius=25;
    [searchBtn addTarget:self action:@selector(lookVcodeDetail) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn=searchBtn;
}
- (void)addBtnClick:(UIButton *)btn{
    _i++;
    if (_i<5) {
        _addBtn.y=_maxY+50;
        _searchBtn.y=_addBtn.y+40;
        _maxY=_addBtn.y-10;
        UITextField * tf=[[UITextField alloc]init];
        tf.frame=CGRectMake(35,_maxY-30, ScreenWidth-70, 30);
        tf.clearButtonMode=UITextFieldViewModeWhileEditing;
        tf.layer.masksToBounds=YES;
        tf.layer.cornerRadius=20;
        tf.tag=901+_i;
        tf.backgroundColor=ColorWithRGB(237, 237, 237, 1);
        tf.textAlignment=NSTextAlignmentCenter;
        tf.keyboardType=UIKeyboardTypeNumberPad;
        tf.delegate=self;
        [self.view addSubview:tf];
    }else{
        [EPTool addAlertViewInView:self title:@"温馨提示" message:@"最多只能添加五个序列号" count:0 doWhat:nil];
    }
   
}
- (void)lookVcodeDetail{
    CYLog(@"i==%d",_i);
    NSString * str=[[NSString alloc]init];
    if (_i==0) {
        UITextField * tf=[self.view viewWithTag:900];
        //CYLog(@"tf===%@",tf.text);
        str=tf.text;
    }
    if (_i==1) {
        UITextField * tf=[self.view viewWithTag:900];
        UITextField * tf1=[self.view viewWithTag:902];
        //CYLog(@"tf===%@---%@",tf.text,tf1.text);
        if (tf.text.length==0&&tf1.text.length==0) {
             CYLog(@"无查询");
        }else if (tf.text.length==0){
            str=tf1.text;
        }else if (tf1.text.length==0){
            str=tf.text;
        }else{
            str=[NSString stringWithFormat:@"%@,%@",tf.text,tf1.text];
        }
     }
    if (_i==2) {
        UITextField * tf=[self.view viewWithTag:900];
        UITextField * tf1=[self.view viewWithTag:902];
        UITextField * tf2=[self.view viewWithTag:903];
        [str stringByAppendingFormat:@"%@,%@,%@",tf.text,tf1.text,tf2.text];
         //CYLog(@"tf===%@---%@---%@",tf.text,tf1.text,tf2.text);
        if (tf.text.length==0&&tf1.text.length==0&&tf2.text.length==0) {
            CYLog(@"无查询");
        }else{
            str=[NSString stringWithFormat:@"%@,%@,%@",tf.text,tf1.text,tf2.text];
            if (tf.text.length==0) {
                if (tf1.text.length==0) {
                    str=tf2.text;
                }else{
                    if (tf2.text.length==0) {
                        str=tf1.text;
                    }else{
                        str=[NSString stringWithFormat:@"%@,%@",tf1.text,tf2.text];
                    }
                }
            }else{
                //tf不为空
                if (tf1.text.length==0) {
                    if (tf2.text.length==0) {
                        str=tf.text;
                    }else{
                        str=[NSString stringWithFormat:@"%@,%@",tf.text,tf2.text];
                    }
                }else{
                    //tf1不为空
                    if (tf2.text.length==0) {
                        [NSString stringWithFormat:@"%@,%@",tf.text,tf1.text];
                    }else{
                        str=[NSString stringWithFormat:@"%@,%@,%@",tf.text,tf1.text,tf2.text];
                    }
                }
            }
        }
    }
    if (_i==3) {
        UITextField * tf=[self.view viewWithTag:900];
        UITextField * tf1=[self.view viewWithTag:902];
        UITextField * tf2=[self.view viewWithTag:903];
        UITextField * tf3=[self.view viewWithTag:904];
        //CYLog(@"tf===%@---%@---%@---%@",tf.text,tf1.text,tf2.text,tf3.text);
        if (tf.text.length==0&&tf1.text.length==0&&tf2.text.length==0&&tf3.text.length==0) {
            CYLog(@"无查询");
        }else{
            str=[NSString stringWithFormat:@"%@,%@,%@,%@",tf.text,tf1.text,tf2.text,tf3.text];
        }
     }
    if (_i==4) {
        UITextField * tf=[self.view viewWithTag:900];
        UITextField * tf1=[self.view viewWithTag:902];
        UITextField * tf2=[self.view viewWithTag:903];
        UITextField * tf3=[self.view viewWithTag:904];
        UITextField * tf4=[self.view viewWithTag:905];
        //CYLog(@"tf===%@---%@---%@---%@----%@",tf.text,tf1.text,tf2.text,tf3.text,tf4.text);
        if (tf.text.length==0&&tf1.text.length==0&&tf2.text.length==0&&tf3.text.length==0&&tf4.text.length==0) {
            CYLog(@"无查询");
        }else{
            str=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",tf.text,tf1.text,tf2.text,tf3.text,tf4.text];
        }
    }
    if (_i==5) {
        UITextField * tf=[self.view viewWithTag:900];
        UITextField * tf1=[self.view viewWithTag:902];
        UITextField * tf2=[self.view viewWithTag:903];
        UITextField * tf3=[self.view viewWithTag:904];
        UITextField * tf4=[self.view viewWithTag:905];
        //CYLog(@"tf===%@---%@---%@---%@----%@",tf.text,tf1.text,tf2.text,tf3.text,tf4.text);
        if (tf.text.length==0&&tf1.text.length==0&&tf2.text.length==0&&tf3.text.length==0&&tf4.text.length==0) {
            CYLog(@"无查询");
        }else{
            str=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",tf.text,tf1.text,tf2.text,tf3.text,tf4.text];
        }
    }
    CYLog(@"str==%@",str);
    GetData * data=[GetData new];
    [data getVcodesInfoWithType:@"0" withVcodes:str withVcode:nil withCompletionBlock:^(NSDictionary *dict, NSString *returnCode, NSString *msg) {
        if ([returnCode intValue]==0) {
            CYLog(@"查询结果----%@",dict);
            EPSequenceNumResultVC * vc=[[EPSequenceNumResultVC alloc]init];
            vc.dataDict=dict;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([returnCode intValue]==1){
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:nil];
        }else if ([returnCode intValue]==2){
            [EPTool publicDeleteInfo];
            [EPTool addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                [EPTool otherLogin];
            }];
        }else{
            [EPTool addAlertViewInView:self title:@"温馨提示" message:@"由于网络问题，查询失败，请稍后重试" count:0 doWhat:nil];
        }
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        NSInteger loc =range.location;
        if (loc < 16)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    return YES;
}
@end
