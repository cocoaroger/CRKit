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
#import "UIButton+CRExtention.h"
#import "UIControl+YYAdd.h"

static const NSInteger kNodataViewTag = 10000;
static const CGFloat kNodataViewMaxW = 300.f;

@implementation UIView (CRExtension)

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
}

- (void)cr_hiddenNodataView {
    UIView *nodataView = [self viewWithTag:kNodataViewTag];
    if (nodataView) {
        [nodataView removeFromSuperview];
    }
}

@end
