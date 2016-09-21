//
//  KPOrderCommitBottomTool.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderCommitBottomTool.h"

@interface KPOrderCommitBottomTool ()

@property (nonatomic, strong) KPButton *commitBtn;

@property (nonatomic, strong) UILabel *totalLB;

@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) UILabel *detailLB;

@end

@implementation KPOrderCommitBottomTool

- (void)setActualPrice:(CGFloat)actualPrice {
    _actualPrice = actualPrice;
    self.priceLB.text = [NSString stringWithFormat:@"%.2f", actualPrice];
}

#pragma mark - 点击事件
- (void)clickCommitButton {
    if (self.commitHandler) {
        self.commitHandler();
    }
}

#pragma mark - 类方法
+(instancetype)orderCommitBottomToolWithCommitHandler:(CommitHandler)commitHandler {
    
    KPOrderCommitBottomTool *tool = [self new];
    tool.commitHandler = commitHandler;
    
    return tool;
}

+(CGFloat)orderCommitBottomToolHeight {
    return 50;
}

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:self.totalLB];
    [self addSubview:self.priceLB];
    [self addSubview:self.detailLB];
    [self addSubview:sep];
    [self addSubview:self.commitBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat btnW = 124;
    CGFloat leftMargin = 9;
    CGFloat topMargin = 9;
    CGFloat midMargin = 6;
    CGFloat totalW = [self.totalLB.text sizeWithAttributes:@{NSFontAttributeName : self.totalLB.font}].width;
    CGFloat totaleH = 15;
    CGFloat detailW = [self.detailLB.text sizeWithAttributes:@{NSFontAttributeName : self.detailLB.font}].width;
    CGFloat detailH = 11;
    CGFloat sepH = 1;
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(btnW);
    }];
    
    [self.totalLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftMargin);
        make.top.mas_equalTo(weakSelf).offset(topMargin);
        make.width.mas_equalTo(totalW);
        make.height.mas_equalTo(totaleH);
    }];
    
    [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.totalLB.mas_right);
        make.top.mas_equalTo(weakSelf.totalLB);
        make.height.mas_equalTo(weakSelf.totalLB);
    }];
    
    [self.detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.totalLB);
        make.top.mas_equalTo(weakSelf.totalLB.mas_bottom).offset(midMargin);
        make.width.mas_equalTo(detailW);
        make.height.mas_equalTo(detailH);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];
    
}

#pragma mark - 懒加载
- (KPButton *)commitBtn {
    if (_commitBtn == nil) {
        _commitBtn = [KPButton new];
        [_commitBtn addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
        [_commitBtn setBackgroundColor:OrangeColor];
        [_commitBtn setTitle:@"支付赢资产" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = UIFont_16;
        _commitBtn.adjustsImageWhenHighlighted = NO;
    }
    return _commitBtn;
}

- (UILabel *)totalLB {
    if (_totalLB == nil) {
        _totalLB = [UILabel new];
        _totalLB.font = UIFont_15;
        _totalLB.textColor = BlackColor;
        _totalLB.text = @"合计：";
    }
    return _totalLB;
}

- (UILabel *)priceLB {
    if (_priceLB == nil) {
        _priceLB = [UILabel new];
        _priceLB.font = UIFont_15;
        _priceLB.textColor = LightRedColor;
    }
    return _priceLB;
}

- (UILabel *)detailLB {
    if (_detailLB == nil) {
        _detailLB = [UILabel new];
        _detailLB.font = UIFont_11;
        _detailLB.textColor = GrayColor;
        _detailLB.text = @"您可以获得等额的二一美银消费资产";
    }
    return _detailLB;
}

























@end
