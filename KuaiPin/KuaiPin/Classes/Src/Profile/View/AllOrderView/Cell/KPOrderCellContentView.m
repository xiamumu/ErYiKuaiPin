//
//  KPOrderCellContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderCellContentView.h"
#import "KPOrderRowData.h"

@interface KPOrderCellContentView ()
@property (nonatomic, weak) UILabel *orderNum;
@property (nonatomic, weak) UILabel *orderState;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UIButton *stateBtn;

@end
@implementation KPOrderCellContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *orderNum = [[UILabel alloc] init];
        orderNum.textAlignment = NSTextAlignmentLeft;
        orderNum.textColor = HexColor(#8a8a8a);
        orderNum.font = UIFont_11;
        [self addSubview:orderNum];
        self.orderNum = orderNum;
        
        UILabel *orderState = [[UILabel alloc] init];
        orderState.textAlignment = NSTextAlignmentRight;
        orderState.textColor = OrangeColor;
        orderState.font = UIFont_11;
        [self addSubview:orderState];
        self.orderState = orderState;
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        UILabel *title = [[UILabel alloc] init];
        title.textAlignment = NSTextAlignmentLeft;
        title.numberOfLines = 2;
        title.textColor = HexColor(#191919);
        title.font = UIFont_13;
        [self addSubview:title];
        self.title = title;
        
        UILabel *price = [[UILabel alloc] init];
        price.textAlignment = NSTextAlignmentLeft;
        price.textColor = OrangeColor;
        price.font = UIFont_11;
        [self addSubview:price];
        self.price = price;
        
        UIButton *stateBtn = [[UIButton alloc] init];
        [stateBtn setBackgroundImage:[UIImage imageNamed:@"juxing"] forState:UIControlStateNormal];
        stateBtn.titleLabel.font = UIFont_13;
        [stateBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        stateBtn.hidden = YES;
        [self addSubview:stateBtn];
        self.stateBtn = stateBtn;
        
    }
    return self;
}

- (void)setRowData:(KPOrderRowData *)rowData
{
    _rowData = rowData;
    self.orderNum.text = [NSString stringWithFormat:@"订单号:%@",rowData.orderNum];
    switch (rowData.orderState.integerValue) {
        case KPOrderStateTypeUnPay:
        {
            self.orderState.text = @"待付款";
            self.stateBtn.hidden = NO;
            [self.stateBtn setTitle:@"去支付" forState:UIControlStateNormal];
        }
            break;
        case KPOrderStateTypeUnReceive:
        {
            self.orderState.text = @"待收货";
            self.stateBtn.hidden = NO;
            [self.stateBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        }
            break;
        case KPOrderStateTypeCancel:
        {
            self.orderState.text = @"已取消";
        }
            break;
        case KPOrderStateTypeFinish:
        {
            self.orderState.text = @"已完成";
        }
            break;
        default:
            break;
    }
    self.imgView.image = rowData.img;
    self.title.text = rowData.title;
    self.price.text = rowData.price;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    CGFloat orderNumH = [self.orderNum.text sizeWithAttributes:@{NSFontAttributeName: self.orderNum.font}].height;
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf).offset(CommonMargin);
        make.top.mas_equalTo(weakSelf).offset(CommonMargin);
        make.height.mas_equalTo(orderNumH);
    }];
    
    CGFloat orderStateH = [self.orderState.text sizeWithAttributes:@{NSFontAttributeName: self.orderState.font}].height;
    [self.orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.rightMargin.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.top.mas_equalTo(weakSelf).offset(CommonMargin);
        make.height.mas_equalTo(orderStateH);
    }];
    
    CGSize imgSize = CGSizeMake(109, 82);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin);
        make.top.mas_equalTo(self.orderNum.mas_bottom).offset(CommonMargin);
        make.size.mas_equalTo(imgSize);
    }];
    
    CGFloat titleH = [self.title.text sizeWithAttributes:@{NSFontAttributeName: self.title.font}].height * 2 + 5;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(CommonMargin);
        make.rightMargin.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.top.mas_equalTo(self.imgView.mas_top).offset(CommonMargin);
        make.height.mas_equalTo(titleH);
    }];
    
    CGFloat priceH = [self.price.text sizeWithAttributes:@{NSFontAttributeName: self.price.font}].height;
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.bottom.mas_equalTo(self.imgView.mas_bottom).offset(-CommonMargin);
        make.height.mas_equalTo(priceH);
    }];
    
    CGSize stateBtn = self.stateBtn.currentBackgroundImage.size;
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.bottom.mas_equalTo(self.imgView.mas_bottom);
        make.size.mas_equalTo(stateBtn);
    }];
}
@end
