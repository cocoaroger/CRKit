//
//  CRNavigationController.m
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRNavigationController.h"
#import "CRMacro.h"

@interface CRNavigationController ()<
    UINavigationControllerDelegate,
    UIGestureRecognizerDelegate>
@end

@implementation CRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

- (void)setStatusbarStyle:(CRStatusBarStyle)statusbarStyle {
    _statusbarStyle = statusbarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (_statusbarStyle == CRStatusBarStyleLightContent) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.interactivePopGestureRecognizer.enabled = NO;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    CRLog(@"%@, 收到内存警告", [self class]);
}

- (void)dealloc {
    CRLog(@"_%@_释放", NSStringFromClass(self.class));
}

@end
