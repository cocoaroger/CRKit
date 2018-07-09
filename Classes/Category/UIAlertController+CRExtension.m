//
//  UIAlertController+CRExtension.m
//  SCSupplier
//
//  Created by roger wu on 2016/11/18.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import "UIAlertController+CRExtension.h"
#import "UIAlertController+Blocks.h"
#import "UIApplication+YYAdd.h"

@implementation UIAlertController (CRExtension)


+ (instancetype)cr_showWithController:(UIViewController *)controller
                          submitTitle:(NSString *)submitTitle
                                title:(NSString *)title
                              message:(NSString *)message {
    
    return [UIAlertController showAlertInViewController:controller
                                              withTitle:title
                                                message:message
                                      cancelButtonTitle:submitTitle
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:nil
                                               tapBlock:nil];
}

+ (instancetype)alertWithMessage:(NSString *)message controller:(UIViewController *)controller {
    return [UIAlertController showAlertInViewController:controller
                                              withTitle:@"提示"
                                                message:message
                                      cancelButtonTitle:@"取消"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@[@"去设置"]
                                               tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                   if (buttonIndex == 2) {
                                                       NSURL *locationURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                       [[UIApplication sharedApplication] openURL:locationURL];
                                                   }
                                               }];
}

+ (instancetype)cr_showLocationFailedWithController:(UIViewController *)controller {
    NSString *appBundleName = [UIApplication sharedApplication].appBundleName;
    NSString *noLocationDesp = [NSString stringWithFormat:@"定位失败，请到『设置』-『%@』-『位置』开启定位功能，开启后您才可以使用定位功能", appBundleName];
    return [UIAlertController alertWithMessage:noLocationDesp controller:controller];
}

+ (instancetype)cr_showPhotoFailedWithController:(UIViewController *)controller {
    NSString *appBundleName = [UIApplication sharedApplication].appBundleName;
    NSString *noLocationDesp = [NSString stringWithFormat:@"访问相册失败，请到『设置』-『%@』-『照片』开启照片功能，开启后您才可以使用照片功能", appBundleName];
    return [UIAlertController alertWithMessage:noLocationDesp controller:controller];
}

+ (instancetype)cr_showCameraFailedWithController:(UIViewController *)controller {
    NSString *appBundleName = [UIApplication sharedApplication].appBundleName;
    NSString *noLocationDesp = [NSString stringWithFormat:@"访问相机失败，请到『设置』-『%@』-『相机』开启相机功能，开启后您才可以使用相机功能", appBundleName];
    return [UIAlertController alertWithMessage:noLocationDesp controller:controller];
}

@end
