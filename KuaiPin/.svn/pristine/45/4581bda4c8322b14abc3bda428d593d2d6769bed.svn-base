//
//  KPBankCardCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBankCardCell.h"
#import "KPBankCardModel.h"
#import <UIImageView+WebCache.h>


@interface KPBankCardCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *cardNameLB;

@property (nonatomic, strong) UILabel *trailNumberLB;

@property (nonatomic, strong) UILabel *cardTypeLB;

@property (nonatomic, strong) KPBankCardModel *bankCardModel;

@end

@implementation KPBankCardCell



- (void)setModel:(__kindof KPBaseModel *)model {
    
    super.model = model;
    
    self.bankCardModel = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.bankCardModel.imgStr]
                     placeholderImage:[UIImage imageNamed:@"bank_placeHolder"]];
    self.cardNameLB.text = self.bankCardModel.bankName;
    self.trailNumberLB.text = [NSString stringWithFormat:@"尾号%@", self.bankCardModel.trailNumber];
    self.cardTypeLB.text = self.bankCardModel.cardtype;
    
}


+(instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPBankCardCell";
    
    KPBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPBankCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

+ (CGFloat)cellHeight {
    return 75;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
-(void)setupUI {
    
    self.editingAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 56, 100)];
    self.editingAccessoryView.backgroundColor = RandomColor;
    
    self.backgroundColor = WhiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.iconView];
    [self addSubview:self.cardNameLB];
    [self addSubview:self.trailNumberLB];
    [self addSubview:self.cardTypeLB];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat left = 9;
    CGFloat top = 17;
    CGFloat labelLeft = 17;
    CGFloat labelMargin = 12;
    CGFloat nameH = 16;
    CGFloat labelH = 14;
    CGFloat iconWH = 39;
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(left);
        make.centerY.mas_equalTo(weakSelf);
        make.height.width.mas_equalTo(iconWH);
    }];
    
    [self.cardNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).offset(top);
        make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(labelLeft);
        make.height.mas_equalTo(nameH);
    }];
    
    [self.trailNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.cardNameLB);
        make.top.mas_equalTo(weakSelf.cardNameLB.mas_bottom).offset(labelMargin);
        make.height.mas_equalTo(labelH);
    }];
    
    [self.cardTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.trailNumberLB.mas_right).offset(labelLeft);
        make.top.mas_equalTo(weakSelf.trailNumberLB);
        make.height.mas_equalTo(labelH);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [UIImageView new];
    }
    return _iconView;
}

- (UILabel *)cardNameLB {
    if (_cardNameLB == nil) {
        _cardNameLB = [UILabel new];
        _cardNameLB.font = UIFont_16;
        _cardNameLB.textColor = BlackColor;
    }
    return _cardNameLB;
}

- (UILabel *)trailNumberLB {
    if (_trailNumberLB == nil) {
        _trailNumberLB = [UILabel new];
        _trailNumberLB.font = UIFont_14;
        _trailNumberLB.textColor = GrayColor;
    }
    return _trailNumberLB;
}

- (UILabel *)cardTypeLB {
    if (_cardTypeLB == nil) {
        _cardTypeLB = [UILabel new];
        _cardTypeLB.font = UIFont_14;
        _cardTypeLB.textColor = GrayColor;
    }
    return _cardTypeLB;
}

@end
