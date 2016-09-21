//
//  KPTakeBackMoneyFooterView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPTakeBackMoneyFooterView.h"

@interface KPTakeBackMoneyFooterView ()

@property (nonatomic, weak) KPButton *plusCard;
@end
@implementation KPTakeBackMoneyFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ClearColor;
        KPButton *plusCard = [[KPButton alloc] init];
        plusCard.backgroundColor = WhiteColor;
        [plusCard setImage:[UIImage imageNamed:@"plusIcon"] forState:UIControlStateNormal];
        [plusCard setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [plusCard setTitleColor:OrangeColor forState:UIControlStateNormal];
        plusCard.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        plusCard.imageEdgeInsets = UIEdgeInsetsMake(0, CommonMargin + 5, 0, 0);
        plusCard.titleEdgeInsets = UIEdgeInsetsMake(0, CommonMargin * 3, 0, 0);
        [plusCard addTarget:self action:@selector(plusCardAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusCard];
        self.plusCard = plusCard;
    }
    return self;
}

- (void)plusCardAction
{
    NSPostNote(Noti_plusBankCard, nil)
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    [self.plusCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(50);
    }];
}
@end
