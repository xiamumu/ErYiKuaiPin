//
//  KPNewPhoneViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPNewPhoneViewController.h"
#import "KPTextField.h"
#import "KPBottomButton.h"
#import "KPCommitAuthCodeViewController.h"
#import "KPSMSTool.h"

@interface KPNewPhoneViewController ()<KPTextFieldDelegate>

@property (nonatomic, strong) KPBottomButton *nextStepBtn;

@property (nonatomic, strong) KPTextField *phoneTF;

@end

@implementation KPNewPhoneViewController

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

#pragma mark - 点击事件
- (void)clickNextStepButton {
    
    if (!self.phoneTF.text.isPhoneString) {
        [KPProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    

    [KPProgressHUD showLoading];
    [KPSMSTool getVerificationCodeByPhoneNumber:self.phoneTF.text result:^(NSError *error) {
        [KPProgressHUD hideLoading];
        if (!error) {
            KPCommitAuthCodeViewController *authCodeVc = [KPCommitAuthCodeViewController new];
            authCodeVc.commitType = KPCommitAuthCodeTypeChangePhoneDone;
            authCodeVc.phoneNumber = weakSelf.phoneTF.text;
            [weakSelf.navigationController pushViewController:authCodeVc animated:YES];
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
    [self.phoneTF becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

#pragma mark - 私有方法

- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    [self.view addSubview:self.phoneTF];
    [self.view addSubview:self.nextStepBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat topMargin = 89;
    CGFloat leftRightMargin = 9;
    CGFloat textFieldH = 59;
    CGFloat btnTopMargin = 80;
    CGFloat btnH = 45;
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(topMargin);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneTF.mas_bottom).offset(btnTopMargin);
        make.left.mas_equalTo(weakSelf.view).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRightMargin);
        make.height.mas_equalTo(btnH);
    }];
    
}

- (void)setupNaigationBar {
    
    self.navigationItem.title = @"修改手机验证";
    
}

#pragma mark - 懒加载
- (KPTextField *)phoneTF {
    if (_phoneTF == nil) {
        _phoneTF = [KPTextField textFieldWithTitle:@"新手机号" placeHolder:@"请输入新手机号"];
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.delegate = self;
    }
    return _phoneTF;
}

- (KPBottomButton *)nextStepBtn {
    if (_nextStepBtn == nil) {
        _nextStepBtn = [KPBottomButton bottomButtonWithTitle:@"下一步" target:self action:@selector(clickNextStepButton)];
    }
    return _nextStepBtn;
}




@end
