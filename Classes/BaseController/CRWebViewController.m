//
//  CRWebViewController.m
//  TestWebView
//
//  Created by iSouBu on 16/8/18.
//  Copyright © 2016年 isoubu. All rights reserved.
//

#import "CRWebViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "CRMacro.h"
#import "UIView+CRExtension.h"
#import "UIButton+CRExtension.h"
#import "YYCategories.h"

@interface CRWebViewController ()<WKNavigationDelegate>

@property (copy, nonatomic) NSString *titleString;
@property (nonatomic, copy) NSString *URL;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (strong, nonatomic) UIButton *closeButton;
@end

@implementation CRWebViewController

- (instancetype)initWithTitle:(NSString *)title URL:(NSString *)URL {
    if (self = [super init]) {
        _titleString = title;
        _URL = URL;
    }
    return self;
}

+ (CRNavigationController *)webControllerWithTitle:(NSString *)title URL:(NSString *)URL {
    CRWebViewController *webVC = [[CRWebViewController alloc] initWithTitle:title URL:URL];
    CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:webVC];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
    [self setupNavButton];
    [self loadRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.progressView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navTitle = _titleString;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)setupWebView {
    WKWebView *webView = [WKWebView new];
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationBar.mas_bottom);
    }];
    _webView = webView;
    
    [webView addObserver:self forKeyPath:@"canGoBack"
                 options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                 context:nil];
    [webView addObserver:self forKeyPath:@"title"
                 options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                 context:nil];
}

- (void)setupNavButton {
    UIColor *buttonColor = rgba(51.f,51.f,51.f,1.f);
    
    [self setLeftButtonTitle:@"返回"];
    [self setLeftButtonImage:[UIImage imageNamed:@"CRImage.bundle/cr_back"]];
    self.leftButtonColor = buttonColor;
    
    _closeButton = [UIButton new];
    _closeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeButton cr_setTitleColor:buttonColor];
    [_closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:_closeButton];
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navLeftButton.mas_right);
        make.top.equalTo(self.navLeftButton.mas_top);
        make.height.equalTo(self.navLeftButton.mas_height);
        make.width.mas_equalTo(44);
    }];
    _closeButton.hidden = YES;
}

// 发送请求
- (void)loadRequest {
    NSURLRequest *requtst = [NSURLRequest requestWithURL:[NSURL URLWithString:_URL]];
    [_webView loadRequest:requtst];
}

- (void)leftButtonAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self closeButtonAction];
    }
}

- (void)closeButtonAction {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    WeakSelf;
    [self.view cr_hiddenNodataView];
    [self.view cr_showNodataViewWithImage:nil text:@"加载失败,稍后重试" retryButtonTitle:@"刷新" retryButtonBlock:^{
        [weakSelf loadRequest];
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.view cr_hiddenNodataView];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *requestStr = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    if ([requestStr hasPrefix:@"tel"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:requestStr]];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        CGFloat progressBarHeight = 3.f;
        CGRect barFrame = CGRectMake(0, kSafeNavigationBarHeight, self.view.bounds.size.width, progressBarHeight);
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:barFrame];
        progressView.trackTintColor = [UIColor whiteColor];
        progressView.tintColor = [UIColor blackColor];
        _progressView = progressView;
        
    }
    return _progressView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newValue = [change[NSKeyValueChangeNewKey] floatValue];
        if (newValue > 0 && newValue < 1) {
            self.progressView.alpha = 1.f;
        } else {
            [UIView animateWithDuration:kAnimationDuration25 animations:^{
                self.progressView.alpha = 0.f;
            }];
        }
        [self.progressView setProgress:newValue animated:YES];
    } else if ([keyPath isEqualToString:@"canGoBack"]) {
        BOOL newValue = [change[NSKeyValueChangeNewKey] boolValue];
        _closeButton.hidden = !newValue;
    } else if ([keyPath isEqualToString:@"title"]) {
        if (_titleString == nil) {
            _titleString = change[NSKeyValueChangeNewKey];
            self.navTitle = _titleString;
        }
    }
}

@end
