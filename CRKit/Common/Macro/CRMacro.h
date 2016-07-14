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
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 获得ARGB颜色
#define ARGBColor(a, r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

// 屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

// 屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* CRMacro_h */
