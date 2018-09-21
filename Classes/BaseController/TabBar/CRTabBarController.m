//
//  CRTabBarController.m
//  CRKit
//
//  Created by roger wu on 06/07/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRTabBarController.h"
#import "CRBaseController.h"
#import "CRNavigationController.h"

#import "CRMacro.h"
#import "CRTabBar.h"
#import "CRTabBarItemModel.h"

@interface CRTabBarController()<CRTabBarDelegate>

@property (copy, nonatomic) NSString *plistName;
@property (weak, nonatomic) CRTabBar *customTabBar;
@property (strong, nonatomic) NSArray *tabBarDatas;

@end

@implementation CRTabBarController

- (instancetype)initWithPlistName:(NSString *)plistName {
    if (self = [super init]) {
        _plistName = plistName;
        [self setupTabBar];
        [self setupChildControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

- (NSArray *)tabBarDatas {
    if (!_tabBarDatas) {
        if (_plistName == nil) {
            NSAssert(NO, @"参照CRTabBarItems.plist配置");
            return nil;
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_plistName ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            CRTabBarItemModel *tabBarItemModel = [CRTabBarItemModel tabBarItemModelWithDic:dic];
            [tempArray addObject:tabBarItemModel];
        }
        _tabBarDatas = [tempArray copy];
    }
    return _tabBarDatas;
}

/**
 *  添加TabBar
 */
- (void)setupTabBar {
    CRTabBar *customTabBar = [[CRTabBar alloc] init];
    customTabBar.backgroundColor = [UIColor whiteColor];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    _customTabBar = customTabBar;
}

/**
 *  添加ChildController
 */
- (void)setupChildControllers {
    for (CRTabBarItemModel *tabBarItemModel in self.tabBarDatas) {
        [self addChildViewControllerWithTabBarItemModel:tabBarItemModel];
    }
}

- (void)addChildViewControllerWithTabBarItemModel:(CRTabBarItemModel *)tabBarItemModel {
    CRBaseController *controller = [[NSClassFromString(tabBarItemModel.tabBarController) alloc] init];
    controller.navTitle = tabBarItemModel.navBarTitle;
    controller.tabBarItem.title = tabBarItemModel.tabBarTitle;
    controller.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", tabBarItemModel.tabBarImageName]];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", tabBarItemModel.tabBarImageName]];
    
    CRNavigationController *navigationController = [[CRNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:navigationController];
    [self.customTabBar addButtonWithTabBarItem:controller.tabBarItem];
}

#pragma mark - TabBarDelegate
- (void)tabBar:(CRTabBar *)tabBar fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.selectedIndex = toIndex;
}

- (void)dealloc {
    CRLog(@"_%@_释放", NSStringFromClass(self.class));
}

@end
