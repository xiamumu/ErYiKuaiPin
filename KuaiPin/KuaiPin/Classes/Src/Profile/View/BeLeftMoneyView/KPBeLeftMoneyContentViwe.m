//
//  KPBeLeftMoneyContentViwe.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBeLeftMoneyContentViwe.h"
#import "KPFundsFlow.h"

@interface KPBeLeftMoneyContentViwe ()
@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UILabel *timeLab;
@property (nonatomic, weak) UILabel *moneyLab;
@property (nonatomic, weak) UILabel *stateLab;
@property (nonatomic, weak) UIView *line;

@end
@implementation KPBeLeftMoneyContentViwe

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLab = [UILabel addLabelWithTitle:nil textColor:BlackColor font:UIFont_13];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        UILabel *timeLab = [UILabel addLabelWithTitle:nil textColor:HexColor(#8a8a8a) font:UIFont_11];
        [self addSubview:timeLab];
        self.timeLab = timeLab;
        
        UILabel *moneyLab = [UILabel addLabelWithTitle:nil textColor:OrangeColor font:UIFont_15];
        [self addSubview:moneyLab];
        self.moneyLab = moneyLab;
        
        UILabel *stateLab = [UILabel addLabelWithTitle:nil textColor:HexColor(#8a8a8a) font:UIFont_12];
        [self addSubview:stateLab];
        self.stateLab = stateLab;
        
        UIView *line = [UIView line];
        [self addSubview:line];
        self.line = line;
        
        __weak typeof (self) weakSelf = self;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).offset(CommonMargin);
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.top.mas_equalTo(weakSelf).offset(CommonMargin);
        }];
        
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLab);
            make.right.mas_equalTo(weakSelf.titleLab);
            make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin);
        }];
        
        [stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.centerY.mas_equalTo(weakSelf);
        }];
        
        [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(stateLab.mas_left).offset(-24);
            make.centerY.mas_equalTo(weakSelf);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)setFundsFlow:(KPFundsFlow *)fundsFlow
{
    _fundsFlow = fundsFlow;
    self.titleLab.text = fundsFlow.type;
    self.timeLab.text = [fundsFlow.addTime dateStrWithFormatter:@"yyyy年MM月dd日"];
    self.moneyLab.text = [NSString stringWithFormat:@"￥%@", fundsFlow.money];
    self.stateLab.text = @"已完成";
}

@end
