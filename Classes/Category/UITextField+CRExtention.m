//
//  UITextField+CRExtention.m
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "UITextField+CRExtention.h"

@implementation UITextField (CRExtention)

- (void)cr_setPlaceholder:(NSString *)placeholder color:(UIColor *)color {
    NSDictionary *attributes = @{NSForegroundColorAttributeName: color};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    self.attributedPlaceholder = attributedString;
}

@end
