//
//  CRTabBarItem.m
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRTabBarItem.h"
#import "CRMacro.h"
#import "YYCategories.h"

// titleLable和imageView的所占比例
#define kTabBarButtonItemRadio 0.7
// titleLabel的字体大小
#define kTabBarButtonItemFontSize 12.0
// 默认文字颜色
#define kTabBarButtonItemTitleColor UIColorHex(a1a1a1)
// 选中文字颜色
#define kTabBarButtonItemTitleSelectedColor UIColorHex(2d2f49)
// 右上角消息数View的背景颜色
#define kTabBarBadgeViewColor rgb(255.0f, 139.0f, 0.0f)
// 右上角消息数View的字体大小
#define kTabBarBadgeViewFont 10.0f
// 右上角消息数View的宽高
#define kTabBarBadgeViewWH 15.0f
// 右上角消息数View的Y
#define kTabBarBadgeViewY 2.0f
// 右上角消息数的最大值
#define kTabBarBadgeViewMaxNumber 99
// 右上角消息数超过最大值显示的字符串
#define kTabBarBadgeViewMaxNumberShow @"..."
// 右上角圆点View的背景颜色
#define kTabBarCircleViewColor [UIColor redColor]
// 右上角圆点View的宽高
#define kTabBarCircleViewWH 10.0f
// 右上角圆点View的Y
#define kTabBarCircleViewY 2.0f

@interface CRTabBarItem()

@property (strong, nonatomic) UILabel *badgeLabel;

@end

@implementation CRTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 设置imageView的对齐方式
    self.imageView.contentMode = UIViewContentModeCenter;
    // 设置titleLabel的对齐方式
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 设置titleLabel的字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:kTabBarButtonItemFontSize];
    // 设置文字的颜色
    [self setTitleColor:kTabBarButtonItemTitleColor forState:UIControlStateNormal];
    [self setTitleColor:kTabBarButtonItemTitleSelectedColor forState:UIControlStateSelected];
    
    // 初始化数字提醒
    [self setupBadgeLabel];
}

- (void)setupBadgeLabel {
    UILabel *badgeLabel = [[UILabel alloc] init];
    badgeLabel.hidden = YES;
    badgeLabel.layer.cornerRadius = kTabBarBadgeViewWH * 0.5;
    badgeLabel.layer.masksToBounds = YES;
    badgeLabel.adjustsFontSizeToFitWidth = YES;
    badgeLabel.font = [UIFont systemFontOfSize:kTabBarBadgeViewFont];
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.backgroundColor = kTabBarBadgeViewColor;
    [self addSubview:badgeLabel];
    self.badgeLabel = badgeLabel;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height * kTabBarButtonItemRadio - 3.0f;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * (1.0 - kTabBarButtonItemRadio);
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * kTabBarButtonItemRadio;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat badgeLabelX = (self.bounds.size.width - kTabBarBadgeViewWH) * 0.5 + kTabBarBadgeViewWH * 0.75;
    self.badgeLabel.frame = CGRectMake(badgeLabelX, kTabBarBadgeViewY, kTabBarBadgeViewWH, kTabBarBadgeViewWH);
}

- (void)setHighlighted:(BOOL)highlighted {
    // DO Nothing
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    _tabBarItem = tabBarItem;
    [_tabBarItem addObserver:self
                  forKeyPath:@"badgeValue"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    NSString *badgeValue = self.tabBarItem.badgeValue;
    
    if (badgeValue) {
        NSUInteger number = [badgeValue integerValue];
        if (number > 0) {
            self.badgeLabel.hidden = NO;
            if (number > kTabBarBadgeViewMaxNumber) {
                self.badgeLabel.text = kTabBarBadgeViewMaxNumberShow;
            } else {
                self.badgeLabel.text = badgeValue;
            }
        } else {
            self.badgeLabel.hidden = YES;
        }
    } else {
        self.badgeLabel.hidden = YES;
    }
}

- (void)dealloc {
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
}

@end
