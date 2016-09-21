//
//  KPGoodsListBottomView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGoodsListBottomView.h"

@interface KPGoodsListBottomView ()

@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) KPButton *buyBtn;
@property (nonatomic, weak) KPButton *goodsCarBtn;
@property (nonatomic, weak) UILabel *amountLab;
@property (nonatomic, weak) UILabel *amountMoneyLab;

@end
@implementation KPGoodsListBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        bottomView.frame = CGRectMake(0, SCREEN_H - 49 - 64, SCREEN_W, 49);
        self.backgroundColor = ClearColor;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = SeperatorColor;
        [self addSubview:line];
        self.line = line;
        
        KPButton *buyBtn = [KPButton buttonWithType:UIButtonTypeCustom];
        buyBtn.backgroundColor = OrangeColor;
        [buyBtn setTitle:@"去支付赢美银" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyBtn.titleLabel.font = UIFont_16;
        [buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buyBtn];
        self.buyBtn = buyBtn;
        
        KPButton *goodsCarBtn = [KPButton buttonWithType:UIButtonTypeCustom];
        [goodsCarBtn setBackgroundImage:[UIImage imageNamed:@"goodslist_bottom_cart"] forState:UIControlStateNormal];
        [goodsCarBtn addTarget:self action:@selector(goodsCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        goodsCarBtn.adjustsImageWhenHighlighted = NO;
        [self addSubview:goodsCarBtn];
        self.goodsCarBtn = goodsCarBtn;
        
        UILabel *amountLab = [[UILabel alloc] init];
        amountLab.backgroundColor = ClearColor;
        amountLab.textColor = BlackColor;
        amountLab.font = UIFont_15;
        amountLab.text = @"合计: ";
        [self addSubview:amountLab];
        self.amountLab = amountLab;
        
        UILabel *amountMoneyLab = [[UILabel alloc] init];
        amountMoneyLab.backgroundColor = ClearColor;
        amountMoneyLab.textColor = LightRedColor;
        amountMoneyLab.font = UIFont_15;
        amountMoneyLab.text = @"￥1314";
        [self addSubview:amountMoneyLab];
        self.amountMoneyLab = amountMoneyLab;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    CGSize goodsCarBtnSize = self.goodsCarBtn.currentBackgroundImage.size;
    CGSize amountLabSize = [self.amountLab.text sizeWithAttributes:@{NSFontAttributeName: self.amountLab.font}];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(weakSelf);
        make.height.mas_equalTo(0.5);
    }];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(123);
    }];
    [self.goodsCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(12);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(goodsCarBtnSize);
    }];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsCarBtn.mas_right).offset(34);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(amountLabSize);
    }];
    [self.amountMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.amountLab.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(30);
    }];
}

- (void)goodsCarBtnClick:(KPButton *)goodsCarBtn
{
    WHYNSLog(@"到购物车查看");
}

- (void)buyBtnClick:(KPButton *)buyBtn
{
    WHYNSLog(@"去结算");
}
@end
