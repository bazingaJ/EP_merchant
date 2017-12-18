//
//  EPToCameraVc.m
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "EPToCameraVc.h"

@implementation EPToCameraVc

+(UIImagePickerController *)presentToCarmeaViewInVC:(UIViewController *)Vc
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if (TARGET_IPHONE_SIMULATOR) {
        //            NSLog(@"模拟器");
        
        
        
    }else if(TARGET_OS_IPHONE){
        //            NSLog(@"真机");
        
        //    打开摄像头
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            
            //            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            //            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            //                NSLog(@"overlayView----%@",picker.cameraOverlayView.subviews);
//            picker.cameraOverlayView.hidden = YES;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [Vc presentViewController:picker animated:YES completion:nil];
            });
            
            
        }else{
            
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"你没有摄像头" count:0 doWhat:^{
                
            }];
        }
    }
    
    return picker;
    
}

+(UIImagePickerController *)presentToPhotoShopsVC:(UIViewController *)Vc
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //            picker.delegate = self;//设置代理
        picker.editing = YES;//是否为可编辑状态
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//选择获取图片的途径
        dispatch_async(dispatch_get_main_queue(), ^{
            [Vc presentViewController:picker animated:YES completion:^{
                
            }];
        });
        
    }
    
    return picker;
}

/**
 *  压缩图片
 *
 *  @param image   要压缩的图片
 *  @param newSize 要压缩到多大
 *
 *  @return 压缩好的图片
 */
+ (UIImage *)imageWithImageSimple:(UIImage *)image

{
    // 原图片的大小
    CGSize oldSize = [image size];
    
    // 原图片的高宽比例
    CGFloat scale = oldSize.height/oldSize.width;
    
    // 新图片的大小
    CGSize newSize = CGSizeMake(ScreenWidth, ScreenWidth*scale);
    
    // Create a graphics image context
    
    UIGraphicsBeginImageContext (newSize);
    
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    
    [image drawInRect : CGRectMake ( 0 , 0 ,newSize. width ,newSize. height )];
    
    // Get the new image from the context
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    // End the context
    
    UIGraphicsEndImageContext ();
    
    // Return the new image.
    
    return newImage;
    
}

@end
