
//
//  KPShopSectionHeader.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSortBar.h"

@interface KPSortBar ()

@property (nonatomic, weak) KPButton *priceBtn;

@property (nonatomic, weak) KPButton *salesBtn;

@property (nonatomic, weak) KPButton *hotBtn;

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) NSMutableArray *lines;


@end
@implementation KPSortBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)lines
{
    if (_lines == nil) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        
        KPButton *priceBtn = [self addBtnWithTitle:@"G价" image:@"home_sort_normal"];
        priceBtn.tag = 20;
        [self addSubview:priceBtn];
        [self.btns addObject:priceBtn];
        self.priceBtn = priceBtn;
        
        KPButton *salesBtn = [self addBtnWithTitle:@"销量" image:nil];
        salesBtn.tag = 21;
        [self addSubview:salesBtn];
        [self.btns addObject:salesBtn];
        self.salesBtn = salesBtn;
        
        KPButton *hotBtn = [self addBtnWithTitle:@"热度"image:nil];
        hotBtn.tag = 22;
        [self addSubview:hotBtn];
        [self.btns addObject:hotBtn];
        self.hotBtn = hotBtn;
        
        UIView *line1 = [UIView line];
        [self addSubview:line1];
        [self.lines addObject:line1];
        
        UIView *line2 = [UIView line];
        [self addSubview:line2];
        [self.lines addObject:line2];
        
        
        [self chooseAction:priceBtn];
    }
    return self;
}

- (KPButton *)addBtnWithTitle:(NSString *)title image:(NSString *)image
{
    KPButton *btn = [[KPButton alloc] init];
    [btn.titleLabel setFont:UIFont_14];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:BlackColor forState:UIControlStateNormal];
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -60)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    }
    [btn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchDown];
    return btn;
}

- (void)chooseAction:(KPButton *)chooseBtn
{
    if (chooseBtn.tag == 20) {
        if ([self.delegate respondsToSelector:@selector(SortBar:didSelectedPriceBtn:otherBtnSalesBtn:andHotBtn:)]) {
            [self.delegate SortBar:self didSelectedPriceBtn:self.priceBtn otherBtnSalesBtn:self.salesBtn andHotBtn:self.hotBtn];
        }
    }
    else if (chooseBtn.tag == 21) {
        if ([self.delegate respondsToSelector:@selector(SortBar:didSelectedSalesBtn:otherBtnPriceBtn:andHotBtn:)]) {
            [self.delegate SortBar:self didSelectedSalesBtn:self.salesBtn otherBtnPriceBtn:self.priceBtn andHotBtn:self.hotBtn];
        }
    } else if (chooseBtn.tag == 22) {
        if ([self.delegate respondsToSelector:@selector(SortBar:didSelectedHotBtn:otherBtnPriceBtn:andSalesBtn:)]) {
            [self.delegate SortBar:self didSelectedHotBtn:self.hotBtn otherBtnPriceBtn:self.priceBtn andSalesBtn:self.salesBtn];
        }
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.btns.count;
    
    CGFloat btn_W = SCREEN_W / count;
    CGFloat btn_H = 34;
    
    CGFloat line_W = 1;
    CGFloat line_H = 17;
    CGFloat line_Y = line_H * 0.5;
    
    for (int i = 0; i < count ; i++) {
        KPButton *btn = self.btns[i];
        btn.frame = CGRectMake(btn_W * i, 0, btn_W, btn_H);
        if (i > 0) {
            UIView *line = self.lines[i-1];
            line.frame = CGRectMake(btn_W * i, line_Y, line_W, line_H);
        }
    }
    
}

@end
