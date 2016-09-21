//
//  KPBankCardInputController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBankCardInputController.h"
#import "KPTextField.h"
#import "KPBottomButton.h"
#import "KPCommitAuthCodeViewController.h"
#import "KPSMSTool.h"

@interface KPBankCardInputController ()<KPTextFieldDelegate>

@property (nonatomic, strong) UILabel *tipLB;

@property (nonatomic, strong) KPTextField *nameLB;

@property (nonatomic, strong) KPTextField *bankCardNumLB;

@property (nonatomic, strong) KPTextField *phoneNumLB;

@property (nonatomic, strong) KPBottomButton *nextBtn;

@end

@implementation KPBankCardInputController

- (BOOL)textField:(KPTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 0) return YES;
    
    if (string.isEmoji) return NO;
    
    NSInteger maxLength = [textField isEqual:self.bankCardNumLB] ? 50 : 11;
    
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        
        if ([textField isEqual:self.bankCardNumLB]) {
            [self.phoneNumLB becomeFirstResponder];
        }else {
            [self clickNextButton];
        }
        
        return NO;
    } else if(textField.text.length >= maxLength) {
        //输入的字符个数大于maxLength，则无法继续输入，返回NO表示禁止输入
        WHYNSLog(@"输入的字符个数大于%zd，忽略输入", maxLength);
        return NO;
    }
    
    return YES;
}

#pragma mark - 点击事件
- (void)clickNextButton {
    
    __weak typeof(self) weakSelf = self;
    
    if (!self.bankCardNumLB.text.isNumber) {
        [KPProgressHUD showErrorWithStatus:@"请输入正确的银行卡号"];
        return;
    }
    
    if (!self.phoneNumLB.text.isPhoneString) {
        [KPProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    self.addBankCardParam.cardNo = self.bankCardNumLB.text;
    self.addBankCardParam.mobile = self.phoneNumLB.text;

    [KPNetworkingTool addBankCardWithParam:self.addBankCardParam success:^(id result) {
        
        NSInteger code = [result[@"code"] integerValue];
        NSString *message = result[@"message"];
        WHYNSLog(@"%zd -- %@", code, message);

        if (code == 10008) {
            [KPProgressHUD showErrorWithStatus:@"失败次数过多，请24小时后再绑定"];
            return;
        }

        if (code == 10009) {
            [KPProgressHUD showErrorWithStatus:@"此银行卡已存在，请更换银行卡"];
            return;
        }

        if (code != 0) {

            if ([message isEqualToString:@"不支持的银行卡"]) {
                [KPProgressHUD showErrorWithStatus:@"不支持的银行卡"];
            }else {
                [KPProgressHUD showErrorWithStatus:@"绑定失败，请检查您的信息是否有误"];
            }

            return;
        }
        
        [KPSMSTool getVerificationCodeByPhoneNumber:weakSelf.phoneNumLB.text result:^(NSError *error) {

            if (!error) {
                WHYNSLog(@"获取验证码成功");

                KPCommitAuthCodeViewController *commitAuthCodeVc = [KPCommitAuthCodeViewController new];
                commitAuthCodeVc.commitType = KPCommitAuthCodeTypeAddBankCard;
                commitAuthCodeVc.phoneNumber = weakSelf.phoneNumLB.text;
                commitAuthCodeVc.willPopToVc = weakSelf.popToVC;
                [weakSelf.navigationController pushViewController:commitAuthCodeVc animated:YES];

            } else {
                WHYNSLog(@"错误信息：%@",error);
                [KPProgressHUD showErrorWithStatus:error.userInfo[@"getVerificationCode"]];
            }

        }];

    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
    }];

}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupNavigationBar];
    
    self.nameLB.text = self.addBankCardParam.realName;
    
    [self.bankCardNumLB becomeFirstResponder];
    
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

#pragma mark - 私有方法
- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    [self.view addSubview:self.tipLB];
    [self.view addSubview:self.nameLB];
    [self.view addSubview:self.bankCardNumLB];
    [self.view addSubview:self.phoneNumLB];

    __weak typeof(self) weakSelf = self;
    
    CGFloat top = 64;
    CGFloat leftRight = 9;
    CGFloat tipH = 38;
    CGFloat textFieldH = 56;

    [self.tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(top);
        make.left.mas_equalTo(weakSelf.view).offset(leftRight);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRight);
        make.height.mas_equalTo(tipH);
    }];
    
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tipLB.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [self.bankCardNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLB.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [self.phoneNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.bankCardNumLB.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(textFieldH);
    }];

}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"绑定银行卡";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.nextBtn];
    
}

#pragma mark - 懒加载
- (UILabel *)tipLB {
    if (_tipLB == nil) {
        _tipLB = [UILabel new];
        _tipLB.font = UIFont_14;
        _tipLB.textColor = GrayColor;
        _tipLB.text = @"请绑定本人的银行卡";
    }
    return _tipLB;
}

- (KPTextField *)nameLB {
    if (_nameLB == nil) {
        _nameLB = [KPTextField textFieldWithTitle:@"持卡人" placeHolder:@""];
        _nameLB.editing = NO;
        _nameLB.clearButtonMode = UITextFieldViewModeNever;
    }
    return _nameLB;
}

- (KPTextField *)bankCardNumLB {
    if (_bankCardNumLB == nil) {
        _bankCardNumLB = [KPTextField textFieldWithTitle:@"银行卡号" placeHolder:@"请输入银行卡号"];
        _bankCardNumLB.keyboardType = UIKeyboardTypeNumberPad;
        _bankCardNumLB.delegate = self;
    }
    return _bankCardNumLB;
}

- (KPTextField *)phoneNumLB {
    if (_phoneNumLB == nil) {
        _phoneNumLB = [KPTextField textFieldWithTitle:@"手机号码" placeHolder:@"请填写银行预留的号码"];
        _phoneNumLB.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumLB.delegate = self;
    }
    return _phoneNumLB;
}

- (KPBottomButton *)nextBtn {
    if (_nextBtn == nil) {
        _nextBtn = [KPBottomButton bottomButtonWithTitle:@"下一步" imgName:nil target:self action:@selector(clickNextButton)];
        _nextBtn.frame = CGRectMake(0, 0, 75, 30);
    }
    return _nextBtn;
}




@end
