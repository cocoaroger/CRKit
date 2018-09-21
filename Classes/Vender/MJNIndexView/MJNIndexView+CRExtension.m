//
//  MJNIndexView+CRExtension.m
//  和路通
//
//  Created by roger wu on 17/07/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import "MJNIndexView+CRExtension.h"

static const CGFloat kIndexFontSize = 14.f;
static const CGFloat kSelectedIndexFontSize = 16.f;

@implementation MJNIndexView (CRExtension)

+ (instancetype)cr_indexViewWithFrame:(CGRect)frame dataSource:(id<MJNIndexViewDataSource>)dataSource {
    MJNIndexView *indexView = [[MJNIndexView alloc] initWithFrame:frame];
    indexView.dataSource = dataSource;
    indexView.getSelectedItemsAfterPanGestureIsFinished = NO;
    indexView.fontColor = [UIColor blackColor];
    indexView.selectedItemFontColor = [UIColor blackColor];
    indexView.font = [UIFont boldSystemFontOfSize:kIndexFontSize];
    indexView.selectedItemFont = [UIFont boldSystemFontOfSize:kSelectedIndexFontSize];
    indexView.maxItemDeflection = 0.0;
    indexView.itemsAligment = NSTextAlignmentCenter;
    return indexView;
}

@end
