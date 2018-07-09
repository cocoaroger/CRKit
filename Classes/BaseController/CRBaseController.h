//
//  CRBaseController.h
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CRStatusBarStyle) {
    CRStatusBarStyleLightContent = 0,
    CRStatusBarStyleDark,
};

@interface CRBaseController : UIViewController

@property (assign, nonatomic) CRStatusBarStyle statusBarStyle;
@property (strong, nonatomic) UIView *navigationBar;

@property (strong, nonatomic) UIColor *navBackgroundColor;
@property (strong, nonatomic) UIImage *navBackgroundImage;
@property (assign, nonatomic) BOOL hideNav; // 使用透明的导航栏，其他属性仍然有效
@property (assign, nonatomic) BOOL hideNavBottomLine; // 隐藏导航栏底部的分割线
@property (assign, nonatomic) BOOL useCustomNavBar; // 使用自定义的导航栏,下面所有属性将失效,navigationBar的子视图清空

@property (copy, nonatomic) NSString *navTitle;
@property (strong, nonatomic) UIColor *navTitleColor;
@property (strong, nonatomic) NSAttributedString *navAttributeTitle;
@property (strong, nonatomic) UIFont *navTitleFont;

@property (strong, nonatomic) UIButton *navLeftButton;
@property (copy, nonatomic) NSString *leftButtonTitle;
@property (strong, nonatomic) UIImage *leftButtonImage;
@property (strong, nonatomic) UIColor *leftButtonColor;
@property (strong, nonatomic) UIFont *leftButtonFont;

@property (strong, nonatomic) UIButton *navRightButton;
@property (copy, nonatomic) NSString *rightButtonTitle;
@property (strong, nonatomic) UIImage *rightButtonImage;
@property (strong, nonatomic) UIColor *rightButtonColor;
@property (strong, nonatomic) UIFont *rightButtonFont;

// 设置pop手势是否可用，默认可用
- (void)setInteractiveEnabled:(BOOL)enabled;

// 按钮事件
- (void)leftButtonAction;
- (void)rightButtonAction;

// 系统通知事件
- (void)ApplicationWillEnterForeground;
- (void)ApplicationDidEnterBackground;
- (void)ApplicationDidBecomeActive;
- (void)ApplicationWillResignActive;
@end
