//
//  CRAreaPickerView.h
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRArea.h"
@protocol CRAreaPickerDelegate;

/**
 *  城市地区选择
 */
@interface CRAreaPickerView : UIControl

@property (nonatomic, weak) id <CRAreaPickerDelegate> delegate;
@property (nonatomic, strong) UIPickerView *locatePicker;

- (id)initWithDelegate:(id <CRAreaPickerDelegate>)delegate;

- (void)show;
- (void)cancel;
@end


@protocol CRAreaPickerDelegate <NSObject>

/**
 *  点击完成按钮,返回省份和城市
 */
- (void)pickerView:(CRAreaPickerView *)pickerView province:(CRArea *)province city:(CRArea *)city;
@end


