//
//  NSUserDefaults+CRAdd.h
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (CRAdd)
/**
 *  保存对象到NSUserDefaults
 *
 *  @param object 需要保存的对象
 *  @param key    保存的key
 */
+ (void)cr_saveObject:(id)object forKey:(NSString *)key;

/**
 *  获取保存的对象
 *
 *  @param key 保存对象的key
 *
 *  @return 获取的对象
 */
+ (id)cr_getObjectForKey:(NSString *)key;

/**
 *  删除保存的对象
 *
 *  @param key 保存对象的key
 */
+ (void)cr_deleteObjectForKey:(NSString *)key;

/**
 *  获取当前的语言环境
 *
 *  @return 返回当前的语言环境
 */
+ (NSString *)cr_preferedLanguage;

/**
 *  检测是否有新版本的Launcher
 *
 *  @param mainControllerBlock   加载主控制器的代码
 *  @param launchControllerBlock 加载LaunchController的代码
 *  @param isShow                如果版本不同，是否还是显示Launch
 */
+ (void)cr_launchControllerWithMainControllerBlock:(void (^)())mainControllerBlock
                             launchControllerBlock:(void (^)())launchControllerBlock
                                 isShowNewFeatures:(BOOL)isShow;
@end
