//
//  UITextField+CRExtension.h
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CRExtension)

/**
 *  设置带默认的占位文字和颜色
 */
- (void)cr_setPlaceholder:(NSString *)placeholder color:(UIColor *)color;

@end
