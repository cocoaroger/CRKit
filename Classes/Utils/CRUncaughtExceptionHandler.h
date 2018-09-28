//
//  CRUncaughtExceptionHandler.h
//  CRKit
//
//  Created by roger wu on 2016/10/12.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  崩溃处理
 */
@interface CRUncaughtExceptionHandler : NSObject

/**
 *  显示发送异常信息alert
 */
+ (void)showExceptionAlert;

@end

/**
 *  监听系统崩溃信息
 */
void InstallUncaughtExceptionHandler(void);
