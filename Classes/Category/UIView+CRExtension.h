//
//  UIView+CRExtension.h
//  CRKit
//
//  Created by roger wu on 09/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CRRetryButtonBlock)(void);

@interface UIView (CRExtension)

/**
 获取边缘返回手势对象
 */
- (UIScreenEdgePanGestureRecognizer *)cr_screenEdgePanGestureRecognizer;

/**
 *  显示没有数据的view
 */
- (void)cr_showNodataViewWithImage:(UIImage *)image
                              text:(NSString *)text
                  retryButtonTitle:(NSString *)retryButtonTitle
                  retryButtonBlock:(CRRetryButtonBlock)retryButtonBlock;

/**
 *  隐藏没有数据的view
 */
- (void)cr_hiddenNodataView;

/**
 平均分添加视图
 展示效果：|(padding)view(padding)view(padding)|
 @param views 子视图数组
 @param padding 内边距
 */
- (void)cr_makeEqualWidthViews:(NSArray *)views padding:(CGFloat)padding;

/**
 创建线背景色的视图
 */
+ (UIView *)cr_makeLineView;

/**
 *  添加模糊效果
 */
- (void)cr_addBlurEffect;

/**
 绘制垂直虚线
 
 @param lineView 需要绘制成虚线的view
 @param lineWidth 短线虚线的宽度
yua @param lineSpacing  虚线的间距
 @param lineColor 虚线的颜色
 */
+ (void)cr_drawVerticalDashLine:(UIView *)lineView
                      lineWidth:(CGFloat)lineWidth
                    lineSpacing:(CGFloat)lineSpacing
                      lineColor:(UIColor *)lineColor;

/**
 绘制水平虚线
 */
+ (void)cr_drawHorizontalDashLine:(UIView *)lineView
                        lineWidth:(CGFloat)lineWidth
                      lineSpacing:(CGFloat)lineSpacing
                        lineColor:(UIColor *)lineColor;

/**
 添加圆角

 @param corners 需要设置为圆角的角
 @param radius 需要设置的圆角大小
 */
- (void)cr_addCorners:(UIRectCorner)corners withRadius:(CGFloat)radius;
@end
