//
//  CRPickerView.h
//  和路通
//
//  Created by roger wu on 17/07/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CRPickerViewDelegate;

/**
 需要添加属性，可以继承这个对象
 */
@interface CRPickerViewModel : NSObject
@property (copy, nonatomic) NSString *title; // 单行标题
@end

/**
 单列选择视图
 */
@interface CRPickerView : UIView

- (instancetype)initWithTitle:(NSString *)title
             rightButtonTitle:(NSString *)rightButtonTitle
                     delegate:(id<CRPickerViewDelegate>)delegate
                   dataSource:(NSArray<CRPickerViewModel*> *)dataSource;

/**
 显示到某个视图上
 */
- (void)show;
- (void)reloadData;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *rightButtonTitle;
@property (weak, nonatomic) id<CRPickerViewDelegate> delegate;
@property (strong, nonatomic) NSArray<CRPickerViewModel*> *dataSource;

@end

@protocol CRPickerViewDelegate<NSObject>
@optional
/**
 选中回调

 @param pickerView 选中视图
 @param selectedModel 选中值
 */
- (void)pickerView:(CRPickerView *)pickerView selectedModel:(CRPickerViewModel *)selectedModel;
- (void)clickedRightButton:(CRPickerView *)pickerView selectedModel:(CRPickerViewModel *)selectedModel;
- (void)closePickerView:(CRPickerView *)pickerView;

@end
