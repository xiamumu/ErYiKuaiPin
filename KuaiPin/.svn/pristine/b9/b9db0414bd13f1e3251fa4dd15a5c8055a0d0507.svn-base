//
//  KPVendorSectionHeaderView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPVendorSectionHeaderView.h"
#import "KPSeparatorSectionHeaderView.h"

@interface KPVendorSectionHeaderView ()

@property (nonatomic, strong) UILabel *vendorNameLB;

@property (nonatomic, strong) UIButton *logisticsInfoBtn;

@end

@implementation KPVendorSectionHeaderView

- (void)setShowLogisticsInfo:(BOOL)showLogisticsInfo {
    _showLogisticsInfo = showLogisticsInfo;
    self.logisticsInfoBtn.hidden = !showLogisticsInfo;
}

- (void)clickLogisticsInfoButton {
    
    NSPostNote(Noti_LookUpLogisticsInfo, self.vendorModel)
}

- (void)setVendorModel:(KPVendorModel *)vendorModel {
    _vendorModel = vendorModel;
    
    self.vendorNameLB.text = vendorModel.storeName;
    
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPVendorSectionHeaderView";
    KPVendorSectionHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (view == nil) {
        view = [[KPVendorSectionHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return view;
}

+ (CGFloat)headerViewHeight {
    return 50;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.contentView.backgroundColor = WhiteColor;
    
    KPSeparatorSectionHeaderView *sepView = [KPSeparatorSectionHeaderView new];
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:sepView];
    [self addSubview:self.vendorNameLB];
    [self addSubview:sep];
    [self addSubview:self.logisticsInfoBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat sepViewH = 10;
    CGFloat nameCenterY = 20;
    CGFloat leftRight = 9;
    CGFloat sepH = 1;
    CGFloat btnH = 22;
    CGFloat btnW = 74;
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepViewH);
    }];
    
    [self.vendorNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRight);
        make.right.mas_equalTo(weakSelf).offset(-leftRight);
        make.centerY.mas_equalTo(weakSelf.mas_bottom).offset(-nameCenterY);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];

    self.logisticsInfoBtn.hidden = YES;
    [self.logisticsInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-leftRight);
        make.centerY.mas_equalTo(weakSelf.vendorNameLB);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(btnH);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)vendorNameLB {
    if (_vendorNameLB == nil) {
        _vendorNameLB = [UILabel new];
        _vendorNameLB.textColor = BlackColor;
        _vendorNameLB.font = UIFont_17;
    }
    return _vendorNameLB;
}

- (UIButton *)logisticsInfoBtn {
    if (_logisticsInfoBtn == nil) {
        _logisticsInfoBtn = [UIButton new];
        _logisticsInfoBtn.titleLabel.font = UIFont_15;
        [_logisticsInfoBtn setTitle:@"物流信息" forState:UIControlStateNormal];
        [_logisticsInfoBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
        [_logisticsInfoBtn addTarget:self
                              action:@selector(clickLogisticsInfoButton)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _logisticsInfoBtn;
}












@end
