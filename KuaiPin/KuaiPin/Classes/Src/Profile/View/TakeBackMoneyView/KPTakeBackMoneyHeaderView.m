//
//  KPTakeBackMoneyHeaderView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPTakeBackMoneyHeaderView.h"
#import "KPCommonTextField.h"
#import "KPCommonMarginView.h"

@interface KPTakeBackMoneyHeaderView ()

@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UILabel *fillInMoneyLab;
@property (nonatomic, weak) KPCommonMarginView *marginView;
@property (nonatomic, weak) KPCommonTextField *textField;
@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UIView *line2;

@end
@implementation KPTakeBackMoneyHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ClearColor;
        
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = WhiteColor;
        [self addSubview:topView];
        self.topView = topView;
        
        UILabel *fillInMoneyLab = [UILabel addLabelWithTitle:@"" textColor:BlackColor font:UIFont_14];
        [topView addSubview:fillInMoneyLab];
        self.fillInMoneyLab = fillInMoneyLab;
        
        KPCommonTextField *textField = [[KPCommonTextField alloc] init];
        textField.title = @"￥";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [topView addSubview:textField];
        self.textField = textField;
        
        KPCommonMarginView *marginView = [[KPCommonMarginView alloc] init];
        [self addSubview:marginView];
        self.marginView = marginView;
        
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = SeperatorColor;
        [self addSubview:line1];
        self.line1 = line1;
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = SeperatorColor;
        [self addSubview:line2];
        self.line2 = line2;
    }
    return self;
}
- (void)setTakeBackVc:(BOOL)takeBackVc
{
    _takeBackVc = takeBackVc;
    if (takeBackVc) {
        self.textField.placeholder = @"提现金额不能超过余额金额";
        self.fillInMoneyLab.text = @"余额提现";
        self.marginView.title = @"提现到";
    }
    else
    {
        self.textField.placeholder = @"请输入充值金额";
        self.fillInMoneyLab.text = @"余额充值";
        self.marginView.title = @"充值方式";
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [self.marginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(35);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.marginView.mas_top);
    }];
    
    CGFloat fillInMoneyLabH = [self.fillInMoneyLab.text sizeWithAttributes:@{NSFontAttributeName: self.fillInMoneyLab.font}].height;
    [self.fillInMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).offset(CommonMargin * 2);
        make.left.mas_equalTo(weakSelf).offset(CommonMargin);
        make.height.mas_equalTo(fillInMoneyLabH);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.fillInMoneyLab.mas_bottom);
        make.height.mas_equalTo(53);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.marginView.mas_top);
        make.height.mas_equalTo(1);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
    
}

@end
