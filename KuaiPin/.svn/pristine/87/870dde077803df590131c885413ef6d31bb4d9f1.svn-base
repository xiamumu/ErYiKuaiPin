//
//  KPSubsidizeSectionHeaderView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSubsidizeSectionHeaderView.h"
#import "KPSelecteGoodButton.h"

@interface KPSubsidizeSectionHeaderView ()

@property (nonatomic, strong) KPSelecteGoodButton *selectedAllBtn;

@property (nonatomic, strong) UILabel *vendorNameLB;

@property (nonatomic, strong) UIView *topSep;

@end

@implementation KPSubsidizeSectionHeaderView

#pragma mark - 类方法
+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPSubsidizeSectionHeaderView";
    
    KPSubsidizeSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (headerView == nil) {
        headerView = [[KPSubsidizeSectionHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return headerView;
    
}

+ (CGFloat)headerViewHeight {
    return 39;
}

#pragma mark - 点击事件
- (void)clickSelectedAllButton {

    self.selectedAllBtn.selected = !self.selectedAllBtn.selected;
    
    NSString *selectedState = nil;
    
    if (self.selectedAllBtn.selected) {
        selectedState = GoodSelectedStateSelected;
    }else {
        selectedState = GoodSelectedStateUnSelected;
    }

    NSPostNoteWithUserInfo(Noti_SelectedVendorAllGoodsBtnAction, self.vendorModel, @{GoodSelectedStateKey : selectedState})
}

#pragma mark - 重写set方法
- (void)setVendorModel:(KPVendorModel *)vendorModel {
    _vendorModel = vendorModel;
    
    self.vendorNameLB.text = self.vendorModel.storeName;
    
    [self.vendorModel.items enumerateObjectsUsingBlock:^(KPGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (!obj.selected && obj.selecteEnable) {
            self.selectedAllBtn.selected = NO;
            *stop = YES;
            return;
        }
        
        self.selectedAllBtn.selected = YES;
    }];

    self.selectedAllBtn.enabled = self.vendorModel.vendorSelecteEnable;
    
}

- (void)setShouldShowTopSeperator:(BOOL)shouldShowTopSeperator {
    _shouldShowTopSeperator = shouldShowTopSeperator;
    
    self.topSep.hidden = !shouldShowTopSeperator;
}

#pragma mark - 初始化
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupUI {
    
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = WhiteColor;
    
    KPSeparatorView *bottomSep = [KPSeparatorView new];
    
    [self addSubview:self.selectedAllBtn];
    [self addSubview:self.vendorNameLB];
    [self addSubview:self.topSep];
    [self addSubview:bottomSep];
    
    __weak typeof(self) weakSelf = self;
    CGFloat selectedW = 31;
    CGFloat selectedH = 38;
    [self.selectedAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(weakSelf);
        make.width.mas_equalTo(selectedW);
        make.height.mas_equalTo(selectedH);
    }];
    
    [self.vendorNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.selectedAllBtn.mas_right);
        make.top.mas_equalTo(weakSelf);
        make.height.mas_equalTo(weakSelf.selectedAllBtn);
    }];
    
    CGFloat sepH = 1;
    [self.topSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];
    
    CGFloat bottomH = 1;
    [bottomSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(bottomH);
    }];
    
}

#pragma mark - 懒加载
- (KPSelecteGoodButton *)selectedAllBtn {
    if (_selectedAllBtn == nil) {
        _selectedAllBtn = [KPSelecteGoodButton selecteGoodButtonWithType:KPSelecteGoodButtonTypeVendorSelectedAll];
        [_selectedAllBtn addTarget:self action:@selector(clickSelectedAllButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedAllBtn;
}

- (UILabel *)vendorNameLB {
    if (_vendorNameLB == nil) {
        _vendorNameLB = [UILabel new];
        _vendorNameLB.font = UIFont_15;
        _vendorNameLB.text = @"二一快品";
    }
    return _vendorNameLB;
}

- (UIView *)topSep {
    if (_topSep == nil) {
        _topSep = [UIView new];
        _topSep.backgroundColor = SeperatorColor;
        _topSep.hidden = YES;
    }
    return _topSep;
}

@end
