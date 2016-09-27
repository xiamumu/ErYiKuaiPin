//
//  KPChooseProductPriceView.m
//  KuaiPin
//
//  Created by 21_xm on 16/9/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPChooseProductPriceView.h"

@interface KPChooseProductPriceView ()

@property (nonatomic, weak) UILabel *priceLab;

@property (nonatomic, weak) UIView *topLine;

@end

@implementation KPChooseProductPriceView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UILabel *GPrrceLab = [UILabel addLabelWithTitle:@"G价：" textColor:HexColor(8a8a8a) font:UIFont_15];
        [self addSubview:GPrrceLab];
        
        UILabel *priceLab = [UILabel addLabelWithTitle:@"￥0" textColor:OrangeColor font:UIFont_15];
        [self addSubview:priceLab];
        self.priceLab = priceLab;
        
        __weak typeof (self) weakSelf = self;
        [GPrrceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).offset(12);
            make.top.mas_equalTo(weakSelf).offset(17);
        }];
        
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(GPrrceLab.mas_right).offset(12);
            make.top.mas_equalTo(GPrrceLab);
        }];
        
        UIView *topLine = [UIView line];
        [self addSubview:topLine];
        self.topLine = topLine;
        
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(CommonMargin);
            make.right.mas_equalTo(self).offset(-CommonMargin);
            make.height.mas_equalTo(1);
        }];

    }
    return self;
}
- (void)setPrice:(NSString *)price
{
    _price = [price copy];
    if (price) {
        self.priceLab.text = [NSString stringWithFormat:@"￥%@", price];
    }
}

@end
