//
//  KPPayBackDetailContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayBackDetailOrder.h"

@interface KPPayBackDetailOrder ()
@property (nonatomic, weak) UILabel *orderNum;
@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UILabel *orderCount;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIView *line;
@end
@implementation KPPayBackDetailOrder

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;

        UILabel *orderNum = [UILabel new];
        orderNum.textColor = GrayColor;
        orderNum.font = UIFont_12;
        [self addSubview:orderNum];
        self.orderNum = orderNum;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = BlackColor;
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.numberOfLines = 0;
        titleLab.font = UIFont_13;
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        UILabel *orderCount = [[UILabel alloc] init];
        orderCount.textAlignment = NSTextAlignmentLeft;
        orderCount.textColor = GrayColor;
        orderCount.font = UIFont_12;
        [self addSubview:orderCount];
        self.orderCount = orderCount;
        
        UILabel *price = [[UILabel alloc] init];
        price.textColor = RedColor;
        price.textAlignment = NSTextAlignmentRight;
        price.font = UIFont_14;
        [self addSubview:price];
        self.price = price;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = SeperatorColor;
        [self addSubview:line];
        self.line = line;
        
        __weak typeof (self) weakSelf = self;
        
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

- (void)setOrderNumStr:(NSString *)orderNumStr {
    _orderNumStr = [orderNumStr copy];

    self.orderNum.text = [NSString stringWithFormat:@"订单号：%@", orderNumStr];
    self.orderNum.width = 200;
    self.orderNum.height = 13;
}

- (void)setPayBackOrder:(KPPayBackOrder *)payBackOrder
{
    _payBackOrder = payBackOrder;
    self.orderCount.text = [NSString stringWithFormat:@"x%@", payBackOrder.productAmount];
    self.price.text = [NSString stringWithFormat:@"￥%.2f", [payBackOrder.subsidyPrice floatValue]];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:payBackOrder.productImage] placeholderImage:[UIImage imageNamed:@"commitOrder_Placeholder"]];
    self.titleLab.text = payBackOrder.productName;
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat imgWH = self.height * 0.8 + 1;
    CGFloat imgX = CommonMargin;
    CGFloat imgY = 8;

    CGFloat labelX = imgWH + CommonMargin * 2;

    CGFloat orderCountH = 20;
    CGFloat orderCountW = 80;
    CGFloat orderCountY = self.height - CommonMargin - orderCountH;

    CGFloat titleH = 35;
    CGFloat titleW = SCREEN_W - labelX - CommonMargin;
    CGFloat titleY = 12;

    self.imgView.frame = CGRectMake(imgX, imgY, imgWH, imgWH);
    if (self.orderNumStr.length) {
        self.orderNum.frame = CGRectMake(labelX, self.imgView.y, titleW, 13);
        titleY = titleY + 13;
    }
    self.titleLab.frame = CGRectMake(labelX, titleY, titleW, titleH);
    self.orderCount.frame = CGRectMake(labelX, orderCountY, orderCountW, orderCountH);


}
@end
