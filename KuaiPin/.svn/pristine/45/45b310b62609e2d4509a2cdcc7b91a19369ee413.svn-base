//
//  KPOrderNumberCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderNumberCell.h"

@interface KPOrderNumberCell ()

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UILabel *orderNumberLB;

@property (nonatomic, strong) UILabel *orderStateLB;

@end

@implementation KPOrderNumberCell

- (void)setOrderSn:(NSNumber *)orderSn {
    _orderSn = orderSn;
    self.orderNumberLB.text = [NSString stringWithFormat:@"%@", orderSn];
}

- (void)setOrderState:(NSNumber *)orderState {
    _orderState = orderState;
    
    NSString *orderStateStr;
    
    switch (orderState.integerValue) {
        case 0:
            orderStateStr = @"已取消";
            break;
        case 10:
            orderStateStr = @"待付款";
            break;
        case 20:
            orderStateStr = @"待发货";
            break;
        case 30:
            orderStateStr = @"已发货";
            break;
        case 40:
            orderStateStr = @"已收货";
            break;
        default:
            break;
    }
    
    self.orderStateLB.text = orderStateStr;
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPOrderNumberCell";
    
    KPOrderNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPOrderNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

+ (CGFloat)cellHeight {
    return 40;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    [self addSubview:self.titleLB];
    [self addSubview:self.orderNumberLB];
    [self addSubview:self.orderStateLB];
    
    __weak typeof(self) weakSelf = self;
    CGFloat leftRight = 9;
    CGFloat textH = 16;
    CGFloat titleH = [self.titleLB.text sizeWithAttributes:@{NSFontAttributeName : self.titleLB.font}].width;
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRight);
        make.centerY.mas_equalTo(weakSelf);
        make.width.mas_equalTo(titleH);
        make.height.mas_equalTo(textH);
    }];
    
    [self.orderNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLB.mas_right);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(textH);
    }];
    
    [self.orderStateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-leftRight);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(textH);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.font = UIFont_16;
        _titleLB.textColor = BlackColor;
        _titleLB.text = @"订单号：";
    }
    return _titleLB;
}

- (UILabel *)orderNumberLB {
    if (_orderNumberLB == nil) {
        _orderNumberLB = [UILabel new];
        _orderNumberLB.font = UIFont_16;
        _orderNumberLB.textColor = BlackColor;
    }
    return _orderNumberLB;
}

- (UILabel *)orderStateLB {
    if (_orderStateLB == nil) {
        _orderStateLB = [UILabel new];
        _orderStateLB.font = UIFont_16;
        _orderStateLB.textColor = OrangeColor;
    }
    return _orderStateLB;
}

@end
