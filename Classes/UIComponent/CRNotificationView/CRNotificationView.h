//
//  CRNotificationView.h
//  和路通
//
//  Created by roger wu on 01/08/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LTNotificationViewComplete)(void);

@interface CRNotificationView : UIWindow

+ (instancetype)sharedInstance;

/**
 显示弹窗

 @param title 标题
 @param content 内容
 @param complete 回调
 */
- (void)showWithTitle:(NSString *)title content:(NSString *)content complete:(LTNotificationViewComplete)complete;

// 隐藏
- (void)dismiss;

@end
