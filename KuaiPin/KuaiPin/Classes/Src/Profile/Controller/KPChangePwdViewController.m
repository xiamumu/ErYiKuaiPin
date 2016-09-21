//
//  KPChangePwdViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPChangePwdViewController.h"
#import "KPTextField.h"
#import "KPBottomButton.h"
#import "KPChangePwdParam.h"
#import "UIBarButtonItem+XM.h"
#import "KPForgetPwdViewController.h"

@interface KPChangePwdViewController ()<KPTextFieldDelegate>

@property (nonatomic, strong) KPTextField *oldPwdTF;

@property (nonatomic, strong) KPTextField *pwdTF;

@property (nonatomic, strong) KPTextField *repeatPwdTF;

@property (nonatomic, strong) KPBottomButton *doneBtn;

@property (nonatomic, strong) UILabel *tipLB;

@end

@implementation KPChangePwdViewController

#pragma mark - KPTextFieldDelegate
- (BOOL)textField:(KPTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 0) return YES;
    
    if (string.isEmoji) return NO;
    
    NSInteger maxLength = 12;
    
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        
        if ([textField isEqual:self.oldPwdTF]) {
            [self.pwdTF becomeFirstResponder];
        }else if ([textField isEqual:self.pwdTF]) {
            [self.repeatPwdTF becomeFirstResponder];
        }else {
            [self clickDoneButton];
        }

        return NO;
    } else if(textField.text.length >= maxLength) {
//        输入的字符个数大于maxLength，则无法继续输入，返回NO表示禁止输入
        WHYNSLog(@"输入的字符个数大于%zd，忽略输入", maxLength);
        return NO;
    } else {
        return YES;
    }
    
}

#pragma mark - 点击事件
- (void)forgetPwd {
    WHYNSLog(@"忘记密码！");

    KPForgetPwdViewController *forgetVc = [KPForgetPwdViewController new];
    [self.navigationController pushViewController:forgetVc animated:YES];
    
}

- (void)clickDoneButton {
    
    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.pwdTF.text.length < 6 || weakSelf.pwdTF.text.length > 12) {
        [KPProgressHUD showErrorWithStatus:@"请输入6-12位新密码"];
        return;
    }
    
    if ([weakSelf.oldPwdTF.text isEqualToString:weakSelf.pwdTF.text]) {
        [KPProgressHUD showErrorWithStatus:@"请输入不同的密码"];
        return;
    }
    
    if (![weakSelf.pwdTF.text isEqualToString:weakSelf.repeatPwdTF.text]) {
        [KPProgressHUD showErrorWithStatus:@"密码不一致"];
        return;
    }
    
    KPChangePwdParam *param = [KPChangePwdParam param];
    param.password = weakSelf.oldPwdTF.text;
    param.nPassword = weakSelf.pwdTF.text;
    
    
    [KPNetworkingTool changePwdWithParam:param success:^(id result) {
        
        NSInteger code = [result[@"code"] integerValue];
        
        if (code != 0) {
            WHYNSLog(@"%zd -- %@", code, result[@"message"]);
            return;
        }
        
        [KPUserManager sharedUserManager].userModel.password = param.nPassword;
        [KPUserManager updateUser];
        
        [KPProgressHUD showSuccessWithStatus:@"修改成功" completion:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        
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
    
    [self.oldPwdTF becomeFirstResponder];
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
    
    KPSeparatorView *sepOne = [KPSeparatorView new];
    KPSeparatorView *sepTwo = [KPSeparatorView new];
    
    [self.view addSubview:self.oldPwdTF];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.repeatPwdTF];
    [self.view addSubview:self.tipLB];
    [self.view addSubview:self.doneBtn];
    [self.view addSubview:sepOne];
    [self.view addSubview:sepTwo];
    
    __weak typeof(self) weakSelf = self;
    CGFloat topMargin = 89;
    CGFloat leftRightMargin = 9;
    CGFloat textFieldH = 59;
    CGFloat registerTopMargin = 59;
    CGFloat registerH = 45;
    CGFloat sepH = 1;
    CGFloat tipTopMargin = 12;
    CGSize tipSize = [self.tipLB.text sizeWithAttributes:@{NSFontAttributeName : self.tipLB.font}];
    
    [self.oldPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(topMargin);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [sepOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf.view);
        make.centerY.mas_equalTo(weakSelf.oldPwdTF.mas_bottom);
        make.height.mas_equalTo(sepH);
    }];
    
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(weakSelf.oldPwdTF);
        make.top.mas_equalTo(weakSelf.oldPwdTF.mas_bottom);
    }];
    
    [sepTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(sepOne);
        make.centerY.mas_equalTo(weakSelf.pwdTF.mas_bottom);
    }];
    
    [self.repeatPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(weakSelf.pwdTF);
        make.top.mas_equalTo(weakSelf.pwdTF.mas_bottom);
    }];
    
    [self.tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.repeatPwdTF.mas_bottom).offset(tipTopMargin);
        make.left.mas_equalTo(weakSelf.view).offset(leftRightMargin);
        make.size.mas_equalTo(tipSize);
    }];
    
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.repeatPwdTF.mas_bottom).offset(registerTopMargin);
        make.left.mas_equalTo(weakSelf.view).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRightMargin);
        make.height.mas_equalTo(registerH);
    }];
    
}

- (void)setupNaigationBar {
    
    self.navigationItem.title = @"修改登录密码";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"忘记密码"
                                                                 titleColor:OrangeColor
                                                            hightLightColor:OrangeColor
                                                                      targe:self
                                                                     action:@selector(forgetPwd)];
    
}

#pragma mark - 懒加载
- (KPTextField *)oldPwdTF {
    if (_oldPwdTF == nil) {
        _oldPwdTF = [KPTextField textFieldWithTitle:@"旧密码" placeHolder:@"请输入登录密码"];
        _oldPwdTF.secureTextEntry = YES;
        _oldPwdTF.delegate = self;
    }
    return _oldPwdTF;
}

- (KPTextField *)pwdTF {
    if (_pwdTF == nil) {
        _pwdTF = [KPTextField textFieldWithTitle:@"新密码" placeHolder:@"请输入新登录密码"];
        _pwdTF.secureTextEntry = YES;
        _pwdTF.delegate = self;
    }
    return _pwdTF;
}

- (KPTextField *)repeatPwdTF {
    if (_repeatPwdTF == nil) {
        _repeatPwdTF = [KPTextField textFieldWithTitle:@"重复密码" placeHolder:@"请重新输入密码"];
        _repeatPwdTF.secureTextEntry = YES;
        _repeatPwdTF.delegate = self;
    }
    return _repeatPwdTF;
}

- (UILabel *)tipLB {
    if (_tipLB == nil) {
        _tipLB = [UILabel new];
        _tipLB.font = UIFont_12;
        _tipLB.textColor = GrayColor;
        _tipLB.text = @"请输入6-12位字母+数字组成的密码";
    }
    return _tipLB;
}

- (KPBottomButton *)doneBtn {
    if (_doneBtn == nil) {
        _doneBtn = [KPBottomButton bottomButtonWithTitle:@"确定" target:self action:@selector(clickDoneButton)];
    }
    return _doneBtn;
}



@end
