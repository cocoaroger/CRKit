//
//  CRArea.h
//  SCSupplier
//
//  Created by roger wu on 2016/10/29.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCModel.h"

/**
 *  包括城市和省份对象
 */
@interface CRArea : FCModel

/**
 *  id
 */
@property (nonatomic, assign) NSInteger areaId;
/**
 *  名称
 */
@property (nonatomic, copy) NSString *areaName;
/**
 *  父类id
 */
@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, copy) NSString *tag;

@property (nonatomic, strong) NSArray *citys; // 城市数组
@end
