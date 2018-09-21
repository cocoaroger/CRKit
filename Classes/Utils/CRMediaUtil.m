//
//  CRMediaUtil.m
//  和路通
//
//  Created by roger wu on 03/08/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import "CRMediaUtil.h"

@implementation CRMediaUtil

+ (PHAssetCollection *)getPhotoCollectionWithName:(NSString *)collectionName {
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                     subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                     options:nil];
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle containsString:collectionName]) {
            return assetCollection;
        }
    }
    return nil;
}

+ (void)saveImageWithImage:(UIImage *)image complete:(CRMediaUtilComplete)complete {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        complete(success, success ? @"保存图片成功" : @"保存图片失败");
        if (error) {
            CRLog(@"保存图片：%@", error);
        }
    }];
}

+ (void)saveImageWithFilePath:(NSURL *)filePath complete:(CRMediaUtilComplete)complete {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:filePath];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        complete(success, success ? @"保存图片成功" : @"保存图片失败");
        if (error) {
            CRLog(@"保存图片：%@", error);
        }
    }];
}

+ (void)saveImageWithFilePath:(NSURL *)filePath folderName:(NSString *)folderName complete:(CRMediaUtilComplete)complete {
    PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
    [library performChanges:^{
        PHAssetCollectionChangeRequest *collectionRequest;
        PHAssetCollection *assetCollection = [self getPhotoCollectionWithName:folderName];
        // 2.3 判断相册是否存在
        if (assetCollection) { // 如果存在就使用当前的相册创建相册请求
            collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else { // 如果不存在, 就创建一个新的相册请求
            collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:folderName];
        }
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:filePath];
        PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
        [collectionRequest addAssets:@[placeholder]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        complete(success, success ? @"保存图片成功" : @"保存图片失败");
        if (error) {
            CRLog(@"保存图片失败：%@", error);
        }
    }];
}

+ (void)saveImageWithImage:(UIImage *)image folderName:(NSString *)folderName complete:(CRMediaUtilComplete)complete {
    PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
    [library performChanges:^{
        PHAssetCollectionChangeRequest *collectionRequest;
        PHAssetCollection *assetCollection = [self getPhotoCollectionWithName:folderName];
        if (assetCollection) { // 如果存在就使用当前的相册创建相册请求
            collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else { // 如果不存在, 就创建一个新的相册请求
            collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:folderName];
        }
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
        [collectionRequest addAssets:@[placeholder]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        complete(success, success ? @"保存图片成功" : @"保存图片失败");
        if (error) {
            CRLog(@"保存图片失败：%@", error);
        }
    }];
}

+ (void)saveVideoWithFilePath:(NSURL *)filePath complete:(CRMediaUtilComplete)complete {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:filePath];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        complete(success, success ? @"保存视频成功" : @"保存视频失败");
        if (error) {
            CRLog(@"保存视频：%@", error);
        }
    }];
}

+ (void)saveVideoWithFilePath:(NSURL *)filePath folderName:(NSString *)folderName complete:(CRMediaUtilComplete)complete {
    PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
    [library performChanges:^{
        PHAssetCollectionChangeRequest *collectionRequest;
        PHAssetCollection *assetCollection = [self getPhotoCollectionWithName:folderName];
        // 2.3 判断相册是否存在
        if (assetCollection) { // 如果存在就使用当前的相册创建相册请求
            collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else { // 如果不存在, 就创建一个新的相册请求
            collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:folderName];
        }
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:filePath];
        PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
        [collectionRequest addAssets:@[placeholder]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        complete(success, success ? @"保存视频成功" : @"保存视频失败");
        if (error) {
            CRLog(@"保存视频：%@", error);
        }
    }];
}

@end
