//
//  CRBaseController.m
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRBaseController.h"
#import "CRNavigationController.h"
#import "CRMacro.h"
#import "Masonry.h"
#import "UIButton+CRExtention.h"

#define kDefaultTitleFont [UIFont systemFontOfSize:20] // title的字体
#define kDefaultTitleColor rgba(51.f,51.f,51.f,1.f) // title的颜色

#define kDefaultButtonTitleFont [UIFont systemFontOfSize:16]
#define kDefaultButtonTitleColor rgba(51.f,51.f,51.f,1.f)

static const CGFloat kButtonWidth = 60;
static const CGFloat kButtonHeight = 44;

@interface CRBaseController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *navBackgroundImageView;
@property (strong, nonatomic) UIView *navBottomLine;
@property (strong, nonatomic) UILabel *navTitleLabel;
@property (assign, nonatomic) BOOL isEnabledPopGesture; // 返回手势是否可用

@property (strong, nonatomic) UIImage *backImage;

@end

@implementation CRBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self baseSetup];
    
    // 默认配置
    self.statusBarStyle = CRStatusBarStyleDark;
    if (self.navigationController.viewControllers.count > 1) {
        self.isEnabledPopGesture = YES;
        [self setLeftButtonImage:self.backImage]; // 默认样式
        [self.navLeftButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(44);
        }];
    } else {
        self.isEnabledPopGesture = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateStatusBar];
    [self.view bringSubviewToFront:self.navigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = self.isEnabledPopGesture;
}

#pragma mark - 设置属性
- (void)setStatusBarStyle:(CRStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self updateStatusBar];
}

- (void)setNavBackgroundColor:(UIColor *)navBackgroundColor {
    _navBackgroundColor = navBackgroundColor;
    self.navigationBar.backgroundColor = navBackgroundColor;
}

- (void)setNavBackgroundImage:(UIImage *)navBackgroundImage {
    _navBackgroundImage = navBackgroundImage;
    self.navBackgroundImageView.image = _navBackgroundImage;
}

- (void)setHideNav:(BOOL)hideNav {
    _hideNav = hideNav;
    self.navigationBar.backgroundColor = hideNav ? [UIColor clearColor] : [UIColor whiteColor];
}

- (void)setHideNavBottomLine:(BOOL)hideNavBottomLine {
    _hideNavBottomLine = hideNavBottomLine;
    self.navBottomLine.hidden = hideNavBottomLine;
}

- (void)setUseCustomNavBar:(BOOL)useCustomNavBar {
    _useCustomNavBar = useCustomNavBar;
    self.navigationBar.hidden = useCustomNavBar;
}

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.navTitleLabel.text = navTitle;
}

- (void)setNavTitleColor:(UIColor *)navTitleColor {
    _navTitleColor = navTitleColor;
    self.navTitleLabel.textColor = navTitleColor;
}

- (void)setNavAttributeTitle:(NSAttributedString *)navAttributeTitle {
    _navAttributeTitle = navAttributeTitle;
    self.navTitleLabel.attributedText = navAttributeTitle;
}

- (void)setNavTitleFont:(UIFont *)navTitleFont {
    _navTitleFont = navTitleFont;
    self.navTitleLabel.font = navTitleFont;
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    _leftButtonTitle = leftButtonTitle;
    [self.navLeftButton cr_setImage:nil];
    [self.navLeftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
    CGFloat newWidth = [self caculateItemWidth:leftButtonTitle];
    [self.navLeftButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(newWidth);
    }];
}

- (void)setLeftButtonImage:(UIImage *)leftButtonImage {
    _leftButtonImage = leftButtonImage;
    [self.navLeftButton cr_setImage:leftButtonImage];
}

- (void)setLeftButtonColor:(UIColor *)leftButtonColor {
    _leftButtonColor = leftButtonColor;
    self.navLeftButton.tintColor = leftButtonColor;
    [self.navLeftButton cr_setTitleColor:leftButtonColor];
}

- (void)setLeftButtonFont:(UIFont *)leftButtonFont {
    _leftButtonFont = leftButtonFont;
    self.navLeftButton.titleLabel.font = leftButtonFont;
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    _rightButtonTitle = rightButtonTitle;
    [self.navRightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    CGFloat newWidth = [self caculateItemWidth:rightButtonTitle];
    [self.navRightButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(newWidth);
    }];
}

- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    _rightButtonImage = rightButtonImage;
    [self.navRightButton cr_setImage:rightButtonImage];
}

- (void)setRightButtonColor:(UIColor *)rightButtonColor {
    _rightButtonColor = rightButtonColor;
    self.navRightButton.tintColor = rightButtonColor;
    [self.navRightButton cr_setTitleColor:rightButtonColor];
}

