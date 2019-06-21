//
//  NSMutableAttributedString+CRExtension.h
//  CRKit
//
//  Created by roger wu on 01/09/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (CRExtension)

/**
 设置行高
 
 @param lineSpace 行高
 */
- (void)cr_setLineSpace:(CGFloat)lineSpace;

/**
 计算高度
 */
- (CGFloat)cr_heightWithWidth:(CGFloat)width;
@end
