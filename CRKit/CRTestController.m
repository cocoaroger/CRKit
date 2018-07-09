//
//  CRTestController.m
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRTestController.h"
#import "Masonry.h"
#import "CRWebViewController.h"

@interface CRTestController ()

@property (strong, nonatomic) UIButton *navButton;
@property (strong, nonatomic) UIButton *webButton;

@end

@implementation CRTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftButtonTitle = @"关闭";
    self.rightButtonTitle = @"右边按钮";
    self.navTitle = @"首页";
    
    [self.view addSubview:self.navButton];
    [self.navButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [self.view addSubview:self.webButton];
    [self.webButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navButton.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (UIButton *)navButton {
    if (!_navButton) {
        _navButton = [UIButton new];
        [_navButton setTitle:@"导航" forState:UIControlStateNormal];
        [_navButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_navButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navButton;
}

- (UIButton *)webButton {
    if (!_webButton) {
        _webButton = [UIButton new];
        [_webButton setTitle:@"网页" forState:UIControlStateNormal];
        [_webButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_webButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _webButton;
}

- (void)buttonAction:(UIButton *)button {
    if (button == self.navButton) {
        [self.navigationController pushViewController:[CRTestController new] animated:YES];
    } else if (button == _webButton) {
        CRWebViewController *webVC = [[CRWebViewController alloc] initWithTitle:@"网页" URL:@"https://www.baidu.com"];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)leftButtonAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
