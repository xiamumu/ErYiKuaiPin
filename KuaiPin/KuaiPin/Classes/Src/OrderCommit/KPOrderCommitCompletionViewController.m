//
//  KPOrderCommitCompletionViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderCommitCompletionViewController.h"
#import "KPOrderCommitCompletionLabel.h"
#import "KPOrderDetailModel.h"

@interface KPOrderCommitCompletionViewController ()

@property (nonatomic, strong) KPButton *closeBtn;

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) KPOrderCommitCompletionLabel *orderNumberLB;

@property (nonatomic, strong) KPOrderCommitCompletionLabel *payTimeLB;

@property (nonatomic, strong) KPOrderCommitCompletionLabel *priceLB;

@property (nonatomic, strong) KPOrderCommitCompletionLabel *nameLB;

@property (nonatomic, strong) KPOrderCommitCompletionLabel *addressLB;

@property (nonatomic, strong) KPButton *doneBtn;

@end

@implementation KPOrderCommitCompletionViewController

- (void)setPayTime:(NSString *)payTime {
    _payTime = payTime;

    NSString *year = [payTime substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [payTime substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [payTime substringWithRange:NSMakeRange(6, 2)];

    self.payTimeLB.detail = [NSString stringWithFormat:@"%@年%@月%@日", year, month, day];

}

- (void)setOrderDetail:(id)orderDetail {
    _orderDetail = orderDetail;

    KPOrderDetailModel *orderDetailModel = [KPOrderDetailModel mj_objectWithKeyValues:orderDetail];

    self.orderNumberLB.detail = [NSString stringWithFormat:@"%@", orderDetailModel.order.orderSn];
    self.priceLB.detail = [NSString stringWithFormat:@"￥%.2f", [orderDetailModel.order.orderTotalprice floatValue]];
    self.nameLB.detail = orderDetailModel.receiver.receiverName;
    self.addressLB.detail = orderDetailModel.receiver.address;

}

#pragma mark - 点击事件
- (void)close {

    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    __weak typeof(nav) weakNav = nav;

    if ([self isEqual:self.navigationController.viewControllers[1]]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [weakNav popToRootViewControllerAnimated:YES];
        }];
    }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}

#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    WHYNSLog(@"KPOrderCommitCompletionViewController dealloc");
}

- (void)setupUI {
    
    self.view.backgroundColor = WhiteColor;
    
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.titleLB];
    [self.view addSubview:self.orderNumberLB];
    [self.view addSubview:self.payTimeLB];
    [self.view addSubview:self.priceLB];
    [self.view addSubview:self.nameLB];
    [self.view addSubview:self.addressLB];
    [self.view addSubview:self.doneBtn];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat closeLeft = 9;
    CGFloat closeTop = 32;
    CGFloat titleTop = 82;
    CGFloat titleH = 23;
    CGFloat labelTop = 49;
    CGFloat labelH = 17;
    CGFloat lableMargin = 13;
    CGFloat doneTop = 75;
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(closeLeft);
        make.top.mas_equalTo(weakSelf.view).offset(closeTop);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(titleTop);
        make.centerX.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(titleH);
    }];
    
    [self.orderNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.titleLB.mas_bottom).offset(labelTop);
        make.height.mas_equalTo(labelH);
    }];
    
    [self.payTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.orderNumberLB.mas_bottom).offset(lableMargin);
        make.height.mas_equalTo(weakSelf.orderNumberLB);
    }];
    
    [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.payTimeLB.mas_bottom).offset(lableMargin);
        make.height.mas_equalTo(labelH);
    }];
    
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.priceLB.mas_bottom).offset(lableMargin);
        make.height.mas_equalTo(labelH);
    }];
    
    [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.nameLB.mas_bottom).offset(lableMargin);
        make.height.mas_equalTo(labelH * 2 + 4);
    }];
    
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.addressLB.mas_bottom).offset(doneTop);
    }];
    
}

#pragma mark - 懒加载
- (KPButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [KPButton new];
        _closeBtn.adjustsImageWhenHighlighted = NO;
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.text = @"支付成功";
        _titleLB.font = UIFont_23;
        _titleLB.textColor = BlackColor;
    }
    return _titleLB;
}

- (KPOrderCommitCompletionLabel *)orderNumberLB {
    if (_orderNumberLB == nil) {
        _orderNumberLB = [KPOrderCommitCompletionLabel completionLabelWithTitle:@"订单号："];
    }
    return _orderNumberLB;
}

- (KPOrderCommitCompletionLabel *)payTimeLB {
    if (_payTimeLB == nil) {
        _payTimeLB = [KPOrderCommitCompletionLabel completionLabelWithTitle:@"支付时间："];
    }
    return _payTimeLB;
}

- (KPOrderCommitCompletionLabel *)priceLB {
    if (_priceLB == nil) {
        _priceLB = [KPOrderCommitCompletionLabel completionLabelWithTitle:@"支付金额："];
    }
    return _priceLB;
}

- (KPOrderCommitCompletionLabel *)nameLB {
    if (_nameLB == nil) {
        _nameLB = [KPOrderCommitCompletionLabel completionLabelWithTitle:@"收货人姓名："];
    }
    return _nameLB;
}

- (KPOrderCommitCompletionLabel *)addressLB {
    if (_addressLB == nil) {
        _addressLB = [KPOrderCommitCompletionLabel completionLabelWithTitle:@"收货人地址："];
    }
    return _addressLB;
}

- (KPButton *)doneBtn {
    if (_doneBtn == nil) {
        _doneBtn = [KPButton new];
        _doneBtn.adjustsImageWhenHighlighted = NO;
        [_doneBtn setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

@end
