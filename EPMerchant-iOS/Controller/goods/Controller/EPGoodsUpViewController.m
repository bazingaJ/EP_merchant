//
//  EPGoodsUpViewController.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/6/25.
//  Copyright © 2016年 jeader. All rights reserved.
//  上架申请

#import "EPGoodsUpViewController.h"

#import "EPUpApplyHttpRequest.h"
#import "EPToCameraVc.h"

@interface EPGoodsUpViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage *image;

@end

@implementation EPGoodsUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addNavigationBar:0 title:@"上架申请"];
    
}
// 点击商品图片
- (IBAction)goodsPicture:(id)sender {
    
    CYLog(@"click goods picture");
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"请选择添加照片方式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [EPToCameraVc presentToCarmeaViewInVC:self];
        picker.delegate = self;
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [EPToCameraVc presentToPhotoShopsVC:self];
        picker.delegate = self;
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    
    
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //将图片存入系统相册中
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _image = [EPToCameraVc imageWithImageSimple:image];
    
    [_goodsIconButton setBackgroundImage:_image forState:UIControlStateNormal];
    
}

// 点击提交
- (IBAction)commit:(id)sender {
    
    NSString *str = @"";
    
    if (_goodsNameTextField.text.length==0) { // 没有商品名称
        str = @"请输入商品名称";
    }else if (_goodsPriceTextField.text.length==0) { // 没有商品价格
        str = @"请输入商品价格";
    }else if (_image == nil) { // 没有图片
        str = @"请添加商品图片";
    }else {
        
        str = nil;
        
       // CYLog(@"%@--%@--%@",_goodsPriceTextField.text,_goodsNameTextField.text,_image);
        [EPTool addMBProgressWithView:self.view  style:0];
        [EPTool showMBWithTitle:@"提交中..."];
        [EPUpApplyHttpRequest pushGoodsInfoApplyWithName:_goodsNameTextField.text Price:_goodsPriceTextField.text Images:@[_image] InVC:self success:^{
            [EPTool hiddenMBWithDelayTimeInterval:0];
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"您已成功申请上架此商品，请耐心等待处理..." count:0 doWhat:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        } failure:^(NSError *error) {
            CYLog(@"%@",error);
        }];
    }
    
    if ([str length]) {
        [GetData addAlertViewInView:self title:@"温馨提示" message:str count:0 doWhat:nil];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
