//
//  KPChangePayPwdViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPChangePayPwdViewController.h"
#import "KPChangeButton.h"
#import "KPCommitAuthCodeViewController.h"
#import "KPNewPayPwdViewController.h"
#import "KPSMSTool.h"

@interface KPChangePayPwdViewController ()

@property (nonatomic, strong) KPChangeButton *authCodeChange;

@property (nonatomic, strong) KPChangeButton *payPwdChange;

@end

@implementation KPChangePayPwdViewController

#pragma mark - 点击事件
- (void)clickAuthCodeChange {
    
    __weak typeof(self) weakSelf = self;

    [KPProgressHUD showLoading];
    [KPSMSTool getVerificationCodeByPhoneNumber:[KPUserManager sharedUserManager].userModel.mobile result:^(NSError *error) {
        [KPProgressHUD hideLoading];
        if (!error) {
            KPCommitAuthCodeViewController *authCodeVc = [KPCommitAuthCodeViewController new];
            authCodeVc.commitType = KPCommitAuthCodeTypeChangePayPwdNext;
            authCodeVc.phoneNumber = [KPUserManager sharedUserManager].userModel.mobile;
            [weakSelf.navigationController pushViewController:authCodeVc animated:YES];
        }else {
            WHYNSLog(@"错误信息：%@",error);
            [KPProgressHUD showErrorWithStatus:error.userInfo[@"getVerificationCode"]];
        }
        
    }];
    
}

- (void)clickPayPwdChange {
    
    KPNewPayPwdViewController *newPayPwdVc = [KPNewPayPwdViewController new];
    newPayPwdVc.needOldPayPwd = YES;
    [self.navigationController pushViewController:newPayPwdVc animated:YES];
    
}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupNaigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

#pragma mark - 私有方法
- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self.view addSubview:self.authCodeChange];
    [self.view addSubview:self.payPwdChange];
    [self.view addSubview:sep];
    
    __weak typeof(self) weakSelf = self;
    CGFloat topMargin = 89;
    CGFloat left = 9;
    CGFloat btnH = 59;
    CGFloat sepH = 1;
    [self.authCodeChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(topMargin);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(btnH);
    }];
    
    [self.payPwdChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.authCodeChange.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.authCodeChange);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(left);
        make.right.mas_equalTo(weakSelf.view);
        make.centerY.mas_equalTo(weakSelf.authCodeChange.mas_bottom);
        make.height.mas_equalTo(sepH);
    }];
    
}

- (void)setupNaigationBar {
    
    self.navigationItem.title = @"修改支付密码";
    
}

#pragma mark - 懒加载
- (KPChangeButton *)authCodeChange {
    if (_authCodeChange == nil) {
        _authCodeChange = [KPChangeButton new];
        [_authCodeChange setTitle:@"验证码修改" forState:UIControlStateNormal];
        [_authCodeChange addTarget:self action:@selector(clickAuthCodeChange) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authCodeChange;
}

- (KPChangeButton *)payPwdChange {
    if (_payPwdChange == nil) {
        _payPwdChange = [KPChangeButton new];
        [_payPwdChange setTitle:@"通过支付密码修改" forState:UIControlStateNormal];
        [_payPwdChange addTarget:self action:@selector(clickPayPwdChange) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payPwdChange;
}


@end
