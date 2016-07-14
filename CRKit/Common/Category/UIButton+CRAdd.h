//
//  UIButton+CRAdd.h
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CRAdd)

/**
 *  设置按钮title的普通状态颜色，同时将hilight和disabled设置为该颜色的半透明颜色
 *
 *  @param color 标题颜色
 */
- (void)cr_setTitleColor:(UIColor *)color;

/**
 *  设置普通状态的图片，自动生成其他状态的透明图片
 *
 *  @param image 普通状态的图片
 */
- (void)cr_setImage:(UIImage *)image;

/**
 *  设置普通状态的背景图片，自动生成其他状态的透明图片
 *
 *  @param image 普通状态的背景图片
 */
- (void)cr_setBackgroundImage:(UIImage *)image;

@end
