//
//  KPPayPwdViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayPwdViewController.h"
#import "KPPayPwdTextField.h"
#import "KPBottomButton.h"
#import "KPNewPhoneViewController.h"
#import "KPChangePayPwdParam.h"

@interface KPPayPwdViewController ()

@property (nonatomic, strong) KPBottomButton *nextStepBtn;

@property (nonatomic, strong) KPPayPwdTextField *payPwdTF;

@property (nonatomic, strong) UILabel *tipLB;

@property (nonatomic, strong) UILabel *titleLB;

@end

@implementation KPPayPwdViewController



#pragma mark - 点击事件
- (void)clickNextStepButton {

    if (self.payPwdTF.text.length != 6) return;

    KPChangePayPwdParam *param = [KPChangePayPwdParam new];
    param.payPassword = self.payPwdTF.text;

    __weak typeof(self) weakSelf = self;
    [KPNetworkingTool checkPayPwdWithParam:param success:^(id result) {

        NSInteger code = [result[@"code"] integerValue];

        if (code == 10004) {
            [KPProgressHUD showErrorWithStatus:@"支付密码错误！"];
            [weakSelf.payPwdTF clearPayPwd];
            return;
        }

        if (code != 0) {
            WHYNSLog(@"%zd -- %@", code, result[@"message"]);
            return;
        }

        KPNewPhoneViewController *newPhoneVc = [KPNewPhoneViewController new];
        [weakSelf.navigationController pushViewController:newPhoneVc animated:YES];

    } failure:^(NSError *error) {
         WHYNSLog(@"%@", error);
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupNaigationBar];
    
    [self.payPwdTF becomeFirstResponder];
    
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
    
    UIView *bgWhite = [UIView new];
    bgWhite.backgroundColor = WhiteColor;
    
    [self.view addSubview:self.tipLB];
    [self.view addSubview:bgWhite];
    [self.view addSubview:self.titleLB];
    [self.view addSubview:self.payPwdTF];
    [self.view addSubview:self.nextStepBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat topMargin = 64;
    CGFloat leftRightMargin = 9;
    CGFloat btnTopMargin = 80;
    CGFloat btnH = 45;
    CGFloat payPwdW = 240;
    CGFloat payPwdH = 40;
    CGFloat payPwdTop = 47;
    CGFloat tipH = 38;
    CGFloat titleH = 17;
    CGFloat bgH = 100;
    CGFloat titleTop = 12;
    [self.tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(topMargin);
        make.left.mas_equalTo(weakSelf.view).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRightMargin);
        make.height.mas_equalTo(tipH);
    }];
    
    [bgWhite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tipLB.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(bgH);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgWhite).offset(titleTop);
        make.left.mas_equalTo(weakSelf.tipLB);
        make.height.mas_equalTo(titleH);
    }];
    
    [self.payPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgWhite).offset(payPwdTop);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(payPwdW);
        make.height.mas_equalTo(payPwdH);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.payPwdTF.mas_bottom).offset(btnTopMargin);
        make.left.mas_equalTo(weakSelf.view).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRightMargin);
        make.height.mas_equalTo(btnH);
    }];
    
}

- (void)setupNaigationBar {
    
    self.navigationItem.title = @"修改手机验证";
    
}

#pragma mark - 懒加载
- (UILabel *)tipLB {
    if (_tipLB == nil) {
        _tipLB = [UILabel new];
        _tipLB.font = UIFont_14;
        _tipLB.textColor = GrayColor;
        _tipLB.text = @"请输入支付密码";
    }
    return _tipLB;
}

- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.text = @"支付密码";
        _titleLB.font = UIFont_17;
        _titleLB.textColor = BlackColor;
    }
    return _titleLB;
}

- (KPPayPwdTextField *)payPwdTF {
    if (_payPwdTF == nil) {
        _payPwdTF = [KPPayPwdTextField new];
        __weak typeof(self) weakSelf = self;
        [_payPwdTF setInputCompletion:^(NSString *payPwd) {
            [weakSelf clickNextStepButton];
        }];
    }
    return _payPwdTF;
}

- (KPBottomButton *)nextStepBtn {
    if (_nextStepBtn == nil) {
        _nextStepBtn = [KPBottomButton bottomButtonWithTitle:@"下一步" target:self action:@selector(clickNextStepButton)];
    }
    return _nextStepBtn;
}


@end
