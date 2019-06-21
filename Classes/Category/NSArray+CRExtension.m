//
//  NSArray+CRExtension.m
//  CRKit
//
//  Created by roger wu on 21/08/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "NSArray+CRExtension.h"
#import "YYCategories.h"

@implementation NSArray (CRExtension)

+ (NSString *)queryURLEncode:(NSString *)str {
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSMutableDictionary *)dictionary:(NSString *)title url:(NSString *)url {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"title"] = title;
    dict[@"url"] = [self queryURLEncode:url];
    return dict;
}

+ (NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation {
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=walking&coord_type=gcj02",endLocation.latitude,endLocation.longitude];
        [maps addObject:[self dictionary:@"百度地图" url:urlString]];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&lat=%f&lon=%f&dev=0&style=2",[UIApplication sharedApplication].appBundleName,endLocation.latitude,endLocation.longitude];
        [maps addObject:[self dictionary:@"高德地图" url:urlString]];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=walking",[UIApplication sharedApplication].appBundleName,@"nav123456",endLocation.latitude, endLocation.longitude];
        [maps addObject:[self dictionary:@"谷歌地图" url:urlString]];
    }
    
    return maps;
}

+ (NSArray *)getInstalledMapAppTitles {
    NSArray *array = [self getInstalledMapAppWithEndLocation:CLLocationCoordinate2DMake(0, 0)];
    NSMutableArray *temp = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [temp addObject:obj[@"title"]];
    }];
    return temp;
}

@end
