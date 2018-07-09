//
//  CRUncaughtExceptionHandler.m
//  SCSupplier
//
//  Created by roger wu on 2016/10/12.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import "CRUncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <MessageUI/MessageUI.h>
#import "NSString+CRExtention.h"
#import "UIAlertController+Blocks.h"
#import "UIApplication+YYAdd.h"

#define kCRUncaughtExceptionPath [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"kCRUncaughtExceptionLog"]

@interface CRUncaughtExceptionHandler ()<MFMailComposeViewControllerDelegate>

@end

@implementation CRUncaughtExceptionHandler

+ (void)showExceptionAlert {
    NSString *message = [NSString stringWithContentsOfFile:kCRUncaughtExceptionPath encoding:NSUTF8StringEncoding error:nil];
    if ([message cr_hasValue]) {
        CRUncaughtExceptionHandler *handler = [[CRUncaughtExceptionHandler alloc] init];
        
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        [UIAlertController showAlertInViewController:rootViewController
                                          withTitle:@"上次异常信息"
                                            message:message
                                  cancelButtonTitle:@"确定"
                             destructiveButtonTitle:nil
                                  otherButtonTitles:nil
                                           tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                               [[NSFileManager defaultManager] removeItemAtPath:kCRUncaughtExceptionPath error:nil];
                                               if (![MFMailComposeViewController canSendMail]) {
                                                   return;
                                               }
                                               
                                               MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
                                               mailVC.mailComposeDelegate = handler;
                                               [mailVC setToRecipients:@[@"wuxuanqiang@isoubu.com"]];
                                               [mailVC setSubject:@"供应商管理崩溃报告"];
                                               [mailVC setMessageBody:message isHTML:NO];
                                               [rootViewController presentViewController:mailVC animated:YES completion:nil];
                                           }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end

/**
 *  抓取异常信息，存入本地
 */
void HandleException(NSException *exception) {
    NSString *reason = [NSString stringWithFormat:@"错误原因：\n%@\n详细信息：\n%@", exception.reason, exception.callStackSymbols];
    [reason writeToFile:kCRUncaughtExceptionPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
    NSSetUncaughtExceptionHandler(NULL);
}

void InstallUncaughtExceptionHandler() {
    NSSetUncaughtExceptionHandler(&HandleException);
}
