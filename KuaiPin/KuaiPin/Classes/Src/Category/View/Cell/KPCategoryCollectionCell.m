//
//  KPCategoryCollectionCell.m
//  KuaiPin
//
//  Created by 王洪运 on 2016/9/23.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCategoryCollectionCell.h"

@interface KPCategoryCollectionCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UILabel *updateLB;

@end

@implementation KPCategoryCollectionCell

- (void)setCellModel:(KPCategoryModel *)cellModel {
    _cellModel = cellModel;

    NSURL *imageUrl = [NSURL URLWithString:cellModel.imageSrc];
    [self.iconView sd_setImageWithURL:imageUrl
                     placeholderImage:[UIImage imageNamed:@"category_placeholder"]];
    self.titleLB.text = cellModel.name;
    self.updateLB.text = [NSString stringWithFormat:@"更新 %zd 款快品", cellModel.update.integerValue];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.backgroundColor = WhiteColor;

    [self addSubview:self.iconView];
    [self addSubview:self.titleLB];
    [self addSubview:self.updateLB];

    __weak typeof(self) weakSelf = self;

    CGFloat iconH = ScaleHeight(73);
    CGFloat titleTop = 10;
    CGFloat titleH = 17;
    CGFloat updateTop = 8;
    CGFloat updateH = 14;

    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(iconH);
    }];

    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.iconView.mas_bottom).offset(titleTop);
        make.centerX.mas_equalTo(weakSelf.iconView);
        make.height.mas_equalTo(titleH);
    }];

    [self.updateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLB.mas_bottom).offset(updateTop);
        make.centerX.mas_equalTo(weakSelf.titleLB);
        make.height.mas_equalTo(updateH);
    }];

}

+ (CGSize)cellSize {
    CGFloat w = (SCREEN_W - 33) * 0.5;
    CGFloat h = 49 + ScaleHeight(73);
    return CGSizeMake(w, h);
}

+ (NSString *)cellIdentifier {
    return @"KPCategoryCollectionCell";
}

#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [UIImageView new];
        _iconView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconView;
}

- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.textColor = BlackColor;
        _titleLB.font = UIFont_15;
    }
    return _titleLB;
}

- (UILabel *)updateLB {
    if (_updateLB == nil) {
        _updateLB = [UILabel new];
        _updateLB.textColor = GrayColor;
        _updateLB.font = UIFont_12;
    }
    return _updateLB;
}

@end
