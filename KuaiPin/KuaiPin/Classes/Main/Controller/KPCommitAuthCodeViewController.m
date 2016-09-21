//
//  KPChangeAuthCodeViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCommitAuthCodeViewController.h"
#import "KPTextField.h"
#import "KPBottomButton.h"
#import "KPNewPhoneViewController.h"
#import "KPNewPayPwdViewController.h"
#import "KPSMSTool.h"
#import "KPUserUpdateMobileParam.h"
#import <YYText.h>

@interface KPCommitAuthCodeViewController ()<KPTextFieldDelegate>

@property (nonatomic, strong) KPBottomButton *nextStepBtn;

@property (nonatomic, strong) KPTextField *authCodeTF;

@property (nonatomic, strong) KPButton *retryAuthCodeBtn;

@property (nonatomic, strong) UILabel *detailLB;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger timeCount;

@end

@implementation KPCommitAuthCodeViewController

#pragma mark - KPTextFieldDelegate
- (BOOL)textField:(KPTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 0) return YES;
    
    if (string.isEmoji) return NO;
    
    NSInteger maxLength = 11;
    
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        
        [self clickNextStepButton];
        
        return NO;
    } else if(textField.text.length >= maxLength) {
        //输入的字符个数大于maxLength，则无法继续输入，返回NO表示禁止输入
        WHYNSLog(@"输入的字符个数大于%zd，忽略输入", maxLength);
        return NO;
    } else {
        return YES;
    }
    
}

#pragma mark - 重写set方法
- (void)setDetail:(NSString *)detail {
    _detail = [detail copy];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:detail];
    attr.yy_lineSpacing = 4;
    
    self.detailLB.attributedText = attr;
}

- (void)setCommitType:(KPCommitAuthCodeType)commitType {
    
    _commitType = commitType;
    
    NSString *btnTitle = nil;
    
    switch (self.commitType) {
        case KPCommitAuthCodeTypeChangePayPwdNext:
        case KPCommitAuthCodeTypeChangePhoneNext:
            btnTitle = @"下一步";
            break;
        case KPCommitAuthCodeTypeNormal:
        case KPCommitAuthCodeTypeChangePhoneDone:
        case KPCommitAuthCodeTypeAddBankCard:
            btnTitle = @"完成";
            break;
            
        default:
            break;
    }
    
    [self.nextStepBtn setTitle:btnTitle forState:UIControlStateNormal];
    
    
}

#pragma mark - 点击事件
- (void)clickNextStepButton {
    
    __weak typeof(self) weakSelf = self;
    
    [KPProgressHUD showLoading];
    [KPSMSTool commitVerificationCode:self.authCodeTF.text phoneNumber:self.phoneNumber result:^(NSError *error) {
        [KPProgressHUD hideLoading];

        if (!error) {
            WHYNSLog(@"验证成功");
            
            if (weakSelf.commitType == KPCommitAuthCodeTypeChangePhoneDone) {
                
                KPUserUpdateMobileParam *param = [KPUserUpdateMobileParam param];
                param.mobile = weakSelf.phoneNumber;
                
                [KPNetworkingTool userUpdateMobileWithParam:param success:^(id result) {
                    
                    NSInteger code = [result[@"code"] integerValue];
                    
                    if (code != 0) {
                        WHYNSLog(@"%zd -- %@", code, result[@"message"]);
                        return;
                    }
                    
                    [KPUserManager removeUser];
                    
                    [KPProgressHUD showSuccessWithStatus:@"修改成功" completion:^{
                        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                        NSPostNote(Noti_Relogin, nil);
                    }];
                    
                } failure:^(NSError *error) {
                    WHYNSLog(@"%@", error);
                }];
                
                [KPUserManager removeUser];
                
                [KPProgressHUD showSuccessWithStatus:@"修改成功" completion:^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    NSPostNote(Noti_Relogin, nil);
                }];
                return;
                
            }
            
            if (weakSelf.commitType == KPCommitAuthCodeTypeChangePayPwdNext) {
                KPNewPayPwdViewController *newPayPwdVc = [KPNewPayPwdViewController new];
                newPayPwdVc.needOldPayPwd = NO;
                newPayPwdVc.firstSetupPayPwd = NO;
                [weakSelf.navigationController pushViewController:newPayPwdVc animated:YES];
                return;
            }
            
            if (weakSelf.commitType == KPCommitAuthCodeTypeChangePhoneNext) {
                KPNewPhoneViewController *newPhoneVc = [KPNewPhoneViewController new];
                [weakSelf.navigationController pushViewController:newPhoneVc animated:YES];
                return;
            }

            if (weakSelf.commitType == KPCommitAuthCodeTypeAddBankCard) {
                [KPProgressHUD showSuccessWithStatus:@"绑定成功" completion:^{
                    [weakSelf.navigationController popToViewController:weakSelf.willPopToVc animated:YES];
                }];
                return;
            }
            
        }else {
            WHYNSLog(@"错误信息：%@",error);
            [KPProgressHUD showErrorWithStatus:@"验证码错误"];
            return;
        }
        
    }];
    
}

