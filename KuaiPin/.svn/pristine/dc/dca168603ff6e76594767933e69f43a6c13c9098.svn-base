//
//  KPDiscoveryCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPDiscoverCell.h"

@interface KPDiscoverCell ()

//@property (nonatomic, strong) UILabel *timeLB;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UILabel *detailLB;

@property (nonatomic, strong) KPDiscoverModel *discoveryModel;

@property (nonatomic, strong) UIImage *placeImg;

@end

@implementation KPDiscoverCell

- (void)setModel:(KPBaseModel *)model {
    super.model = model;
    self.discoveryModel = (KPDiscoverModel *)model;
    
    self.iconView.image = self.discoveryModel.iconImg;
    self.titleLB.text = self.discoveryModel.summary;
    
}

+ (CGFloat)cellHeight {
    return 249;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"KPDiscoverCell";
    
    KPDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPDiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = ViewBgColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:self.bgView];
    [self addSubview:self.iconView];
    [self addSubview:self.titleLB];
    [self addSubview:self.detailLB];
    [self addSubview:sep];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat iconLeftRightTop = 9;
    CGFloat titleTop = 12;
    CGFloat titleH = 40;
    CGFloat sepTop = 60;
    CGFloat sepH = 1;
    CGFloat detaileCenterY = 19.5;
    CGFloat detailH = 15;
    CGFloat leftRihgt = 9;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRihgt);
        make.right.mas_equalTo(weakSelf).offset(-leftRihgt);
        make.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.mas_top).offset(iconLeftRightTop);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bgView).offset(iconLeftRightTop);
        make.right.mas_equalTo(weakSelf.bgView).offset(-iconLeftRightTop);
        make.top.mas_equalTo(weakSelf.iconView.mas_bottom).offset(titleTop);
        make.height.mas_equalTo(titleH);
    }];
    
    [self.detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.titleLB);
        make.centerY.mas_equalTo(weakSelf.mas_bottom).offset(-detaileCenterY);
        make.height.mas_equalTo(detailH);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.titleLB);
        make.top.mas_equalTo(weakSelf.iconView.mas_bottom).offset(sepTop);
        make.height.mas_equalTo(sepH);
        make.bottom.mas_equalTo(weakSelf.detailLB.mas_top).offset(-11);
    }];
    
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = WhiteColor;
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [UIImageView new];
    }
    return _iconView;
}

- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.font = UIFont_16;
        _titleLB.textColor = GrayColor;
        _titleLB.numberOfLines = 2;
    }
    return _titleLB;
}

- (UILabel *)detailLB {
    if (_detailLB == nil) {
        _detailLB = [UILabel new];
        _detailLB.text = @"查看详情";
        _detailLB.font = UIFont_15;
        _detailLB.textColor = BlackColor;
    }
    return _detailLB;
}

- (UIImage *)placeImg {
    if (_placeImg == nil) {
        _placeImg = [UIImage imageNamed:@"find_Placeholder"];
    }
    return _placeImg;
}















@end
