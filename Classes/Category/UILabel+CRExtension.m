//
//  UILabel+CRExtension.m
//  CRKit
//
//  Created by roger wu on 18/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "UILabel+CRExtension.h"

@implementation UILabel (CRExtension)

- (void)copyStyle:(UILabel *)label {
    self.font = label.font;
    self.textColor = label.textColor;
    self.textAlignment = label.textAlignment;
    self.numberOfLines = label.numberOfLines;
}

- (CGFloat)attributeTextHeightWithWidth:(CGFloat)width {
    UILabel *tempLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, width, CGFLOAT_MAX)];
    tempLabel.attributedText = self.attributedText;
    tempLabel.numberOfLines = 0;
    [tempLabel sizeToFit];
    return tempLabel.frame.size.height;
}

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    UILabel *label = [UILabel new];
    label.font = font;
    label.textColor = textColor;
    return label;
}
@end
