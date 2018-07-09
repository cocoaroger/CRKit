//
//  MBProgressHUD+CRExtension.m
//  CRKit
//
//  Created by roger wu on 09/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "MBProgressHUD+CRExtension.h"

static const CGFloat kShowTime = 1.25f;
static const CGFloat kLabelFont = 16.f;

@implementation MBProgressHUD (CRExtension)

+ (instancetype)cr_showToastWithView:(UIView *)view text:(NSString *)text {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud hideAnimated:YES afterDelay:kShowTime];
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.font = [UIFont boldSystemFontOfSize:kLabelFont];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.9f];
    hud.minSize = CGSizeMake(100.f, 40.f);
    hud.margin = 10.f;
    
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    return hud;
}

+ (instancetype)cr_showLoadinWithView:(UIView *)view text:(NSString *)text {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    hud.label.font = [UIFont boldSystemFontOfSize:kLabelFont];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.9f];
    hud.margin = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    
    
    return hud;
}

+ (void)cr_hideHUDForView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}

- (void)cr_hide {
    [self hideAnimated:YES];
}

@end