- (void)setRightButtonFont:(UIFont *)rightButtonFont {
    _rightButtonFont = rightButtonFont;
    self.navRightButton.titleLabel.font = rightButtonFont;
}

- (void)setInteractiveEnabled:(BOOL)enabled {
    self.isEnabledPopGesture = enabled;
    self.navigationController.interactivePopGestureRecognizer.enabled = enabled;
}

- (void)leftButtonAction {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)rightButtonAction {
}

- (CGFloat)caculateItemWidth:(NSString *)itemTitle {
    NSDictionary *attriDic = @{NSFontAttributeName : kDefaultButtonTitleFont};
    CGRect strRect = [itemTitle boundingRectWithSize:CGSizeMake(kScreenWidth, 20)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attriDic
                                             context:nil];
    CGFloat width = strRect.size.width;
    return width + 30;
}

#pragma mark - UIApplicationNotification
- (void)ApplicationWillEnterForeground {}
- (void)ApplicationDidEnterBackground {}
- (void)ApplicationDidBecomeActive {}
- (void)ApplicationWillResignActive {}

#pragma mark - setup
- (void)baseSetup {
    [self.navigationController setNavigationBarHidden:YES];
    [self setupNavigationBar];
    [self setupNotifications];
}

- (void)setupNavigationBar {
    [self.view addSubview:self.navigationBar];
    [self.navigationBar addSubview:self.navBackgroundImageView];
    [self.navigationBar addSubview:self.navBottomLine];
    [self.navigationBar addSubview:self.navTitleLabel];
    [self.navigationBar addSubview:self.navLeftButton];
    [self.navigationBar addSubview:self.navRightButton];
    
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(kSafeNavigationBarHeight);
    }];
    [self.navBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationBar);
    }];
    [self.navBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.navigationBar);
        make.height.mas_equalTo(kSeparatorLineHeight);
    }];
    [self.navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navigationBar.mas_centerX);
        make.centerY.equalTo(self.navLeftButton.mas_centerY);
        make.width.mas_lessThanOrEqualTo(220);
    }];
    [self.navLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.navigationBar);
        make.width.mas_equalTo(kButtonWidth);
        make.height.mas_equalTo(kButtonHeight);
    }];
    [self.navRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.navigationBar);
        make.width.mas_equalTo(kButtonWidth);
        make.height.mas_equalTo(kButtonHeight);
    }];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationWillResignActive) name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (_statusBarStyle == CRStatusBarStyleLightContent) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)updateStatusBar {
    if ([self.navigationController isKindOfClass:[CRNavigationController class]] &&
        self.navigationController.viewControllers.count > 0) {
        [(CRNavigationController *)self.navigationController setStatusbarStyle:_statusBarStyle];
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

#pragma mark - 懒加载属性
- (UIView *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [UIView new];
        _navigationBar.backgroundColor = [UIColor whiteColor];
    }
    return _navigationBar;
}

- (UIImageView *)navBackgroundImageView {
    if (!_navBackgroundImageView) {
        _navBackgroundImageView = [UIImageView new];
        _navBackgroundImageView.backgroundColor = [UIColor clearColor];
    }
    return _navBackgroundImageView;
}

- (UIView *)navBottomLine {
    if (!_navBottomLine) {
        _navBottomLine = [UIView new];
        _navBottomLine.backgroundColor = rgb(221, 221, 221);
    }
    return _navBottomLine;
}

- (UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [UILabel new];
        _navTitleLabel.font = kDefaultTitleFont;
        _navTitleLabel.textColor = kDefaultTitleColor;
        _navTitleLabel.numberOfLines = 1;
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _navTitleLabel;
}

- (UIButton *)navLeftButton {
    if (!_navLeftButton) {
        _navLeftButton = [UIButton new];
        [_navLeftButton cr_setTitleColor:kDefaultButtonTitleColor];
        _navLeftButton.titleLabel.font = kDefaultButtonTitleFont;
        [_navLeftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftButton;
}

- (UIButton *)navRightButton {
    if (!_navRightButton) {
        _navRightButton = [UIButton new];
        [_navRightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _navRightButton.titleLabel.font = kDefaultButtonTitleFont;
        [_navRightButton cr_setTitleColor:kDefaultButtonTitleColor];
    }
    return _navRightButton;
}

- (UIImage *)backImage {
    if (!_backImage) {
        _backImage = [[UIImage imageNamed:@"CRImage.bundle/cr_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return _backImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    CRLog(@"%@, 收到内存警告", [self class]);
}

- (void)dealloc {
    CRLog(@"_%@_释放", NSStringFromClass(self.class));
}

@end
