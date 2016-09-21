//
//  KPBeLeftMoneyContentViwe.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBeLeftMoneyContentViwe.h"

@interface KPBeLeftMoneyContentViwe ()
@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UILabel *timeLab;
@property (nonatomic, weak) UILabel *moneyLab;
@property (nonatomic, weak) UIView *line;

@end
@implementation KPBeLeftMoneyContentViwe

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLab = [UILabel addLabelWithTitle:@"" textColor:BlackColor font:UIFont_13];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        UILabel *timeLab = [UILabel addLabelWithTitle:@"" textColor:HexColor(#8a8a8a) font:UIFont_11];
        [self addSubview:timeLab];
        self.timeLab = timeLab;
        
        UILabel *moneyLab = [UILabel addLabelWithTitle:@"" textColor:OrangeColor font:UIFont_15];
        [self addSubview:moneyLab];
        self.moneyLab = moneyLab;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = SeperatorColor;
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

- (void)setRowData:(KPBeLeftMoneyRowData *)rowData
{
    _rowData = rowData;
    self.titleLab.text = rowData.titleText;
    self.timeLab.text = rowData.timeText;
    self.moneyLab.text = rowData.moneyText;
}

- (void)layoutSubviews
{
    __weak typeof (self) weakSelf = self;

    CGFloat titleLabH = [self.titleLab.text sizeWithAttributes:@{NSFontAttributeName: self.titleLab.font}].height;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin);
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.top.mas_equalTo(weakSelf).offset(CommonMargin);
        make.height.mas_equalTo(titleLabH);
    }];
    
    CGFloat timeLabH = [self.timeLab.text sizeWithAttributes:@{NSFontAttributeName: self.timeLab.font}].height;
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLab);
        make.right.mas_equalTo(weakSelf.titleLab);
        make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.height.mas_equalTo(timeLabH);
    }];
    
    CGFloat moneyLabH = [self.moneyLab.text sizeWithAttributes:@{NSFontAttributeName: self.moneyLab.font}].height;
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(moneyLabH);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
}
@end
