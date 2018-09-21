//
//  CRPickerView.m
//  和路通
//
//  Created by roger wu on 17/07/2018.
//  Copyright © 2018 asiainfo. All rights reserved.
//

#import "CRPickerView.h"

static const CGFloat kContentViewHeight = 244;
static const CGFloat kPickerViewHeight = 200;
#define kTitleFont [UIFont systemFontOfSize:16]
#define kTitleColor rgb(51, 51, 51)

#define kRowTitleFont [UIFont systemFontOfSize:16]
#define kRowTitleColor rgb(51, 51, 51)

#define kRightButtonColor UIColorHex(2d7dff)

typedef void(^CRPickerComplete)(void);

@implementation CRPickerViewModel
@end

@interface CRPickerView()<
    UIPickerViewDelegate,
    UIPickerViewDataSource>
@property (strong, nonatomic) CRPickerViewModel *selectedModel;
@end

@implementation CRPickerView {
    UIButton *_alphaView;
    UIView *_contentView;
    
    UIView *_accessView;
    UILabel *_titleLabel;
    UIButton *_rightButton;
    
    UIPickerView *_pickerView;
}

- (instancetype)initWithTitle:(NSString *)title
             rightButtonTitle:(NSString *)rightButtonTitle
                     delegate:(id<CRPickerViewDelegate>)delegate
                   dataSource:(NSArray<CRPickerViewModel *> *)dataSource {
    self = [super init];
    if (self) {
        _title = title;
        _rightButtonTitle = rightButtonTitle;
        _delegate = delegate;
        _dataSource = dataSource;
        [self setup];
        if (dataSource.count >= 1) {
            self.selectedModel = _dataSource[0];
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

- (void)reloadData {
    [_pickerView reloadAllComponents];
}

- (void)dismissWithComplete:(CRPickerComplete)complete {
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
            if ([self.delegate respondsToSelector:@selector(clickedRightButton:selectedModel:)]) {
                [self.delegate clickedRightButton:self selectedModel:self.selectedModel];
            }
        } else if (button == self->_alphaView) {
            if ([self.delegate respondsToSelector:@selector(closePickerView:)])
            [self.delegate closePickerView:self];
        }
    }];
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
    
    _pickerView = [UIPickerView new];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
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

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CRPickerViewModel *model = self.dataSource[row];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:model.title];
    NSRange range = NSMakeRange(0, model.title.length);
    [attrString addAttribute:NSFontAttributeName value:kRowTitleFont range:range];
    [attrString addAttribute:NSForegroundColorAttributeName value:kRowTitleColor range:range];
    return attrString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedModel = _dataSource[row];
    if ([self.delegate respondsToSelector:@selector(pickerView:selectedModel:)]) {
        [self.delegate pickerView:self selectedModel:_dataSource[row]];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataSource.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end
