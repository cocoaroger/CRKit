//
//  CRWebViewController.h
//  TestWebView
//
//  Created by cocoaroger on 16/8/18.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBaseController.h"
#import "CRNavigationController.h"

/**
 *  自定义的带有关闭和返回按钮
 *  最好以navigationController承载
 */
@interface CRWebViewController : CRBaseController

- (instancetype)initWithTitle:(NSString *)title URL:(NSString *)URL;

+ (CRNavigationController *)webControllerWithTitle:(NSString *)title URL:(NSString *)URL;

@end
