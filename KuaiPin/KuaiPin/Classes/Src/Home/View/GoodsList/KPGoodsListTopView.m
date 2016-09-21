//
//  KPGoodsListTopView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGoodsListTopView.h"

@interface KPGoodsListTopView ()

@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) KPButton *salesBtn;
@property (nonatomic, weak) KPButton *priceBtn;
@end

@implementation KPGoodsListTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = ClearColor;
        
        KPButton *salesBtn = [KPButton buttonWithType:UIButtonTypeCustom];
        [salesBtn setTitle:@"销量" forState:UIControlStateNormal];
        [salesBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
        [salesBtn setTitleColor:GrayColor forState:UIControlStateHighlighted];
        salesBtn.titleLabel.font = UIFont_14;
        [salesBtn addTarget:self action:@selector(salesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:salesBtn];
        self.salesBtn = salesBtn;
        
        KPButton *priceBtn = [KPButton buttonWithType:UIButtonTypeCustom];
        [priceBtn setImage:[UIImage imageNamed:@"goodslist_pricesort_high"] forState:UIControlStateNormal];
        [priceBtn setImage:[UIImage imageNamed:@"goodslist_pricesort_low"] forState:UIControlStateSelected];
        [priceBtn addTarget:self action:@selector(priceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        priceBtn.contentMode = UIViewContentModeCenter;
        priceBtn.adjustsImageWhenHighlighted = NO;
        [self addSubview:priceBtn];
        self.priceBtn = priceBtn;
        
        UIView *line = [UIView line];
        [self addSubview:line];
        self.line = line;
        
    }
    return self;
}


- (void)salesBtnClick:(KPButton *)salesBtn
{
    if ([self.delegate respondsToSelector:@selector(goodsListTopView:didSelectLeftBtn:)]) {
        [self.delegate goodsListTopView:self didSelectLeftBtn:salesBtn];
    }
}
- (void)priceBtnClick:(KPButton *)priceBtn
{
    if (priceBtn.selected == YES) {
        priceBtn.selected = NO;
    }
    else
    {
        priceBtn.selected = YES;
    }
    if ([self.delegate respondsToSelector:@selector(goodsListTopView:didSelectRightBtn:leftBtn:)]) {
        [self.delegate goodsListTopView:self didSelectRightBtn:priceBtn leftBtn:self.salesBtn];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    CGSize salesBtnSize = CGSizeMake(50, 35);
    
    [self.salesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf.mas_centerX).offset(-5);
        make.size.mas_equalTo(salesBtnSize);
    }];
    [self.priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.mas_centerX).offset(15);
        make.size.mas_equalTo(salesBtnSize);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(0.8);
    }];
}

@end
