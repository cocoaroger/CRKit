//
//  UIAlertController+CRExtension.h
//  CRKit
//
//  Created by roger wu on 2016/11/18.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (CRExtension)

/**
 *  简单的提示性弹窗
 */
+ (instancetype)cr_showWithController:(UIViewController *)controller
                          submitTitle:(NSString *)submitTitle
                                title:(NSString *)title
                              message:(NSString *)message;

/**
 *  定位失败，弹窗
 */
+ (instancetype)cr_showLocationFailedWithController:(UIViewController *)controller;

/**
 *  没有相册权限
 */
+ (instancetype)cr_showPhotoFailedWithController:(UIViewController *)controller;

/**
 *  没有相机权限
 */
+ (instancetype)cr_showCameraFailedWithController:(UIViewController *)controller;
@end
