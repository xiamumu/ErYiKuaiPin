//
//  KPBeLeftMoneyHeaderView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBeLeftMoneyHeaderView.h"
#import "KPCommonMarginView.h"

@interface KPBeLeftMoneyHeaderView ()
//@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIImageView *walletIcon;
@property (nonatomic, weak) UILabel *walletLab;
@property (nonatomic, weak) UILabel *moneyLab;
@property (nonatomic, weak) KPButton *takeBackBtn;
@property (nonatomic, weak) KPButton *fillInBtn;

@end

@implementation KPBeLeftMoneyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTopView];
    }
    return self;
}

- (void)setupTopView
{
    self.backgroundColor = WhiteColor;
    
    UIImageView *walletIcon = [[UIImageView alloc] init];
    walletIcon.image = [UIImage imageNamed:@"wallet"];
    [self addSubview:walletIcon];
    self.walletIcon = walletIcon;
    
    UILabel *walletLab = [UILabel addLabelWithTitle:@"我的零钱" textColor:BlackColor font:UIFont_14];
    [self addSubview:walletLab];
    self.walletLab = walletLab;
    
    UILabel *moneyLab = [UILabel addLabelWithTitle:@"￥0.00" textColor:OrangeColor font:UIFont_18];
    [self addSubview:moneyLab];
    self.moneyLab = moneyLab;
    
    KPButton *takeBackBtn = [[KPButton alloc] init];
    takeBackBtn.layer.borderWidth = 1;
    takeBackBtn.layer.borderColor = SeperatorColor.CGColor;
    takeBackBtn.layer.masksToBounds = YES;
    takeBackBtn.layer.cornerRadius = 5;
    [takeBackBtn setTitle:@"提现" forState:UIControlStateNormal];
    [takeBackBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
    takeBackBtn.titleLabel.font = UIFont_18;
    [takeBackBtn addTarget:self action:@selector(takeBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:takeBackBtn];
    self.takeBackBtn = takeBackBtn;
    
//    KPButton *fillInBtn = [[KPButton alloc] init];
//    fillInBtn.layer.masksToBounds = YES;
//    fillInBtn.layer.cornerRadius = 5;
//    [fillInBtn setBackgroundColor:OrangeColor];
//    [fillInBtn setTitle:@"充值" forState:UIControlStateNormal];
//    [fillInBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    fillInBtn.titleLabel.font = UIFont_18;
//    [fillInBtn addTarget:self action:@selector(fillInBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:fillInBtn];
    //    self.fillInBtn = fillInBtn;   __weak typeof (self) weakSelf = self;
    
    
    __weak typeof (self) weakSelf = self;
    [self.walletIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).offset(CommonMargin * 2);
        make.centerX.mas_equalTo(weakSelf);
        make.size.mas_equalTo(weakSelf.walletIcon.image.size);
    }];
    
    CGFloat waletLabH = [self.walletLab.text sizeWithAttributes:@{NSFontAttributeName: self.walletLab.font}].height;
    [self.walletLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.walletIcon.mas_bottom).offset(CommonMargin);
        make.centerX.mas_equalTo(weakSelf);
        make.height.mas_equalTo(waletLabH);
    }];
    
    CGFloat moneyLabH = [self.moneyLab.text sizeWithAttributes:@{NSFontAttributeName: self.moneyLab.font}].height;
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.walletLab.mas_bottom).offset(CommonMargin);
        make.centerX.mas_equalTo(weakSelf);
        make.height.mas_equalTo(moneyLabH);
    }];
    
    [self.takeBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin * 2);
        make.centerX.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(100, 32));
    }];
    
    //    [self.takeBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.mas_equalTo(weakSelf.topView.mas_bottom).offset(-CommonMargin * 2);
    //        make.right.mas_equalTo(weakSelf.topView.mas_centerX).offset(-25);
    //        make.size.mas_equalTo(CGSizeMake(100, 32));
    //    }];
    
    //    [self.fillInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.mas_equalTo(weakSelf.topView.mas_bottom).offset(-CommonMargin * 2);
    //        make.left.mas_equalTo(weakSelf.topView.mas_centerX).offset(25);
    //        make.size.mas_equalTo(weakSelf.takeBackBtn);
    //    }];
    
    
}

- (void)setBalance:(NSNumber *)balance
{
    _balance = balance;
    
    self.moneyLab.text = balance? [NSString stringWithFormat:@"￥ %.2f",balance.floatValue]: @"￥ 0.00";
}

// 取现点击事件
- (void)takeBackBtnAction
{
    NSPostNote(Noti_TakeBackMoney, nil)
}
// 充值点击事件
- (void)fillInBtnAction
{
    NSPostNote(Noti_FillInMoney, nil)
}



@end
