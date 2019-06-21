//
//  CRDatePickerView.h
//  和路通
//
//  Created by roger wu on 2019/1/18.
//  Copyright © 2019 asiainfo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CRDatePickerViewDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface CRDatePickerView : UIView

- (instancetype)initWithTitle:(NSString *)title
             rightButtonTitle:(NSString *)rightButtonTitle
                     delegate:(id<CRDatePickerViewDelegate>)delegate
                      minDate:(nullable NSDate *)minDate
                      maxDate:(nullable NSDate *)maxDate;
- (void)show;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *rightButtonTitle;
@property (weak, nonatomic) id<CRDatePickerViewDelegate> delegate;
@end

@protocol CRDatePickerViewDelegate<NSObject>
@optional
/**
 选中回调
 
 @param pickerView 选中视图
 @param date 选中值
 */
- (void)pickerView:(CRDatePickerView *)pickerView date:(NSDate *)date;
- (void)clickedRightButton:(CRDatePickerView *)pickerView date:(NSDate *)date;
- (void)closePickerView:(CRDatePickerView *)pickerView;

@end
NS_ASSUME_NONNULL_END
