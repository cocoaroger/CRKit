//
//  CRScrollView.m
//  和路通
//
//  Created by roger wu on 10/08/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import "CRScrollView.h"

@implementation CRScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
        [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return  NO;
    }
}


@end
