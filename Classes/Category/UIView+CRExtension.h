//
//  UIView+CRExtension.h
//  CRKit
//
//  Created by roger wu on 09/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CRRetryButtonBlock)();

@interface UIView (CRExtension)

/**
 *  显示没有数据的view
 */
- (void)cr_showNodataViewWithImage:(UIImage *)image
                              text:(NSString *)text
                  retryButtonTitle:(NSString *)retryButtonTitle
                  retryButtonBlock:(CRRetryButtonBlock)retryButtonBlock;

/**
 *  隐藏没有数据的view
 */
- (void)cr_hiddenNodataView;

@end
