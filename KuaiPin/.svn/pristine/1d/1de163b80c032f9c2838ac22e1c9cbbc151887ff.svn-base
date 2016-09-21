//
//  KPTakeBackMoneyCellContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPTakeBackMoneyCellContentView.h"
#import "KPBankCardModel.h"

@interface KPTakeBackMoneyCellContentView ()
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) KPButton *chooseIcon;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIView *line;

@end
@implementation KPTakeBackMoneyCellContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"weChatPay"];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        UILabel *title = [UILabel addLabelWithTitle:@"银行卡" textColor:BlackColor font:UIFont_14];
        [self addSubview:title];
        self.title = title;
        
        KPButton *chooseIcon = [[KPButton alloc] init];
        [chooseIcon setBackgroundImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];
        [chooseIcon setBackgroundImage:[UIImage imageNamed:@"cart_select"] forState:UIControlStateSelected];
        [self addSubview:chooseIcon];
        self.chooseIcon = chooseIcon;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = SeperatorColor;
        [self addSubview:line];
        self.line = line;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.chooseIcon.selected = selected;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(weakSelf.imgView.image.size);
    }];
    
    CGFloat titleH = [weakSelf.title.text sizeWithAttributes:@{NSFontAttributeName: self.title.font}].height;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imgView.mas_right).offset(CommonMargin);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(titleH);
    }];
    
    [self.chooseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(weakSelf.chooseIcon.currentBackgroundImage.size);
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
}


- (void)setCard:(KPBankCardModel *)card
{
    _card = card;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:card.imgStr]
                     placeholderImage:[UIImage imageNamed:@"bank_placeHolder"]];
    self.title.text = card.bankName;
}
@end
