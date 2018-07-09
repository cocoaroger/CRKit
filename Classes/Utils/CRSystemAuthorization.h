//
//  CRSystemAuthorization.h
//  SCSupplier
//
//  Created by roger wu on 2016/11/1.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

/**
 *  系统权限判断
 */
@interface CRSystemAuthorization : NSObject

/**
 *  是否具有定位权限
 */
+ (BOOL)hasLocationAuthorization;

/**
 *  是否具有相机权限
 */
+ (BOOL)hasCameraAuthorization;

/**
 *  是否具有相册权限
 */
+ (BOOL)hasPhotoAuthorization;

@end
