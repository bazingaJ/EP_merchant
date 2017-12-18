//
//  EPToCameraVc.h
//  EPMerchant-iOS
//
//  Created by jeader on 16/7/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPToCameraVc : NSObject

+(UIImagePickerController *)presentToCarmeaViewInVC:(UIViewController *)Vc;

+(UIImagePickerController *)presentToPhotoShopsVC:(UIViewController *)Vc;

/**
 *  压缩图片
 */
+ (UIImage *)imageWithImageSimple:(UIImage *)image;

@end
