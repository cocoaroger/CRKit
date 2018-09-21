//
//  RootViewController.m
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "RootViewController.h"
#import "CRTimeButton.h"
#import "Masonry.h"
#import "RMUniversalAlert.h"
#import "CRTabBarController.h"

@interface RootViewController ()<
    CRTimeButtonDelegate>

@property (nonatomic, weak) CRTimeButton *timeButton;
@property (nonatomic, weak) UIButton *testAlertButton;
@property (strong, nonatomic) UIButton *toTabbarButton;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTimeButton];
    [self setupAlertButton];
    [self setupTabButton];
}

/**
 *  测试发送验证码按钮
 */
- (void)setupTimeButton {
    CRTimeButton *timeButton = [[CRTimeButton alloc] init];
    timeButton.backgroundColor = [UIColor blackColor];
    timeButton.delegate = self;
    [self.view addSubview:timeButton];
    self.timeButton = timeButton;
    
    __weak __typeof(&*self) weakSelf = self;
    [timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(44.f);
        make.centerX.equalTo(weakSelf.view);
        make.top.mas_equalTo(50.f);
    }];
    
}

- (void)timeButtonClicked:(CRTimeButton *)timeButton {
    NSLog(@"按钮点击事件");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timeButton resetButton];
    });
}

/**
 *  测试兼容UIAlertView和UIAlertController
 */
- (void)setupAlertButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试alert" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(testAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.testAlertButton = button;
    
    __weak __typeof(&*self) weakSelf = self;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(44.f);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.timeButton.mas_bottom).offset(20.f);
    }];
}

- (void)testAlert {
    [RMUniversalAlert showAlertInViewController:self
                                      withTitle:@"Test Alert"
                                        message:@"Test Message"
                              cancelButtonTitle:@"Cancel"
                         destructiveButtonTitle:@"Delete"
                              otherButtonTitles:nil
                                       tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                                           if (buttonIndex == alert.cancelButtonIndex) {
                                               NSLog(@"Cancel Tapped");
                                           } else if (buttonIndex == alert.destructiveButtonIndex) {
                                               NSLog(@"Delete Tapped");
                                           } else if (buttonIndex >= alert.firstOtherButtonIndex) {
                                               NSLog(@"Other Button Index %ld", (long)buttonIndex - alert.firstOtherButtonIndex);
                                           }
                                       }];
}

- (void)setupTabButton {
    UIButton *button = [UIButton new];
    [button setBackgroundColor:[UIColor blackColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"进入tabbar" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.toTabbarButton = button;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(200);
    }];
}

- (void)buttonAction:(UIButton *)button {
    if (button == self.toTabbarButton) {
        CRTabBarController *tabbarVC = [[CRTabBarController alloc] initWithPlistName:@"CRTabbarSetting"];
        [self presentViewController:tabbarVC animated:YES completion:nil];
    }
}

- (void)dealloc {
    [self.timeButton invalidateTimer];
}

@end
