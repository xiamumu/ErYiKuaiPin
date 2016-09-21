//
//  KPAuthCodeView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPRegisterPwdView.h"
#import "KPTextField.h"
#import "KPBottomButton.h"

@interface KPRegisterPwdView ()<KPTextFieldDelegate>

@property (nonatomic, strong) KPTextField *pwdTF;

@property (nonatomic, strong) KPTextField *repeatPwdTF;

@property (nonatomic, strong) KPBottomButton *registerBtn;

@property (nonatomic, strong) UILabel *tipLB;

@end

@implementation KPRegisterPwdView

- (void)setBottomBtnTitle:(NSString *)bottomBtnTitle {
    _bottomBtnTitle = [bottomBtnTitle copy];
    self.registerBtn.btnTitle = bottomBtnTitle;
}

#pragma mark - KPTextFieldDelegate
- (BOOL)textField:(KPTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 0) return YES;
    
    if (string.isEmoji) return NO;
    
    NSInteger maxLength = 21;
    
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        
        if ([textField isEqual:self.pwdTF]) {
            [self.repeatPwdTF becomeFirstResponder];
        }else {
            [self clickRegisterButton];
        }
        
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

- (void)clickRegisterButton {
    
    if (self.registerHandler) {
        self.registerHandler(self.pwdTF.text, self.repeatPwdTF.text);
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - 类方法
+ (instancetype)registerPwdViewWithFrame:(CGRect)frame
                         registerHandler:(RegisterHandler)registerHandler {
    
    KPRegisterPwdView *authCodeView = [[KPRegisterPwdView alloc] initWithFrame:frame];
    authCodeView.registerHandler = registerHandler;
    return authCodeView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self.pwdTF becomeFirstResponder];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupUI {
    
    self.backgroundColor = ViewBgColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    
    [self addSubview:self.pwdTF];
    [self addSubview:self.repeatPwdTF];
    [self addSubview:self.tipLB];
    [self addSubview:self.registerBtn];
    [self addSubview:sep];
    
    __weak typeof(self) weakSelf = self;
    CGFloat topMargin = 89;
    CGFloat textFieldH = 59;
    CGFloat leftRightMargin = 9;
    CGFloat registerTopMargin = 59;
    CGFloat registerH = 45;
    CGFloat sepH = 1;
    CGFloat tipTopMargin = 12;
    CGSize tipSize = [self.tipLB.text sizeWithAttributes:@{NSFontAttributeName : self.tipLB.font}];
    
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(textFieldH);
        make.top.mas_equalTo(weakSelf).offset(topMargin);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf.pwdTF.mas_bottom);
        make.height.mas_equalTo(sepH);
    }];
    
    [self.repeatPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(weakSelf.pwdTF);
        make.top.mas_equalTo(weakSelf.pwdTF.mas_bottom);
    }];
    
    
    
    [self.tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.repeatPwdTF.mas_bottom).offset(tipTopMargin);
        make.left.mas_equalTo(weakSelf).offset(leftRightMargin);
        make.size.mas_equalTo(tipSize);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.repeatPwdTF.mas_bottom).offset(registerTopMargin);
        make.left.mas_equalTo(weakSelf).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf).offset(-leftRightMargin);
        make.height.mas_equalTo(registerH);
    }];
    
}

#pragma mark - 懒加载


- (KPTextField *)pwdTF {
    if (_pwdTF == nil) {
        _pwdTF = [KPTextField textFieldWithImgName:nil title:@"登录密码" placeHolder:@"请输入登录密码"];
        _pwdTF.secureTextEntry = YES;
        _pwdTF.delegate = self;
    }
    return _pwdTF;
}

- (KPTextField *)repeatPwdTF {
    if (_repeatPwdTF == nil) {
        _repeatPwdTF = [KPTextField textFieldWithImgName:nil title:@"重复密码" placeHolder:@"再次输入密码"];
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

- (KPBottomButton *)registerBtn {
    if (_registerBtn == nil) {
        _registerBtn = [KPBottomButton bottomButtonWithTitle:@"注册"];
        [_registerBtn addTarget:self action:@selector(clickRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

@end
