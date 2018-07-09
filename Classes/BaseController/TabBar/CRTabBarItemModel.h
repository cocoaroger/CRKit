//
//  CRTabBarItemModel.h
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRTabBarItemModel : NSObject

/**
 导航栏标题
 */
@property (nonatomic, copy) NSString *navBarTitle;
/**
 tabBar标题
 */
@property (nonatomic, copy) NSString *tabBarTitle;
/**
 tabBar图片,尾部自动补全normal和selected
 */
@property (nonatomic, copy) NSString *tabBarImageName;
/**
 tabBarController
 */
@property (nonatomic, copy) NSString *tabBarController;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)tabBarItemModelWithDic:(NSDictionary *)dic;

@end
