//
//  CRNotificationView.m
//  和路通
//
//  Created by roger wu on 01/08/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import "CRNotificationView.h"

static const CGFloat kPadding = 10;
static const CGFloat kIconHeight = 24;
static const CGFloat kDelayTime = 4;

@interface CRNotificationView()
@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) UIImage *appIcon;
@property (copy, nonatomic) LTNotificationViewComplete complete;
@property (assign, nonatomic) CGFloat selfHeight;
@end

@implementation CRNotificationView {
    UIImageView *_iconImageView;
    UILabel *_appNameLabel;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIView *_bottomLine;
}

+ (instancetype)sharedInstance {
    static CRNotificationView *notificationView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notificationView = [CRNotificationView new];
    });
    return notificationView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.windowLevel = UIWindowLevelAlert;
    self.hidden = NO;
    self.backgroundColor = [UIColor lightGrayColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled = YES;
    [self cr_addBlurEffect];
    
    _iconImageView = [UIImageView new];
    _iconImageView.layer.cornerRadius = 4;
    _iconImageView.layer.masksToBounds = YES;
    [self addSubview:_iconImageView];
    
    _appNameLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:12]
                                 textColor:[UIColor blackColor]];
    [self addSubview:_appNameLabel];
    
    _titleLabel = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:14]
                               textColor:[UIColor blackColor]];
    [self addSubview:_titleLabel];
    
    _contentLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:14]
                                 textColor:[UIColor blackColor]];
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    
    _bottomLine = [UIView new];
    _bottomLine.backgroundColor = [UIColor lightGrayColor];
    _bottomLine.layer.cornerRadius = 2;
    _bottomLine.layer.masksToBounds = YES;
    [self addSubview:_bottomLine];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPadding);
        make.top.mas_equalTo(kPadding);
        make.width.height.mas_equalTo(kIconHeight);
    }];
    
    [_appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_iconImageView.mas_right).offset(6);
        make.centerY.equalTo(self->_iconImageView);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.equalTo(self->_iconImageView.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->_titleLabel);
        make.top.equalTo(self->_titleLabel.mas_bottom).offset(2);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(4);
    }];
    
    _appNameLabel.text = self.appName;
    _iconImageView.image = self.appIcon;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self addGestureRecognizer:swipe];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        [self dismiss];
    }
}

- (void)tap {
    self.complete();
}

- (NSString *)appName{
    if (!_appName) {
        _appName =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] ?: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    return _appName;
}

- (UIImage *)appIcon{
    if (!_appIcon) {
        _appIcon = [UIImage imageNamed:@"AppIcon"];
    }
    return _appIcon;
}

- (void)showWithTitle:(NSString *)title content:(NSString *)content complete:(LTNotificationViewComplete)complete {
    _complete = complete;
    _titleLabel.text = title;
    _contentLabel.text = content;
    
    CGFloat x = 5;
    CGFloat y = kSafeStatusBarHeight;
    CGFloat width = kScreenWidth-10;
    CGFloat contentLabelWidth = kScreenWidth-32;
    CGFloat contentLabelHeight = [content heightForFont:_contentLabel.font width:contentLabelWidth];
    CGFloat otherHeight = 84;
    _selfHeight = otherHeight + contentLabelHeight;
    
    self.hidden = NO;
    self.frame = CGRectMake(x, -y - _selfHeight, width, _selfHeight);
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(x, y, width, self->_selfHeight);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDelayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

- (void)dismiss {
    CGFloat x = 5;
    CGFloat y = kSafeStatusBarHeight;
    CGFloat width = kScreenWidth-10;
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectMake(x, -y - self->_selfHeight, width, self->_selfHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end
