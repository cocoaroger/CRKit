//
//  UITextField+CRExtension.m
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "UITextField+CRExtension.h"

@implementation UITextField (CRExtension)

- (void)cr_setPlaceholder:(NSString *)placeholder color:(UIColor *)color {
    NSDictionary *attributes = @{NSForegroundColorAttributeName: color};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    self.attributedPlaceholder = attributedString;
}

@end
