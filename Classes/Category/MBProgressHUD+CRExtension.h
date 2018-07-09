//
//  MBProgressHUD+CRExtension.h
//  CRKit
//
//  Created by roger wu on 09/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (CRExtension)

/**
 *  显示一句话提醒
 *
 *  @param text 文本
 *
 *  @return hud
 */
+ (instancetype)cr_showToastWithView:(UIView *)view text:(NSString *)text;

/**
 *  加载动画
 */
+ (instancetype)cr_showLoadinWithView:(UIView *)view text:(NSString *)text;

/**
 *  隐藏view上的HUD
 */
+ (void)cr_hideHUDForView:(UIView *)view;

/**
 *  隐藏动画
 */
- (void)cr_hide;

@end