- (void)clickRetryAuthCodeButton {
    
    [self.view endEditing:YES];
    
    __weak typeof(self) weakSelf = self;
    [KPProgressHUD showLoading];
    [KPSMSTool getVerificationCodeByPhoneNumber:self.phoneNumber result:^(NSError *error) {
        [KPProgressHUD hideLoading];
        if (!error) {
            
            [KPProgressHUD showSuccessWithStatus:@"已重新发送验证码"];
            
            weakSelf.retryAuthCodeBtn.enabled = NO;
            
            [weakSelf.retryAuthCodeBtn setTitle:@"60秒后可以重新获取验证码" forState:UIControlStateDisabled];
            
            [weakSelf.timer fire];
            
        }else {
           WHYNSLog(@"错误信息：%@",error);
           [KPProgressHUD showErrorWithStatus:error.userInfo[@"getVerificationCode"]];
        }
        
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
    
    
    self.retryAuthCodeBtn.enabled = NO;
    [self.timer fire];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
    self.timeCount = 59;
    [self retryAuthCodeCountDown];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
    [self.authCodeTF becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)willDealloc {

    [self.authCodeTF removeFromSuperview];
    self.authCodeTF = nil;

    return NO;
}

#pragma mark - 私有方法
- (void)retryAuthCodeCountDown {
    
    self.timeCount++;
    
    NSString *title = [NSString stringWithFormat:@"%zd秒后可以重新获取验证码", 60 - self.timeCount];
    [self.retryAuthCodeBtn setTitle:title forState:UIControlStateDisabled];
    
    if (self.timeCount == 60) {
        self.timeCount = 0;
        self.retryAuthCodeBtn.enabled = YES;
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    [self.view addSubview:self.detailLB];
    [self.view addSubview:self.authCodeTF];
    [self.view addSubview:self.retryAuthCodeBtn];
    [self.view addSubview:self.nextStepBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat topMargin = 64;
    CGFloat leftRightMargin = 9;
    CGFloat textFieldH = 59;
    CGFloat btnTopMargin = 80;
    CGFloat btnH = 45;
    CGFloat retryTopMargin = 12;
    CGFloat retryH = 14;
    CGFloat detaileH = self.commitType == KPCommitAuthCodeTypeNormal ? 56 : 25;
    
    [self.detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(leftRightMargin);
        make.top.mas_equalTo(weakSelf.view).offset(topMargin);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRightMargin);
        make.height.mas_equalTo(detaileH);
    }];
    
    [self.authCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.detailLB.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [self.retryAuthCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.authCodeTF.mas_bottom).offset(retryTopMargin);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRightMargin);
        make.height.mas_equalTo(retryH);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.authCodeTF.mas_bottom).offset(btnTopMargin);
        make.left.mas_equalTo(weakSelf.view).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRightMargin);
        make.height.mas_equalTo(btnH);
    }];
    
}

- (void)setupNaigationBar {
    
    NSString *title = nil;
    
    switch (self.commitType) {
        case KPCommitAuthCodeTypeChangePayPwdNext:
            title = @"修改支付密码";
            break;
        case KPCommitAuthCodeTypeChangePhoneDone:
        case KPCommitAuthCodeTypeChangePhoneNext:
            title = @"修改手机验证";
            break;
        case KPCommitAuthCodeTypeNormal:
            title = @"短信验证";
            break;
        default:
            break;
    }
    
    self.navigationItem.title = title;
    
}

#pragma mark - 懒加载
- (KPTextField *)authCodeTF {
    if (_authCodeTF == nil) {
        _authCodeTF = [KPTextField textFieldWithTitle:@"验证码" placeHolder:@"请输入验证码"];
        _authCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _authCodeTF.delegate = self;
    }
    return _authCodeTF;
}

- (KPBottomButton *)nextStepBtn {
    if (_nextStepBtn == nil) {
        _nextStepBtn = [KPBottomButton bottomButtonWithTitle:@"下一步" target:self action:@selector(clickNextStepButton)];
    }
    return _nextStepBtn;
}

- (KPButton *)retryAuthCodeBtn {
    if (_retryAuthCodeBtn == nil) {
        _retryAuthCodeBtn = [KPButton new];
        [_retryAuthCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [_retryAuthCodeBtn setTitleColor:HexColor(#ff6d15) forState:UIControlStateNormal];
        [_retryAuthCodeBtn setTitleColor:HexColor(#8a8a8a) forState:UIControlStateDisabled];
        _retryAuthCodeBtn.titleLabel.font = UIFont_14;
        [_retryAuthCodeBtn addTarget:self
                              action:@selector(clickRetryAuthCodeButton)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryAuthCodeBtn;
}

- (UILabel *)detailLB {
    if (_detailLB == nil) {
        _detailLB = [UILabel new];
        _detailLB.font = UIFont_14;
        _detailLB.textColor = GrayColor;
        _detailLB.numberOfLines = 2;
    }
    return _detailLB;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(retryAuthCodeCountDown)
                                                userInfo:nil
                                                 repeats:YES];
    }
    return _timer;
}

@end
