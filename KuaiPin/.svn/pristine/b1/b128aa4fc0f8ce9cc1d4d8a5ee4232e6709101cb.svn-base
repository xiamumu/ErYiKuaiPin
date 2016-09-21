//
//  KPAddressManageViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPlusBankCardViewController.h"

#import "KPTextField.h"
#import "KPLocalTextView.h"

@interface KPPlusBankCardViewController ()

@property (nonatomic, strong) KPButton *saveBtn;

@property (nonatomic, strong) KPTextField *nameTF;

@property (nonatomic, strong) KPTextField *cardNum;

@property (nonatomic, strong) KPLocalTextView *bankOwner;

@property (nonatomic, strong) KPTextField *bankLocal;

@end

@implementation KPPlusBankCardViewController

#pragma mark - 点击事件
- (void)clickSaveButton {
    
    WHYNSLog(@"%@", self.saveBtn.titleLabel.text);
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号信息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    
}
#pragma mark - 私有方法
- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    KPSeparatorView *sepTop = [KPSeparatorView new];
    KPSeparatorView *sepMid = [KPSeparatorView new];
    KPSeparatorView *sepBottom = [KPSeparatorView new];
    
    [self.view addSubview:self.nameTF];
    [self.view addSubview:self.cardNum];
    [self.view addSubview:self.bankOwner];
    [self.view addSubview:self.bankLocal];
    [self.view addSubview:sepTop];
    [self.view addSubview:sepMid];
    [self.view addSubview:sepBottom];
    [self.view addSubview:self.saveBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat top = 64;
    CGFloat textFieldH = 56;
    CGFloat left = CommonMargin;
    CGFloat sepH = 1;
    CGFloat saveH = 50;
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(top);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [self.cardNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameTF.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.nameTF);
    }];
    
    [self.bankOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.cardNum.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.cardNum);
    }];
    
    [self.bankLocal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bankOwner.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.bankOwner);
    }];
    
    [sepTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(left);
        make.right.mas_equalTo(weakSelf.view);
        make.centerY.mas_equalTo(weakSelf.nameTF.mas_bottom);
        make.height.mas_equalTo(sepH);
    }];
    
    [sepMid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(sepTop);
        make.centerY.mas_equalTo(weakSelf.cardNum.mas_bottom);
    }];
    
    [sepBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(sepTop);
        make.centerY.mas_equalTo(weakSelf.bankOwner.mas_bottom);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(self.bankLocal.mas_bottom).offset(80);
        make.height.mas_equalTo(saveH);
    }];
    
}


#pragma mark - 懒加载
- (KPButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [KPButton new];
        _saveBtn.adjustsImageWhenHighlighted = NO;
        [_saveBtn setTitle:@"保  存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = UIFont_20;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.layer.cornerRadius = 5;
        _saveBtn.backgroundColor = OrangeColor;
    }
    return _saveBtn;
}

- (KPTextField *)nameTF {
    if (_nameTF == nil) {
        _nameTF = [KPTextField textFieldWithTitle:@"姓名" placeHolder:@"请输入开卡人姓名"];
    }
    return _nameTF;
}

- (KPTextField *)cardNum {
    if (_cardNum == nil) {
        _cardNum = [KPTextField textFieldWithTitle:@"银行卡号" placeHolder:@"请输入银行卡号"];
        _cardNum.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _cardNum;
}

- (KPLocalTextView *)bankOwner {
    if (_bankOwner == nil) {
        _bankOwner = [KPLocalTextView localTextWithTitle:@"所属银行" placeHolder:@"工商银行"];
    }
    return _bankOwner;
}

- (KPTextField *)bankLocal {
    if (_bankLocal == nil) {
        _bankLocal = [KPTextField textFieldWithTitle:@"开户行" placeHolder:@"请输入开户行"];
    }
    return _bankLocal;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}











@end
