//
//  NSArray+CRExtension.h
//  CRKit
//
//  Created by roger wu on 21/08/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSArray (CRExtension)

// 获取手机支持的导航方法
+ (NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation;
// 获取手机支持的标题
+ (NSArray *)getInstalledMapAppTitles;

@end
