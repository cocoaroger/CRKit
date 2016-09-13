//
//  UIButton+CRAdd.m
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "UIButton+CRAdd.h"
#import "UIImage+CRAdd.h"

static const CGFloat kHighlightedAlpha = 0.6f;

@implementation UIButton (CRAdd)

- (void)cr_setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    
    UIColor *highlightedColor = [color colorWithAlphaComponent:kHighlightedAlpha];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    [self setTitleColor:highlightedColor forState:UIControlStateDisabled];
}

- (void)cr_setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    
    UIImage *highlightedImage = [image cr_imageWithAlpha:kHighlightedAlpha];
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
    [self setImage:highlightedImage forState:UIControlStateDisabled];
}

- (void)cr_setBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
    UIImage *highlightedImage = [image cr_imageWithAlpha:kHighlightedAlpha];
    [self setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [self setBackgroundImage:highlightedImage forState:UIControlStateDisabled];
}

@end
