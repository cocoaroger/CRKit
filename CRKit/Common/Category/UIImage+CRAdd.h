//
//  UIImage+CRAdd.h
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CRAdd)

/**
 *  创建与该图片相同的带有透明度的图片
 *
 *  @param alpha 透明值 0-1
 *
 *  @return 新图片
 */
- (instancetype)cr_imageWithAlpha:(CGFloat)alpha;

@end
