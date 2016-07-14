//
//  UITextField+CRAdd.m
//  CRKit
//
//  Created by roger wu on 16/7/14.
//  Copyright © 2016年 cocoaroger. All rights reserved.
//

#import "UITextField+CRAdd.h"
#import "RACSignal.h"
#import "RACSignal+Operations.h"
#import "UIControl+RACSignalSupport.h"
#import "NSObject+RACDeallocating.h"
#import "RACEXTScope.h"

#import "NSObject+RACDescription.h"

@implementation UITextField (CRAdd)

- (void)cr_setPlaceholder:(NSString *)placeholder color:(UIColor *)color {
    NSDictionary *attributes = @{NSForegroundColorAttributeName: color};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    self.attributedPlaceholder = attributedString;
}

- (RACSignal *)rac_keyboardReturnSignal {
    @weakify(self);
    return [[[[[RACSignal
               defer:^{
                   @strongify(self);
                   return [RACSignal return:self];
               }]
              concat:[self rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]]
             takeUntil:self.rac_willDeallocSignal]
            setNameWithFormat:@"%@ -rac_keyboardReturnSignal", [self rac_description]] skip:1];
}

@end
