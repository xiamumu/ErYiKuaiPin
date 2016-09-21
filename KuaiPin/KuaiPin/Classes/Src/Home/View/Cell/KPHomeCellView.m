//
//  KPHomeCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//  首页自定义cell上面的View

#import "KPHomeCellView.h"
#import "KPHomeCellTopView.h"
#import "KPHomeRowData.h"
#import "KPHomeCellBottomViewDefault.h"
#import "KPHomeCellBottomViewBrand.h"
#import "KPHomeCellBottomViewGoods.h"

@interface KPHomeCellView ()

@property (nonatomic, weak) KPHomeCellTopView *topView;
@property (nonatomic, weak) UIView *bottomView;

@property (nonatomic, strong) KPHomeCellBottomViewDefault *bottomViewDefault;
@property (nonatomic, strong) KPHomeCellBottomViewGoods *bottomViewGoods;
@property (nonatomic, strong) KPHomeCellBottomViewBrand *bottomViewBrand;
@end

@implementation KPHomeCellView

- (KPHomeCellBottomViewDefault *)bottomViewDefault
{
    if (_bottomViewDefault == nil) {
        _bottomViewDefault = [[KPHomeCellBottomViewDefault alloc] init];
    }
    return _bottomViewDefault;
}
- (KPHomeCellBottomViewGoods *)bottomViewGoods
{
    if (_bottomViewGoods == nil) {
        _bottomViewGoods = [[KPHomeCellBottomViewGoods alloc] init];
    }
    return _bottomViewGoods;
}
- (KPHomeCellBottomViewBrand *)bottomViewBrand
{
    if (_bottomViewBrand == nil) {
        _bottomViewBrand = [[KPHomeCellBottomViewBrand alloc] init];
    }
    return _bottomViewBrand;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        KPHomeCellTopView *topView = [[KPHomeCellTopView alloc] init];
        [self addSubview:topView];
        self.topView = topView;
        __weak typeof(self) weakSelf = self;
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(weakSelf);
            make.height.mas_equalTo(35);
        }];
    }
    return self;
}

- (void)setRowData:(KPHomeRowData *)rowData
{
    self.topView.title = rowData.title;
    self.topView.headerImageName = rowData.headerImageName;
    
    __weak typeof(self) weakSelf = self;
    switch (rowData.rowDataType) {
        case KPHomeRowDataTypeDefault:
        {
            self.bottomViewDefault.goods = rowData.goods;
            self.bottomViewDefault.fromRowTitle = rowData.title;
            [self addSubview:self.bottomViewDefault];
            // 设置约束
            [self.bottomViewDefault mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(weakSelf);
                make.height.mas_equalTo(ScaleHeight(119));
            }];
        }
            break;
        case KPHomeRowDataTypeGoods:
        {
            self.bottomViewGoods.goods = rowData.goods;
            self.bottomViewGoods.scrollImages = rowData.scrollImages;
            self.bottomViewGoods.fromRowTitle = rowData.title;
            [self addSubview:self.bottomViewGoods];
            // 设置约束
            CGFloat height = 121 + 2 + 121;
            [self.bottomViewGoods mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(weakSelf);
                make.height.mas_equalTo(ScaleHeight(height));
            }];
        }
            break;
        case KPHomeRowDataTypeBrand:
        {
            self.bottomViewBrand.brand = rowData.brands;
            self.bottomViewBrand.scrollImages = rowData.scrollImages;
            self.bottomViewBrand.fromRowTitle = rowData.title;
            [self addSubview:self.bottomViewBrand];
            // 设置约束
            CGFloat height = 121 + 2 + 66 + 2;
            [self.bottomViewBrand mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(weakSelf);
                make.height.mas_equalTo(ScaleHeight(height));
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
