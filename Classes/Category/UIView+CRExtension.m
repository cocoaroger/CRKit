//
//  UIView+CRExtension.m
//  CRKit
//
//  Created by roger wu on 09/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "UIView+CRExtension.h"
#import "Masonry.h"
#import "CRMacro.h"
#import "UIButton+CRExtension.h"
#import "UIControl+YYAdd.h"
#import "NSString+CRExtention.h"

static const NSInteger kNodataViewTag = 10000;
static const CGFloat kNodataViewMaxW = 300.f;

@implementation UIView (CRExtension)

- (UIScreenEdgePanGestureRecognizer *)cr_screenEdgePanGestureRecognizer {
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.gestureRecognizers.count > 0) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
            if ([recognizer isKindOfClass: [UIScreenEdgePanGestureRecognizer class]]) {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}

- (void)cr_showNodataViewWithImage:(UIImage *)image
                              text:(NSString *)text
                  retryButtonTitle:(NSString *)retryButtonTitle
                  retryButtonBlock:(CRRetryButtonBlock)retryButtonBlock {
    
    UIView *nodataView = [[UIView alloc] init];
    nodataView.tag = kNodataViewTag;
    [self addSubview:nodataView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [nodataView addSubview:imageView];
    
    UIColor *textColor = rgb(153.f, 153.f, 153.f);
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:17.f];
    textLabel.textColor = textColor;
    textLabel.text = text;
    textLabel.numberOfLines = 0;
    [nodataView addSubview:textLabel];
    
    UIButton *retryButton = [UIButton new];
    retryButton.titleLabel.font = [UIFont systemFontOfSize:17];
    retryButton.layer.cornerRadius = 4;
    retryButton.layer.borderWidth = 1;
    retryButton.layer.borderColor = textColor.CGColor;
    [retryButton setTitle:retryButtonTitle forState:UIControlStateNormal];
    [retryButton cr_setTitleColor:textColor];
    [nodataView addSubview:retryButton];
    [retryButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (retryButtonBlock) {
            retryButtonBlock();
        }
    }];
    
    [nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kNodataViewMaxW);
        make.top.equalTo(imageView.mas_top);
        make.bottom.equalTo(retryButton.mas_bottom);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nodataView.mas_top);
        make.centerX.equalTo(nodataView.mas_centerX);
    }];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(40);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    [retryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.top.equalTo(textLabel.mas_bottom).offset(40);
        make.bottom.equalTo(nodataView.mas_bottom);
        make.centerX.equalTo(nodataView.mas_centerX);;
    }];
    
    retryButton.hidden = ![retryButtonTitle cr_hasValue];
}

- (void)cr_hiddenNodataView {
    UIView *nodataView = [self viewWithTag:kNodataViewTag];
    if (nodataView) {
        [nodataView removeFromSuperview];
    }
}

- (void)cr_makeEqualWidthViews:(NSArray *)views padding:(CGFloat)padding {
    UIView *lastView;
    for (UIView *view in views) {
        [self addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(lastView.mas_right).offset(padding);
                make.width.equalTo(lastView);
            }];
        } else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(padding);
                make.top.bottom.equalTo(self);
            }];
        }
        lastView = view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
    }];
}

+ (UIView *)cr_makeLineView {
    UIView *view = [UIView new];
    view.backgroundColor = kSeparatorLineColor;
    return view;
}

- (void)cr_addBlurEffect {
    // 模糊
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self addSubview:blurView];
    
    __weak __typeof(&*self) weakSelf = self;
    [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

+ (void)cr_drawVerticalDashLine:(UIView *)lineView lineWidth:(CGFloat)lineWidth lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineWidth], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,0, CGRectGetHeight(lineView.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

+ (void)cr_drawHorizontalDashLine:(UIView *)lineView lineWidth:(CGFloat)lineWidth lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineWidth], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)cr_addCorners:(UIRectCorner)corners withRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.frame = self.bounds;
    shape.path = path.CGPath;
    self.layer.mask = shape;
}

@end
