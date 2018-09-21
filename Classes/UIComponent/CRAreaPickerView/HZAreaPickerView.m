//
//  CRAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "CRAreaPickerView.h"

#define kDuration 0.25
#define kPickerViewH 180.f

@interface CRAreaPickerView ()<
    UIPickerViewDelegate,
    UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *provinces; // 所有省份数据

@property (nonatomic, assign) CGFloat pickerViewContentHeight; // 视图高度

@property (nonatomic, weak) UIView *pickerContentView; // 工具条
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *doneButton;


@property (nonatomic, strong) HZArea *selectedProvince; // 选中的省份
@property (nonatomic, strong) HZArea *selectedCity; // 选中的城市
@end

@implementation CRAreaPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupViews];
    }
    return self;
}

- (id)initWithDelegate:(id<HZAreaPickerDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        [self setupViews];
    }
    return self;
}

- (CGFloat)pickerViewContentHeight {
    return kSCLineHeight44 + kPickerViewH;
}

- (void)setupViews {
    [self addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kSCBlackViewAlpha];
    
    UIView *pickerContentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 0)];
    [self addSubview:pickerContentView];
    self.pickerContentView = pickerContentView;
    
    // 工具条
    UIView *toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSCLineHeight44)];
    toolBarView.backgroundColor = [UIColor whiteColor];
    [pickerContentView addSubview:toolBarView];
    
    UIImageView *bottomLineView = [UIImageView sc_horizontalLine];
    bottomLineView.frame = CGRectMake(0, (kSCLineHeight44 - kSCSeparatorLineHeight), kScreenWidth, kSCSeparatorLineHeight);
    [toolBarView addSubview:bottomLineView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton cr_setTitleColor:kBarButtonItemTitleColor];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:kBarButtonItemTitleFontSize];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:cancelButton];
    self.cancelButton = cancelButton;
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton cr_setTitleColor:[UIColor sc_mainColor]];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:kBarButtonItemTitleFontSize];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:doneButton];
    self.doneButton = doneButton;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请选择";
    titleLabel.textColor = [UIColor sc_blackColor];
    titleLabel.font = doneButton.titleLabel.font;
    [toolBarView addSubview:titleLabel];
    
    CGFloat cancelButtonW = 60.f;
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(toolBarView);
        make.width.mas_equalTo(cancelButtonW);
        make.height.equalTo(toolBarView);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(toolBarView);
    }];
    
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(toolBarView);
        make.width.equalTo(cancelButton);
        make.height.equalTo(toolBarView);
    }];
    
    // pickerView
    UIPickerView *locatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolBarView.bottom, kScreenWidth, kPickerViewH)];
    locatePicker.dataSource = self;
    locatePicker.delegate = self;
    locatePicker.backgroundColor = [UIColor whiteColor];
    [pickerContentView addSubview:locatePicker];
    self.locatePicker = locatePicker;
    
    pickerContentView.height = self.pickerViewContentHeight;
    
    //加载数据
    [self setupDatas];
}

/**
 *  加载数据
 */
- (void)setupDatas {
    [FCModel sc_openHZAreaPickerDatabase];
    NSArray *provinces = [HZArea instancesWhere:@"parentId = '0'"]; // 所有省份
    for (HZArea *province in provinces) {
        NSString *sql = [NSString stringWithFormat:@"parentId = '%@'", @(province.areaId)];
        NSArray *citys = [HZArea instancesWhere:sql];
        province.citys = citys;
    }
    
    self.provinces = provinces;
    
    HZArea *firstProvince = provinces.firstObject;
    self.selectedProvince = firstProvince;
    self.selectedCity = firstProvince.citys.firstObject;
}

#pragma mark - PickerViewDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinces.count;
    } else if (component == 1) {
        return self.selectedProvince.citys.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        HZArea *province = self.provinces[row];
        return province.areaName;
    } else if (component == 1) {
        HZArea *city = self.selectedProvince.citys[row];
        return city.areaName;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedProvince = self.provinces[row];
        self.selectedCity = self.selectedProvince.citys.firstObject;
        [pickerView reloadComponent:1];
    } else if (component == 1) {
        self.selectedCity = self.selectedProvince.citys[row];
    }
}

#pragma mark - Public Method
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    __weak __typeof(&*self) weakSelf = self;
    [UIView animateWithDuration:kDuration animations:^{
        weakSelf.pickerContentView.top -= weakSelf.pickerViewContentHeight;
    }];
    
}

- (void)cancel {
    __weak __typeof(&*self) weakSelf = self;
    [UIView animateWithDuration:kDuration
                     animations:^{
                         weakSelf.pickerContentView.top += weakSelf.pickerViewContentHeight;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
    
}

#pragma mark - Private Method
- (void)buttonAction:(UIButton *)button {
    if (button == self.cancelButton) {
        [self cancel];
    } else if (button == self.doneButton) {
        [self cancel];
        if ([self.delegate respondsToSelector:@selector(pickerView:province:city:)]) {
            [self.delegate pickerView:self province:self.selectedProvince city:self.selectedCity];
        }
    }
}

@end
