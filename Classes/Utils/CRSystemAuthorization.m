//
//  CRSystemAuthorization.m
//  CRKit
//
//  Created by roger wu on 2016/11/1.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "CRSystemAuthorization.h"
#import <CoreLocation/CLLocationManager.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@implementation CRSystemAuthorization

+ (BOOL)hasLocationAuthorization {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if ([CLLocationManager locationServicesEnabled] &&
        (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
         status == kCLAuthorizationStatusNotDetermined ||
         status == kCLAuthorizationStatusAuthorizedAlways)) {
            return YES;
        }
    return NO;
}

+ (BOOL)hasCameraAuthorization {
    AVAuthorizationStatus status =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted ||
        status ==AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

+ (BOOL)hasPhotoAuthorization {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || // 家庭权限
        status == PHAuthorizationStatusDenied) { // 不允许
        return NO;
    }
    return YES;
}

@end
