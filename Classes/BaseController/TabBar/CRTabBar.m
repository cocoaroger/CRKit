//
//  CRTabBar.m
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRTabBar.h"
#import "CRTabBarItem.h"

@interface CRTabBar ()
@property (nonatomic, weak) CRTabBarItem *selectedButton;
@end

@implementation CRTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / count;
    CGFloat buttonH = self.frame.size.height;
    
    for (int i = 0; i < count; i++) {
        CRTabBarItem *button = self.subviews[i];
        button.tag = i;
        button.frame = CGRectMake(i * buttonW, buttonY, buttonW, buttonH);
    }
}

- (void)addButtonWithTabBarItem:(UITabBarItem *)tabBarItem {
    CRTabBarItem *button = [[CRTabBarItem alloc] init];
    [button setTitle:tabBarItem.title forState:UIControlStateNormal];
    [button setImage:tabBarItem.image forState:UIControlStateNormal];
    [button setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    button.tabBarItem = tabBarItem;
    
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

- (void)buttonClick:(CRTabBarItem *)button {
    if ([self.delegate respondsToSelector:@selector(tabBar:fromIndex:toIndex:)]) {
        [self.delegate tabBar:self fromIndex:self.selectedButton.tag toIndex:button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}


@end
