//
//  CRMediaUtil.h
//  和路通
//
//  Created by roger wu on 03/08/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CRMediaUtilComplete)(BOOL success, NSString *message);

/**
 图片、视频操作工具
 */
@interface CRMediaUtil : NSObject

// 保存图片
+ (void)saveImageWithImage:(nonnull UIImage *)image complete:(CRMediaUtilComplete)complete;
+ (void)saveImageWithFilePath:(nonnull NSURL *)filePath complete:(CRMediaUtilComplete)complete;
/**
 保存图片

 @param filePath 文件地址
 @param folderName 相册名
 @param complete 回调
 */
+ (void)saveImageWithFilePath:(nonnull NSURL *)filePath folderName:(nonnull NSString *)folderName complete:(CRMediaUtilComplete)complete;
+ (void)saveImageWithImage:(nonnull UIImage *)image folderName:(nonnull NSString *)folderName complete:(CRMediaUtilComplete)complete;

// 保存视频
+ (void)saveVideoWithFilePath:(nonnull NSURL *)filePath complete:(CRMediaUtilComplete)complete;
/**
 保存视频

 @param filePath 文件地址
 @param folderName 相册名
 @param complete 回调
 */
+ (void)saveVideoWithFilePath:(nonnull NSURL *)filePath folderName:(nonnull NSString *)folderName complete:(CRMediaUtilComplete)complete;
@end
