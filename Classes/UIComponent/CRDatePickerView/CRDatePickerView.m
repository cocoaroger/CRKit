//
//  CRDatePickerView.m
//  和路通
//
//  Created by roger wu on 2019/1/18.
//  Copyright © 2019 asiainfo. All rights reserved.
//

#import "CRDatePickerView.h"
#import "Masonry.h"
#import "CRMacro.h"
#import "UIButton+CRExtension.h"

static const CGFloat kContentViewHeight = 244;
static const CGFloat kPickerViewHeight = 200;
#define kTitleFont [UIFont systemFontOfSize:16]
#define kTitleColor rgb(51, 51, 51)

#define kRowTitleFont [UIFont systemFontOfSize:16]
#define kRowTitleColor rgb(51, 51, 51)

#define kRightButtonColor rgb(45,125,255)

typedef void(^CRDatePickerViewComplete)(void);

@interface CRDatePickerView()

@end

@implementation CRDatePickerView{
    UIButton *_alphaView;
    UIView *_contentView;
    
    UIView *_accessView;
    UILabel *_titleLabel;
    UIButton *_rightButton;
    
    UIDatePicker *_pickerView;
}

- (instancetype)initWithTitle:(NSString *)title
             rightButtonTitle:(NSString *)rightButtonTitle
                     delegate:(id<CRDatePickerViewDelegate>)delegate
                      minDate:(NSDate *)minDate
                      maxDate:(NSDate *)maxDate {
    self = [super init];
    if (self) {
        _title = title;
        _rightButtonTitle = rightButtonTitle;
        _delegate = delegate;
        [self setup];
        
        if (minDate) {
            [_pickerView setMinimumDate:minDate];
        }
        if (maxDate) {
            [_pickerView setMaximumDate:maxDate];
        }
    }
    return self;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.frame = window.bounds;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            [self->_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottom).offset(-kContentViewHeight);
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    });
}

- (void)dismissWithComplete:(CRDatePickerViewComplete)complete {
    [UIView animateWithDuration:0.25 animations:^{
        [self->_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        complete();
    }];
}

- (void)buttonAction:(UIButton *)button {
    [self dismissWithComplete:^{
        if (button == self->_rightButton) {
            if ([self.delegate respondsToSelector:@selector(clickedRightButton:date:)]) {
                [self.delegate clickedRightButton:self date:self->_pickerView.date];
            }
        } else if (button == self->_alphaView) {
            if ([self.delegate respondsToSelector:@selector(closePickerView:)])
                [self.delegate closePickerView:self];
        }
    }];
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
}

- (void)setup {
    _alphaView = [UIButton new];
    _alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
    [_alphaView addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_alphaView];
    
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    _accessView = [UIView new];
    _accessView.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:_accessView];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = kTitleFont;
    _titleLabel.textColor = kTitleColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _title;
    [_accessView addSubview:_titleLabel];
    
    _rightButton = [UIButton new];
    [_rightButton setTitle:_rightButtonTitle forState:UIControlStateNormal];
    _rightButton.titleLabel.font = kTitleFont;
    [_rightButton cr_setTitleColor:kRightButtonColor];
    [_rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_accessView addSubview:_rightButton];
    
    _pickerView = [UIDatePicker new];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    _pickerView.datePickerMode = UIDatePickerModeDate;
    [_pickerView setDate:[NSDate date] animated:YES];
    [_pickerView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [_contentView addSubview:_pickerView];
    
    [_alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(kContentViewHeight);
    }];
    
    [_accessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self->_contentView);
        make.height.mas_equalTo(44);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self->_accessView);
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self->_accessView);
        make.right.mas_equalTo(-15);
    }];
    
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self->_contentView);
        make.height.mas_equalTo(kPickerViewHeight);
    }];
}

@end
