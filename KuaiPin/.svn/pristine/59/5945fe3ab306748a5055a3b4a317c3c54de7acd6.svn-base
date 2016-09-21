//
//  KPPayBackContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayBackContentView.h"
#import "KPPayBackRowData.h"
@interface KPPayBackContentView ()
@property (nonatomic, weak) UIImageView *img;
@property (nonatomic, weak) UILabel *orderNum;
@property (nonatomic, weak) UILabel *orderBeginTime;
@property (nonatomic, weak) UILabel *commonLab;

@property (nonatomic, strong) UILabel *payBackMoney;
@property (nonatomic, strong) UIImageView *finishPayBackImg;
@property (nonatomic, strong) UIButton *canPayBackBtn;

@end
@implementation KPPayBackContentView
#pragma mark - 懒加载
- (UILabel *)payBackMoney
{
    if (_payBackMoney == nil) {
        _payBackMoney = [[UILabel alloc] init];
        _payBackMoney.textAlignment = NSTextAlignmentLeft;
        _payBackMoney.textColor = RedColor;
        _payBackMoney.font = UIFont_15;
        _payBackMoney.text = @"￥998.00";
    }
    return _payBackMoney;
}

- (UIButton *)canPayBackBtn
{
    if (_canPayBackBtn == nil) {
        _canPayBackBtn = [[UIButton alloc] init];
        [_canPayBackBtn setBackgroundColor:OrangeColor];
        _canPayBackBtn.layer.masksToBounds = YES;
        _canPayBackBtn.layer.cornerRadius = 5;
        [_canPayBackBtn setTitle:@"申请贴现" forState:UIControlStateNormal];
        [_canPayBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _canPayBackBtn.titleLabel.font = UIFont_15;
        [_canPayBackBtn addTarget:self action:@selector(payBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canPayBackBtn;
}
- (UIImageView *)finishPayBackImg
{
    if (_finishPayBackImg == nil) {
        _finishPayBackImg = [[UIImageView alloc] init];
        _finishPayBackImg.image = [UIImage imageNamed:@"paybackicon"];
    }
    return _finishPayBackImg;
}
#pragma mark - 基础设置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"tiexian"];
        [self addSubview:img];
        self.img = img;
        
        UILabel *orderNum = [[UILabel alloc] init];
        orderNum.textAlignment = NSTextAlignmentLeft;
        orderNum.textColor = HexColor(#191919);
        orderNum.font = UIFont_14;
//        orderNum.text = @"订单号：12345678900";
        [self addSubview:orderNum];
        self.orderNum = orderNum;
        
        UILabel *orderBeginTime = [[UILabel alloc] init];
        orderBeginTime.textAlignment = NSTextAlignmentLeft;
        orderBeginTime.textColor = HexColor(#8a8a8a);
        orderBeginTime.font = UIFont_12;
//        orderBeginTime.text = @"生成时间：2016年05月10";
        [self addSubview:orderBeginTime];
        self.orderBeginTime = orderBeginTime;
        
        UILabel *commonLab = [[UILabel alloc] init];
        commonLab.textAlignment = NSTextAlignmentLeft;
        commonLab.textColor = HexColor(#8a8a8a);
        commonLab.font = UIFont_12;
//        commonLab.text = @"贴现时间：2017年05月10";
        [self addSubview:commonLab];
        self.commonLab = commonLab;
        
    }
    return self;
}

- (void)setRowData:(KPPayBackRowData *)rowData
{
    __weak typeof (self) weakSelf = self;
    _rowData = rowData;
    self.orderNum.text = [NSString stringWithFormat:@"订单号：%@", rowData.orderNum];
    self.orderBeginTime.text = [NSString stringWithFormat:@"生成时间：%@", rowData.orderBeginTime];
    switch (rowData.payBackState) {
        case KPPayBackStateTypeUnPayBack:
        {
            self.commonLab.text = [NSString stringWithFormat:@"贴现时间：%@",rowData.payBackBeginTime];
            
            [self addSubview:self.payBackMoney];
            CGFloat payBackMoneyH = [self.payBackMoney.text sizeWithAttributes:@{NSFontAttributeName: self.payBackMoney.font}].height;
            [self.payBackMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf).offset(-26);
                make.centerY.mas_equalTo(weakSelf);
                make.height.mas_equalTo(payBackMoneyH);
            }];
        }
            break;
        case KPPayBackStateTypeCanPayBack:
        {
            NSString *text = [NSString stringWithFormat:@"贴现金额：￥%@",rowData.payBackMoney];
            NSRange range = [text rangeOfString:@"：" options:NSBackwardsSearch];
            NSRange moneyRange = NSMakeRange(range.location + 1, rowData.payBackMoney.length + 1);
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
            [attributedText addAttributes:@{NSFontAttributeName: UIFont_15, NSForegroundColorAttributeName: RedColor} range:moneyRange];
            self.commonLab.attributedText = attributedText;
            [self addSubview:self.canPayBackBtn];
            CGSize canPayBackBtnSize = CGSizeMake(94, 35);
            [self.canPayBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
                make.centerY.mas_equalTo(weakSelf);
                make.size.mas_equalTo(canPayBackBtnSize);
            }];
            
        }
            break;
        case KPPayBackStateTypeFinishPayBack:
        {
            NSString *text = [NSString stringWithFormat:@"贴现金额：￥%@",rowData.payBackMoney];
            NSRange range = [text rangeOfString:@"：" options:NSBackwardsSearch];
            NSRange moneyRange = NSMakeRange(range.location + 1, rowData.payBackMoney.length + 1);
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
            [attributedText addAttributes:@{NSFontAttributeName: UIFont_15, NSForegroundColorAttributeName: RedColor} range:moneyRange];
            self.commonLab.attributedText = attributedText;
            [self addSubview:self.finishPayBackImg];
            
            [self.finishPayBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
                if (SCREEN_W < 375) {
                    make.right.mas_equalTo(weakSelf).offset(-CommonMargin * 2);
                }
                else
                {
                    make.right.mas_equalTo(weakSelf).offset(-30);
                }
                make.centerY.mas_equalTo(weakSelf);
                make.size.mas_equalTo(weakSelf.finishPayBackImg.image.size);
            }];
        }
            break;
            
        default:
            break;
    }
}

// 申请提现的点击时间
- (void)payBackBtnAction
{
    NSPostNote(Noti_PayBackApply, self.orderNum.text)
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    
    CGSize imgSize = self.img.image.size;
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin + 3);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(imgSize);
    }];
    
    CGFloat orderNumH = [self.orderNum.text sizeWithAttributes:@{NSFontAttributeName: self.orderNum.font}].height;
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.img.mas_right).offset(CommonMargin + 3);
        make.top.mas_equalTo(weakSelf).offset(CommonMargin * 2);
        make.height.mas_equalTo(orderNumH);
    }];
    
    CGFloat orderBeginTimeH = [self.orderBeginTime.text sizeWithAttributes:@{NSFontAttributeName: self.orderBeginTime.font}].height;
    [self.orderBeginTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.orderNum);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(orderBeginTimeH);
    }];
    

    CGFloat commonLabH = [self.commonLab.text sizeWithAttributes:@{NSFontAttributeName: self.commonLab.font}].height;
    [self.commonLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.orderNum);
        make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin * 2);
        make.height.mas_equalTo(commonLabH);
    }];

}

@end
