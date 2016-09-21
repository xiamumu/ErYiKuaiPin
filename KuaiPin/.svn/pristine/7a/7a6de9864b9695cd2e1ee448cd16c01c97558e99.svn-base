//
//  KPRegisterAuthCodeViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPRegisterPwdViewController.h"
#import "KPRegisterPwdView.h"
#import "KPSMSTool.h"
#import "KPLoginRegistParam.h"

@interface KPRegisterPwdViewController ()

@property (nonatomic, strong) KPRegisterPwdView *authCodeView;

@end

@implementation KPRegisterPwdViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setNavigationBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)dealloc {
    WHYNSLog(@"KPRegisterPwdViewController dealloc");
}

#pragma mark - 私有方法
- (void)registerWithPwd:(NSString *)pwd repeatPwd:(NSString *)repeatPwd {
    
    if (!pwd.isPasswordString) {
        WHYNSLog(@"请输入6-12位密码！");
        [KPProgressHUD showErrorWithStatus:@"请输入6-12位密码"];
        return;
    }
    
    if (![pwd isEqualToString:repeatPwd]) {
        WHYNSLog(@"两次输入的密码必须一致！");
        [KPProgressHUD showErrorWithStatus:@"密码不一致"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    KPLoginRegistParam *param = [KPLoginRegistParam new];
    param.username = weakSelf.registerPhoneNum;
    param.password = pwd;

    if (self.pwdType == KPPWDTypeNormal) {

        [KPNetworkingTool registWithParam:param success:^(id result) {

            NSInteger code = [result[@"code"] integerValue];

            if (code != 0) {
                [KPProgressHUD showErrorWithStatus:result[@"message"]];
                WHYNSLog(@"%zd -- %@", code, result[@"message"]);
                return;
            }

            [KPUserManager sharedUserManager].userModel = [KPUserModel mj_objectWithKeyValues:result[@"data"][@"user"]];

            [KPProgressHUD showSuccessWithStatus:@"注册成功" completion:^{

                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    NSPostNote(Noti_LoginSuccess, nil);
                }];

            }];

        } failure:^(NSError *error) {

            WHYNSLog(@"%@", error);
            [KPProgressHUD showErrorWithStatus:@"注册失败"];
            
        }];

    }else {

        WHYNSLog(@"重置密码");

        [KPNetworkingTool resetPwdWithParam:param success:^(id result) {

            NSInteger code = [result[@"code"] integerValue];

            if (code != 0) {
                [KPProgressHUD showErrorWithStatus:result[@"message"]];
                WHYNSLog(@"%zd -- %@", code, result[@"message"]);
                return;
            }

            [KPUserManager sharedUserManager].userModel.password = pwd;
            [KPUserManager updateUser];

            [KPProgressHUD showSuccessWithStatus:@"登录密码重置成功" completion:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];

        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
            [KPProgressHUD showErrorWithStatus:@"登录密码重置失败"];
        }];

    }

}

- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    [self.view addSubview:self.authCodeView];

    if (self.pwdType == KPPWDTypeForget) {
        self.authCodeView.bottomBtnTitle = @"完成";
    }

}

- (void)setNavigationBar {

    if (self.pwdType == KPPWDTypeNormal) {
        self.navigationItem.title = @"账号注册";
    }else {
        self.navigationItem.title = @"重置登录密码";
    }

    
}

#pragma mark - 懒加载
- (KPRegisterPwdView *)authCodeView {
    if (_authCodeView == nil) {
        __weak typeof(self) weakSelf = self;
        _authCodeView = [KPRegisterPwdView registerPwdViewWithFrame:self.view.frame
                                              registerHandler:^(NSString *pwd, NSString *repeatPwd) {
                                                  [weakSelf registerWithPwd:pwd repeatPwd:repeatPwd];
                                              }];
    }
    return _authCodeView;
}

@end
