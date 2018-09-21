//
//  CRMacro.h
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#ifndef CRMacro_h
#define CRMacro_h

#ifdef DEBUG
#define CRLog(...) NSLog(__VA_ARGS__)
#else
#define CRLog(...)
#endif

// 获得RGB颜色
#define rgb(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define rgba(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kSeparatorLineColor rgb(228,228,228)

// 尺寸
#define kMainScreenScale [UIScreen mainScreen].scale // 屏幕scale
#define kSeparatorLineHeight (1.f/kMainScreenScale) // 水平分割线的高度
#define kLineHeight44 44.f
#define kAnimationDuration25 0.25

//iphoneX适配规则
#define isIphoneX (kScreenHeight == 812.0 || kScreenWidth == 812.0)
#define isIphone5 (kScreenWidth == 320)
#define isIphoneP (kScreenWidth == 414)
#define kSafeNavigationBarHeight (isIphoneX ? 88 : 64)
#define kSafeStatusBarHeight (isIphoneX ? 44 : 20)
#define kSafeTabBarHeight (isIphoneX ? 83 : 49)

// 系统版本判断
#define iOS10 ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
#define iOS11 ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0)

#define WeakSelf __weak __typeof(&*self) weakSelf = self

#endif /* CRMacro_h */
