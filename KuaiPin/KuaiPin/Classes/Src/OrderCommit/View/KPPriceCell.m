//
//  KPPriceCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPriceCell.h"

@interface KPPriceCell ()

@property (nonatomic, strong) UILabel *priceTitleLB;

@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) UILabel *freightTitleLB;

@property (nonatomic, strong) UILabel *freightLB;

@property (nonatomic, strong) UILabel *actualPriceTitleLB;

@property (nonatomic, strong) UILabel *actualPriceLB;

@end

@implementation KPPriceCell

- (void)setFreight:(CGFloat)freight {
	_freight = freight;
    
    self.freightLB.text = [NSString stringWithFormat:@"￥%.2f", freight];
    self.actualPriceLB.text = [NSString stringWithFormat:@"￥%.2f", (self.freight+self.totalPrice)];
}

- (void)setTotalPrice:(CGFloat)totalPrice {
	_totalPrice = totalPrice;
    
    self.priceLB.text = [NSString stringWithFormat:@"￥%.2f", totalPrice];
    self.actualPriceLB.text = [NSString stringWithFormat:@"￥%.2fd", (self.freight+self.totalPrice)];
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPPriceCell";
    
    KPPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

+ (CGFloat)cellHeight {
    return 99;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:self.priceTitleLB];
    [self addSubview:self.priceLB];
    [self addSubview:self.freightTitleLB];
    [self addSubview:self.freightLB];
    [self addSubview:self.actualPriceTitleLB];
    [self addSubview:self.actualPriceLB];
    [self addSubview:sep];
    
    __weak typeof(self) weakSelf = self;
    CGFloat leftRight = 9;
    CGFloat priceTop = 13;
    CGFloat freightTop = 12;
    CGFloat sepTop = 63;
    CGFloat sepH = 1;
    CGFloat actualCenterY = 19;
    CGFloat titleW =70;
    CGFloat textH = 14;
    
    [self.priceTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRight);
        make.top.mas_equalTo(weakSelf).offset(priceTop);
        make.height.mas_equalTo(textH);
        make.width.mas_equalTo(titleW);
    }];
    
    [self.freightTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.priceTitleLB);
        make.top.mas_equalTo(weakSelf.priceTitleLB.mas_bottom).offset(freightTop);
        make.size.mas_equalTo(weakSelf.priceTitleLB);
    }];
    
    [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-leftRight);
        make.centerY.mas_equalTo(weakSelf.priceTitleLB);
        make.left.mas_equalTo(weakSelf.priceTitleLB.mas_right);
        make.height.mas_equalTo(weakSelf.priceTitleLB);
    }];
    
    [self.freightLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.priceLB);
        make.centerY.mas_equalTo(weakSelf.freightTitleLB);
        make.left.mas_equalTo(weakSelf.freightTitleLB.mas_right);
        make.height.mas_equalTo(weakSelf.priceTitleLB);
    }];
    
    [self.actualPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.priceLB);
        make.centerY.mas_equalTo(weakSelf.mas_bottom).offset(-actualCenterY);
        make.height.mas_equalTo(weakSelf.priceTitleLB);
    }];
    
    [self.actualPriceTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(weakSelf.actualPriceLB);
        make.right.mas_equalTo(self.actualPriceLB.mas_left);
        make.width.mas_equalTo(titleW);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.priceTitleLB);
        make.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf).offset(sepTop);
        make.height.mas_equalTo(sepH);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)priceTitleLB {
    if (_priceTitleLB == nil) {
        _priceTitleLB = [UILabel new];
        _priceTitleLB.font = UIFont_14;
        _priceTitleLB.textColor = BlackColor;
        _priceTitleLB.text = @"商品金额";
    }
    return _priceTitleLB;
}

- (UILabel *)priceLB {
    if (_priceLB == nil) {
        _priceLB = [UILabel new];
        _priceLB.font = UIFont_14;
        _priceLB.textColor = LightRedColor;
        _priceLB.textAlignment = NSTextAlignmentRight;
    }
    return _priceLB;
}

- (UILabel *)freightTitleLB {
    if (_freightTitleLB == nil) {
        _freightTitleLB = [UILabel new];
        _freightTitleLB.font = UIFont_14;
        _freightTitleLB.textColor = BlackColor;
        _freightTitleLB.text = @"运费";
    }
    return _freightTitleLB;
}

- (UILabel *)freightLB {
    if (_freightLB == nil) {
        _freightLB = [UILabel new];
        _freightLB.font = UIFont_14;
        _freightLB.textColor = LightRedColor;
        _freightLB.textAlignment = NSTextAlignmentRight;
    }
    return _freightLB;
}

- (UILabel *)actualPriceTitleLB {
    if (_actualPriceTitleLB == nil) {
        _actualPriceTitleLB = [UILabel new];
        _actualPriceTitleLB.font = UIFont_14;
        _actualPriceTitleLB.textColor = BlackColor;
        _actualPriceTitleLB.text = @"实付金额：";
    }
    return _actualPriceTitleLB;
}

- (UILabel *)actualPriceLB {
    if (_actualPriceLB == nil) {
        _actualPriceLB = [UILabel new];
        _actualPriceLB.font = UIFont_14;
        _actualPriceLB.textColor = LightRedColor;
    }
    return _actualPriceLB;
}






















@end
