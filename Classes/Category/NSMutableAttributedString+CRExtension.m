//
//  NSMutableAttributedString+CRExtension.m
//  CRKit
//
//  Created by roger wu on 01/09/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "NSMutableAttributedString+CRExtension.h"
#import "YYCategories.h"

@implementation NSMutableAttributedString (CRExtension)

- (void)cr_setLineSpace:(CGFloat)lineSpace {
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineSpacing = lineSpace;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:self.string.rangeOfAll];
}

@end
