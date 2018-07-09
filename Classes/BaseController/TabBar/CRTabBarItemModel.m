//
//  CRTabBarItemModel.m
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRTabBarItemModel.h"

@implementation CRTabBarItemModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)tabBarItemModelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

@end
