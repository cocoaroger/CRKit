//
//  CRAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "CRAreaPickerView.h"

#define kDuration 0.25

static const CGFloat kPickerViewH = 200;
static const CGFloat kAccessViewHeight = 44;

#define kTitleFont [UIFont systemFontOfSize:16]
#define kTitleColor rgb(51, 51, 51)

#define kRowTitleFont [UIFont systemFontOfSize:16]
#define kRowTitleColor rgb(51, 51, 51)

#define kRightButtonColor UIColorHex(2d7dff)

@interface CRAreaPickerView ()<
    UIPickerViewDelegate,
    UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *provinces; // 所有省份数据

@property (nonatomic, assign) CGFloat pickerViewContentHeight; // 视图高度
@property (nonatomic, weak) UIView *pickerContentView; // 工具条
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *doneButton;


@property (nonatomic, strong) CRArea *selectedProvince; // 选中的省份
@property (nonatomic, strong) CRArea *selectedCity; // 选中的城市
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

- (id)initWithDelegate:(id<CRAreaPickerDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        [self setupViews];
    }
    return self;
}

- (void)openAreaPickerDatabase {
    NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"CRAreaPicker" ofType:@"sqlite"];
    [FCModel openDatabaseAtPath:databasePath withSchemaBuilder:^(FMDatabase *db, int *schemaVersion) {
    }];
}

- (CGFloat)pickerViewContentHeight {
    return kAccessViewHeight + kPickerViewH;
}

- (void)setupViews {
    [self addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
    
    UIView *pickerContentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 0)];
    [self addSubview:pickerContentView];
    self.pickerContentView = pickerContentView;
    
    // 工具条
    UIView *toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAccessViewHeight)];
    toolBarView.backgroundColor = [UIColor whiteColor];
    [pickerContentView addSubview:toolBarView];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton cr_setTitleColor:kRightButtonColor];
    doneButton.titleLabel.font = kTitleFont;
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:doneButton];
    self.doneButton = doneButton;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请选择";
    titleLabel.textColor = kTitleColor;
    titleLabel.font = kTitleFont;
    [toolBarView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(toolBarView);
    }];
    
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toolBarView);
        make.right.mas_equalTo(-15);
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
    [self openAreaPickerDatabase];
    NSArray *provinces = [CRArea instancesWhere:@"parentId = '0'"]; // 所有省份
    for (CRArea *province in provinces) {
        NSString *sql = [NSString stringWithFormat:@"parentId = '%@'", @(province.areaId)];
        NSArray *citys = [CRArea instancesWhere:sql];
        province.citys = citys;
    }
    
    self.provinces = provinces;
    
    CRArea *firstProvince = provinces.firstObject;
    self.selectedProvince = firstProvince;
    self.selectedCity = firstProvince.citys.firstObject;
}

#pragma mark - PickerViewDatasource
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

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

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *name = nil;
    if (component == 0) {
        CRArea *province = self.provinces[row];
        name = province.areaName;
    } else if (component == 1) {
        CRArea *city = self.selectedProvince.citys[row];
        name = city.areaName;
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:name];
    NSRange range = NSMakeRange(0, name.length);
    [attrString addAttribute:NSFontAttributeName value:kRowTitleFont range:range];
    [attrString addAttribute:NSForegroundColorAttributeName value:kRowTitleColor range:range];
    return attrString;
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
