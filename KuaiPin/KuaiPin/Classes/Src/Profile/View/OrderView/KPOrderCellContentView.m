//
//  KPOrderCellContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderCellContentView.h"
#import "KPOrder.h"
#import "KPOrderItem.h"
#import "KPSoldoutView.h"

@interface KPOrderCellContentView ()
@property (nonatomic, weak) UILabel *orderNum;
@property (nonatomic, weak) UILabel *orderState;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) KPButton *stateBtn;
@property (nonatomic, weak) KPSoldoutView *soldoutView;

@end

@implementation KPOrderCellContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *orderNum = [UILabel addLabelWithTitle:nil textColor:HexColor(#8a8a8a) font:UIFont_11];
        [self addSubview:orderNum];
        self.orderNum = orderNum;
        
        UILabel *orderState = [UILabel addLabelWithTitle:nil textColor:OrangeColor font:UIFont_11];
        orderState.textAlignment = NSTextAlignmentRight;
        [self addSubview:orderState];
        self.orderState = orderState;
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        KPSoldoutView *soldoutView = [[KPSoldoutView alloc] init];
        soldoutView.titleFont = UIFont_14;
        soldoutView.hidden = YES;
        [imgView addSubview:soldoutView];
        self.soldoutView = soldoutView;
        
        UILabel *title = [UILabel addLabelWithTitle:nil textColor:HexColor(#191919) font:UIFont_13];
        title.numberOfLines = 2;
        [self addSubview:title];
        self.title = title;
        
        UILabel *price = [UILabel addLabelWithTitle:nil textColor:OrangeColor font:UIFont_11];
        [self addSubview:price];
        self.price = price;
        
        KPButton *stateBtn = [[KPButton alloc] init];
        stateBtn.backgroundColor = OrangeColor;
        stateBtn.layer.cornerRadius = 5;
        stateBtn.titleLabel.font = UIFont_13;
        [stateBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self addSubview:stateBtn];
        self.stateBtn = stateBtn;
    }
    return self;
}

- (void)setOrder:(KPOrder *)order
{
    _order = order;
    KPOrderItem *orderItem = [order.orderItems firstObject];
    
    self.orderNum.text = [NSString stringWithFormat:@"订单号:%@",order.orderSn];
    self.title.text = orderItem.productName;
    self.price.text = [NSString stringWithFormat:@"￥%.2f", [orderItem.productPrice floatValue]];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:orderItem.productImage] placeholderImage:[UIImage imageNamed:@"commitOrder_Placeholder"]];
    
    switch (order.orderState.integerValue) {
        case KPOrderStateUnPay:
        {
            self.orderState.text = @"待付款";
            self.stateBtn.hidden = YES;
            
        }
            break;
        case KPOrderStateUnReceive:
        {
            self.orderState.text = @"待收货";
            
            self.stateBtn.hidden = NO;
            [self.stateBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [self.stateBtn addTarget:self action:@selector(receive:) forControlEvents:UIControlEventTouchUpInside];
            
            CGSize btnSize = [self.stateBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.stateBtn.titleLabel.font}];
            [self.stateBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(btnSize.width + 10);
            }];
        }
            break;
        case KPOrderStateUnSendOut:
        {
            self.orderState.text = @"待发货";
            self.stateBtn.hidden = YES;
        }
            break;
        case KPOrderStateCancel:
        {
            self.orderState.text = @"已取消";
            self.stateBtn.hidden = YES;
        }
            break;
        case KPOrderStateFinish:
        {
            self.orderState.text = @"已完成";
            self.stateBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)checkOthers:(KPButton *)stateBtn
{
//    if (self.order.orderState.integerValue == 10) {
//        NSPostNote(Noti_CheckOthers, self.order);
//    }
}

- (void)receive:(KPButton *)stateBtn
{
    if (self.order.orderState.integerValue == 30) {
        
        NSPostNote(Noti_Receive, self.order);
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf).offset(CommonMargin);
        make.top.mas_equalTo(weakSelf).offset(CommonMargin);
    }];
    
    [self.orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.rightMargin.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.top.mas_equalTo(weakSelf).offset(CommonMargin);
    }];
    
    CGSize imgSize = CGSizeMake(82, 82);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin);
        make.top.mas_equalTo(self.orderNum.mas_bottom).offset(CommonMargin);
        make.size.mas_equalTo(imgSize);
    }];
    
    [self.soldoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.imgView);
        make.height.mas_equalTo(ScaleHeight(40));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(CommonMargin);
        make.rightMargin.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.top.mas_equalTo(self.imgView.mas_top).offset(CommonMargin);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.bottom.mas_equalTo(self.imgView.mas_bottom).offset(-CommonMargin);
    }];
    
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.height.mas_equalTo(23);
    }];
}
@end
