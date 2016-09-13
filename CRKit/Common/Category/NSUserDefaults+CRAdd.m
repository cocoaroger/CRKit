//
//  NSUserDefaults+CRAdd.m
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "NSUserDefaults+CRAdd.h"

static NSString* const kOldAppVersionKey = @"kOldAppVersionKey";

@implementation NSUserDefaults (CRAdd)

+ (void)cr_saveObject:(id)object forKey:(NSString *)key {
    NSUserDefaults *defaults = [self standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+ (id)cr_getObjectForKey:(NSString *)key {
    return [[self standardUserDefaults] objectForKey:key];
}

+ (void)cr_deleteObjectForKey:(NSString *)key {
    NSUserDefaults *defaults = [self standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+ (NSString *)cr_preferedLanguage {
    NSUserDefaults *userDefault = [self standardUserDefaults];
    NSArray* languages = [userDefault objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

+ (void)cr_launchControllerWithMainControllerBlock:(void (^)())mainControllerBlock
                             launchControllerBlock:(void (^)())launchControllerBlock
                                 isShowNewFeatures:(BOOL)isShow {
    NSString *newVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *oldVersion = [self cr_getObjectForKey:kOldAppVersionKey];
    
    if (!oldVersion) {
        if (launchControllerBlock) {
            launchControllerBlock();
        }
        [self cr_saveObject:newVersion forKey:kOldAppVersionKey];
    } else {
        if ([oldVersion isEqualToString:newVersion]) {
            if (mainControllerBlock) {
                mainControllerBlock();
            }
        } else {
            if (isShow) {
                if (launchControllerBlock) {
                    launchControllerBlock();
                }
            } else {
                if (mainControllerBlock) {
                    mainControllerBlock();
                }
            }
            [self cr_saveObject:newVersion forKey:kOldAppVersionKey];
        }
    }

}
@end
