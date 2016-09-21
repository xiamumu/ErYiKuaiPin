//
//  KPForgetPwdViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/8/2.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPForgetPwdViewController.h"
#import "KPRegisterView.h"
#import "KPSMSTool.h"
#import "KPRegisterPwdViewController.h"

static BOOL isGotAuthCode = NO;

@interface KPForgetPwdViewController ()

@property (nonatomic, strong) KPRegisterView *registerView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger timeCount;

@end

@implementation KPForgetPwdViewController

#pragma mark - 控制器声明周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupNavigationBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];

}

#pragma mark - 私有方法
- (void)commitAuthCodeWithCode:(NSString *)authCode phone:(NSString *)phone {

    __weak typeof(self) weakSelf = self;

    if (!phone.isPhoneString) {
        [KPProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }

    if (!isGotAuthCode) {
        [weakSelf getAuthCodeWithPhone:phone];
        return;
    }

    if (authCode.length == 0) {
        [KPProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }

    
    [KPProgressHUD showLoading];

    [KPSMSTool commitVerificationCode:authCode phoneNumber:phone result:^(NSError *error) {

        [KPProgressHUD hideLoading];

        if (!error) {
            WHYNSLog(@"验证成功");

            KPRegisterPwdViewController *registerPwdVc = [KPRegisterPwdViewController new];
            registerPwdVc.registerPhoneNum = phone;
            registerPwdVc.pwdType = KPPWDTypeForget;

            [weakSelf.navigationController pushViewController:registerPwdVc animated:YES];

        }else {
            WHYNSLog(@"错误信息：%@",error);
            [KPProgressHUD showErrorWithStatus:@"验证码错误"];
            return;
        }
        
    }];
    
}

- (void)getAuthCodeWithPhone:(NSString *)phone {

    if (!phone.isPhoneString) {
        WHYNSLog(@"请输入正确的手机号");
        [KPProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }

    __weak typeof(self) weakSelf = self;

    [KPNetworkingTool checkPhoneWithParam:phone success:^(id result) {

        NSNumber *code = result[@"data"][@"code"];

        if (code.integerValue != 1) {
            [KPProgressHUD showErrorWithStatus:@"该手机号未注册，请注册" completion:nil];
            return;
        }

        [KPSMSTool getVerificationCodeByPhoneNumber:phone result:^(NSError *error) {

            if (!error) {
                WHYNSLog(@"获取验证码成功");
                isGotAuthCode = YES;

                [KPProgressHUD showSuccessWithStatus:@"已发送验证码"];

                [weakSelf.registerView setGetAuthCodeButtonTitle:@"60秒后可以重新获取验证码" state:UIControlStateDisabled];
                [weakSelf.registerView setGetAuthCodeButtonTitle:@"重新获取验证码" state:UIControlStateNormal];

                [weakSelf.registerView setGetAuthCodeButtonEnabled:NO];

                weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                  target:weakSelf
                                                                selector:@selector(getAuthCodeCountDown)
                                                                userInfo:nil
                                                                 repeats:YES];
                [weakSelf.timer fire];

            } else {
                WHYNSLog(@"错误信息：%@",error);
                [KPProgressHUD showErrorWithStatus:error.userInfo[@"getVerificationCode"]];
            }
            
        }];
        
    } failure:^(NSError *error) {
        WHYNSLog(@"错误信息：%@",error);
        [KPProgressHUD showSuccessWithStatus:@"获取验证码失败，请重试"];
    }];

}

- (void)retryAuthCodeWithPhone:(NSString *)phone {

    if (!phone.isPhoneString) {
        [KPProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }

    __weak typeof(self) weakSelf = self;
    [KPProgressHUD showLoading];
    [KPSMSTool getVerificationCodeByPhoneNumber:phone result:^(NSError *error) {
        [KPProgressHUD hideLoading];
        if (!error) {
            WHYNSLog(@"获取验证码成功");
            isGotAuthCode = YES;

            [KPProgressHUD showSuccessWithStatus:@"已重新发送验证码"];

            [weakSelf.registerView setGetAuthCodeButtonTitle:@"60秒后可以重新获取验证码"  state:UIControlStateDisabled];

            [weakSelf.registerView setGetAuthCodeButtonEnabled:NO];

            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:weakSelf
                                                            selector:@selector(getAuthCodeCountDown)
                                                            userInfo:nil
                                                             repeats:YES];
            [weakSelf.timer fire];

        } else {
            WHYNSLog(@"错误信息：%@",error);
            [KPProgressHUD showErrorWithStatus:error.userInfo[@"getVerificationCode"]];
        }

    }];
}

- (void)getAuthCodeCountDown {

    __weak typeof(self) weakSelf = self;

    weakSelf.timeCount++;

    NSString *title = [NSString stringWithFormat:@"%zd秒后可以重新获取验证码", 60 - weakSelf.timeCount];
    [weakSelf.registerView setGetAuthCodeButtonTitle:title  state:UIControlStateDisabled];

    if (weakSelf.timeCount == 60) {
        weakSelf.timeCount = 0;
        [weakSelf.registerView setGetAuthCodeButtonEnabled:YES];
        [weakSelf.timer invalidate];
        weakSelf.timer = nil;
        isGotAuthCode = NO;
    }
    
}

- (void)setupUI {

    self.view.backgroundColor = ViewBgColor;

    [self.view addSubview:self.registerView];

}

- (void)setupNavigationBar {

    self.navigationItem.title = @"忘记密码";

}

#pragma mark - 懒加载
- (KPRegisterView *)registerView {
    if (_registerView == nil) {
        __weak typeof(self) weakSelf = self;
        _registerView = [KPRegisterView registerViewWithFrame:self.view.frame
                                              nextStepHandler:^(NSString *authCode, NSString *phone, BOOL agree) {
                                                  [weakSelf commitAuthCodeWithCode:authCode phone:phone];
                                              }
                             clickKuaiPinServeProtocolHandler:nil];

        [_registerView setGetAuthCodeHandler:^(NSString *phone, BOOL isRetry) {

            if (isRetry) {
                [weakSelf retryAuthCodeWithPhone:phone];
            }else {
                [weakSelf getAuthCodeWithPhone:phone];
            }

        }];

        _registerView.hideKuaiPinServeProtocol = YES;
    }
    return _registerView;
}

- (BOOL)willDealloc {
    [self.timer invalidate];
    self.timer = nil;
    isGotAuthCode = NO;
    return NO;
}

@end
