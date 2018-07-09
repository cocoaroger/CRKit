//
//  CRTabBar.h
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CRTabBarDelegate;

@interface CRTabBar : UIView

@property (nonatomic, weak) id<CRTabBarDelegate> delegate;
- (void)addButtonWithTabBarItem:(UITabBarItem *)tabBarItem;
- (void)buttonClick:(UIButton *)button;

@end

@protocol CRTabBarDelegate<NSObject>
- (void)tabBar:(CRTabBar *)tabBar fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end
