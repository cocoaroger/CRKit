//
//  UIImageView+CRAdd.m
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "UIImageView+CRAdd.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (CRAdd)

- (void)cr_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    __weak __typeof(&*self) weakSelf = self;
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:SDWebImageRetryFailed|SDWebImageAvoidAutoSetImage
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       weakSelf.image = image;
                       weakSelf.alpha = 0.5f;
                       [UIView animateWithDuration:0.2f animations:^{
                           weakSelf.alpha = 1.f;
                       }];
    }];
}

@end