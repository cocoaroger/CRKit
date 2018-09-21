//
//  MJNIndexView+CRExtension.h
//  和路通
//
//  Created by roger wu on 17/07/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import "MJNIndexView.h"

@interface MJNIndexView (CRExtension)

+ (instancetype)cr_indexViewWithFrame:(CGRect)frame dataSource:(id<MJNIndexViewDataSource>)dataSource;

@end
