//
//  UILabel+CRExtension.h
//  和路通
//
//  Created by roger wu on 18/07/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CRExtension)

/**
 复制样式

 @param label 被复制Label
 */
- (void)copyStyle:(UILabel *)label;

/**
 富文本高度

 @param width 限定宽度
 @return 高度
 */
- (CGFloat)attributeTextHeightWithWidth:(CGFloat)width;

/**
 创建label

 @param font 字体
 @param textColor 颜色
 @return 实例
 */
+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;

@end
