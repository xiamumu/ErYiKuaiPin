//
//  KPAlreadySoldout.m
//  KuaiPin
//
//  Created by 21_xm on 16/8/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSoldoutView.h"

@interface KPSoldoutView ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UILabel *soldoutLab;

@end

@implementation KPSoldoutView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = ClearColor;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = BlackColor;
        bgView.alpha = 0.4;
        [self addSubview:bgView];
        self.bgView = bgView;
        
        
        UILabel *soldoutLab = [UILabel addLabelWithTitle:@"已售罄" textColor:WhiteColor font:UIFont_18];
        [self addSubview:soldoutLab];
        self.soldoutLab = soldoutLab;
    }
    return self;
}


- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.soldoutLab.font = titleFont;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
 
    __weak typeof (self) weakSelf = self;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    [self.soldoutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf);
    }];
}


@end
