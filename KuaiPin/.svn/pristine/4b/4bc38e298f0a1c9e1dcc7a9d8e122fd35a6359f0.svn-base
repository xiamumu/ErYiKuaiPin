//
//  KPPayPwdView.m
//  KuaiPin
//
//  Created by 21_xm on 16/8/24.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayPwdView.h"
#import "KPPayPwdTextField.h"


@interface KPPayPwdView ()

@property (nonatomic, weak) UIView *subView;
@property (nonatomic, weak) UIView *cover;
@property (nonatomic, weak) UILabel *titleText;
@property (nonatomic, weak) KPButton *cancleBtn;
@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UILabel *subTitle;
@property (nonatomic, weak) UILabel *moneyLab;
@property (nonatomic, weak) UIView *line2;
@property (nonatomic, weak) UIView *line3;
@property (nonatomic, weak) KPPayPwdTextField *pwdTf;
@end


@implementation KPPayPwdView

- (void)setTotalPrice:(NSString *)totalPrice {
    _totalPrice = [totalPrice copy];
    self.moneyLab.text = [NSString stringWithFormat:@"￥%@", totalPrice];
}

+ (instancetype)payPwdView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ClearColor;
        
        
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = BlackColor;
        cover.alpha = 0.5;
        [self addSubview:cover];
        self.cover = cover;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [cover addGestureRecognizer:tap];
        
        UIView *subView = [[UIView alloc] init];
        subView.backgroundColor = WhiteColor;
        subView.layer.masksToBounds = YES;
        subView.layer.cornerRadius = 10;
        [self addSubview:subView];
        self.subView = subView;
        
        UILabel *titleText = [UILabel addLabelWithTitle:@"请输入支付密码" textColor:BlackColor font:UIFont_18];
        [self addSubview:titleText];
        self.titleText = titleText;
        
        KPButton *cancleBtn = [[KPButton alloc] init];
        [cancleBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancleBtn];
        self.cancleBtn = cancleBtn;
        
        UIView *line1 = [UIView line];
        line1.backgroundColor = OrangeColor;
        [self addSubview:line1];
        self.line1 = line1;
        
        UILabel *subTitle = [UILabel addLabelWithTitle:@"支付金额" textColor:HexColor(#8a8a8a) font:UIFont_16];
        [self addSubview:subTitle];
        self.subTitle = subTitle;
        
        UILabel *moneyLab = [UILabel addLabelWithTitle:@"￥0.00" textColor:OrangeColor font:UIFont_30];
        [self addSubview:moneyLab];
        self.moneyLab = moneyLab;
        
        UIView *line2 = [UIView line];
        [self addSubview:line2];
        self.line2 = line2;
        
        KPPayPwdTextField *pwdTf = [[KPPayPwdTextField alloc] init];
        __weak typeof(self) weakSelf = self;
        [pwdTf setInputCompletion:^(NSString *payPwd) {
            if (weakSelf.completion) {
                weakSelf.completion(payPwd);
            }
        }];
        [pwdTf becomeFirstResponder];
        [self addSubview:pwdTf];
        self.pwdTf = pwdTf;
        
    }
    return self;
}


- (void)cancleBtnAction
{
    [self removeFromSuperview];
}
- (void)removeSelf
{
    [self removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf).offset(100);
        make.size.mas_equalTo(CGSizeMake(280, 250));
    }];
    
    CGFloat titleTextH = [self.titleText.text sizeWithAttributes:@{NSFontAttributeName: self.titleText.font}].height;
    CGFloat top = (50 - titleTextH) * 0.5;
    [self.titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.subView).offset(top);
        make.height.mas_equalTo(titleTextH);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.subView).offset(15);
        make.top.mas_equalTo(weakSelf.subView).offset(15);
        make.size.mas_equalTo(weakSelf.cancleBtn.currentBackgroundImage.size);
    }];

    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.subView);
        make.bottom.mas_equalTo(weakSelf.subView.mas_top).offset(50);
        make.height.mas_equalTo(1);
    }];

    CGFloat subTitleH = [self.subTitle.text sizeWithAttributes:@{NSFontAttributeName: self.subTitle.font}].height;
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.line1.mas_bottom).offset(CommonMargin * 2);
        make.height.mas_equalTo(subTitleH);
    }];

    CGFloat moneyLabH = [self.moneyLab.text sizeWithAttributes:@{NSFontAttributeName: self.moneyLab.font}].height;
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.subTitle.mas_bottom).offset(13);
        make.height.mas_equalTo(moneyLabH);
    }];

    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.subView).offset(CommonMargin);
        make.right.mas_equalTo(weakSelf.subView).offset(-CommonMargin);
        make.bottom.mas_equalTo(weakSelf.moneyLab.mas_bottom).offset(CommonMargin * 2);
        make.height.mas_equalTo(1);
    }];

    CGFloat pwdTfMargin = (280 - 240) * 0.5;
    [self.pwdTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.subView).offset(pwdTfMargin);
        make.right.mas_equalTo(weakSelf.subView).offset(-pwdTfMargin);
        make.top.mas_equalTo(weakSelf.line2.mas_bottom).offset(CommonMargin * 3);
        make.size.mas_equalTo(CGSizeMake(240, 40));
    }];
    
}

@end

