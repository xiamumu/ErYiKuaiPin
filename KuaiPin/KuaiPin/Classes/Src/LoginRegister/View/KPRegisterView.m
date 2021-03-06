//
//  KPRegisterView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPRegisterView.h"
#import "KPTextField.h"
#import "KPBottomButton.h"

@interface KPRegisterView ()<KPTextFieldDelegate>

@property (nonatomic, strong) KPTextField *phoneTF;

@property (nonatomic, strong) KPTextField *authCodeTF;

@property (nonatomic, strong) KPButton *getAuthCodeBtn;

@property (nonatomic, strong) KPBottomButton *nextStepBtn;

@property (nonatomic, strong) KPButton *agreeBtn;

@property (nonatomic, strong) UILabel *agreeLB;

@property (nonatomic, strong) KPButton *serveProtocolBtn;


@end

@implementation KPRegisterView

- (void)setNextTitle:(NSString *)nextTitle {
    _nextTitle = [nextTitle copy];
    [self.nextStepBtn setTitle:nextTitle forState:UIControlStateNormal];
}

- (void)setHideKuaiPinServeProtocol:(BOOL)hideKuaiPinServeProtocol {
    _hideKuaiPinServeProtocol = hideKuaiPinServeProtocol;
    self.serveProtocolBtn.hidden = hideKuaiPinServeProtocol;
    self.agreeLB.hidden = hideKuaiPinServeProtocol;
    self.agreeBtn.hidden = hideKuaiPinServeProtocol;
}

- (void)agreeKuaiPinServeProtocol {
    self.agreeBtn.selected = YES;
}

- (void)setGetAuthCodeButtonEnabled:(BOOL)enabled {
    self.getAuthCodeBtn.enabled = enabled;
}

- (void)setGetAuthCodeButtonTitle:(NSString *)title state:(UIControlState)state {
    [self.getAuthCodeBtn setTitle:title forState:state];
}

#pragma mark - KPTextFieldDelegate
- (BOOL)textField:(KPTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 0) return YES;
    
    if (string.isEmoji) return NO;
    
    NSInteger maxLength = [textField isEqual:self.phoneTF] ? 11 : 99;
    
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        
        if ([textField isEqual:self.phoneTF]) {
            
            [self clickGetAuthCodeButton];
            [self.authCodeTF becomeFirstResponder];
        }else {
            [self clickNextStepButton];
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

#pragma mark - 点击方法
- (void)clickGetAuthCodeButton {
    
    if (self.GetAuthCodeHandler) {
        
        BOOL isRetry = [self.getAuthCodeBtn.currentTitle isEqualToString:@"重新获取验证码"];
        
        self.GetAuthCodeHandler(self.phoneTF.text, isRetry);
    }
    
}

- (void)clickNextStepButton {
    
    if (self.nextStepHandler) {
        self.nextStepHandler(self.authCodeTF.text, self.phoneTF.text, self.agreeBtn.selected);
    }
}

- (void)clickAgreeButton {
    self.agreeBtn.selected = !self.agreeBtn.selected;
}

- (void)clickServeProtocolButton {

    if (self.clickKuaiPinServeProtocolHandler) {
        self.clickKuaiPinServeProtocolHandler();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - 类方法
+ (instancetype)registerViewWithFrame:(CGRect)frame
                      nextStepHandler:(NextStepHandler)nextStepHandler
     clickKuaiPinServeProtocolHandler:(ClickKuaiPinServeProtocolHandler)clickKuaiPinServeProtocolHandler {
    
    KPRegisterView *registerView = [[KPRegisterView alloc] initWithFrame:frame];
    registerView.nextStepHandler = nextStepHandler;
    registerView.clickKuaiPinServeProtocolHandler = clickKuaiPinServeProtocolHandler;
    
    return registerView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self.phoneTF becomeFirstResponder];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupUI {
    
    self.backgroundColor = ViewBgColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:self.phoneTF];
    [self addSubview:sep];
    [self addSubview:self.authCodeTF];
    [self addSubview:self.getAuthCodeBtn];
    [self addSubview:self.nextStepBtn];
    [self addSubview:self.agreeBtn];
    [self addSubview:self.agreeLB];
    [self addSubview:self.serveProtocolBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat topMargin = 89;
    CGFloat leftRightMargin = 9;
    CGFloat textFieldH = 59;
    CGFloat agreeWH = self.agreeBtn.currentImage.size.width;
    CGFloat agreeTopMargin = 14;
    CGSize agreeSize = [self.agreeLB.text sizeWithAttributes:@{NSFontAttributeName : self.agreeLB.font}];
    CGFloat btnTopMargin = 80;
    CGFloat btnH = 45;
    CGFloat retryTopMargin = 12;
    CGFloat retryH = 14;
    CGFloat sepH = 1;
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf).offset(topMargin);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf.phoneTF.mas_bottom);
        make.height.mas_equalTo(sepH);
    }];
    
    [self.authCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneTF.mas_bottom);
        make.left.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [self.getAuthCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.authCodeTF.mas_bottom).offset(retryTopMargin);
        make.right.mas_equalTo(weakSelf).offset(-leftRightMargin);
        make.height.mas_equalTo(retryH);
    }];
    
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.authCodeTF.mas_bottom).offset(btnTopMargin);
        make.left.mas_equalTo(weakSelf).offset(leftRightMargin);
        make.right.mas_equalTo(weakSelf).offset(-leftRightMargin);
        make.height.mas_equalTo(btnH);
    }];
    
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRightMargin);
        make.centerY.mas_equalTo(weakSelf.agreeLB);
        make.width.height.mas_equalTo(agreeWH);
    }];
    
    [self.agreeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.agreeBtn.mas_right).offset(leftRightMargin);
        make.top.mas_equalTo(weakSelf.nextStepBtn.mas_bottom).offset(agreeTopMargin);
        make.size.mas_equalTo(agreeSize);
    }];
    
    [self.serveProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.agreeLB.mas_right);
        make.centerY.mas_equalTo(weakSelf.agreeLB);
        make.height.mas_equalTo(weakSelf.agreeLB);
    }];
    
    
    
}

#pragma mark - 懒加载
- (KPTextField *)phoneTF {
    if (_phoneTF == nil) {
        _phoneTF = [KPTextField textFieldWithImgName:@"phone" title:nil placeHolder:@"请输入手机号"];
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.midMargin = 70;
        _phoneTF.delegate = self;
    }
    return _phoneTF;
}

- (KPTextField *)authCodeTF {
    if (_authCodeTF == nil) {
        _authCodeTF = [KPTextField textFieldWithImgName:nil title:@"验证码" placeHolder:@"请输入验证码"];
        _authCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _authCodeTF.midMargin = 70;
        _authCodeTF.delegate = self;
    }
    return _authCodeTF;
}

- (KPButton *)getAuthCodeBtn {
    if (_getAuthCodeBtn == nil) {
        _getAuthCodeBtn = [KPButton new];
        [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getAuthCodeBtn setTitleColor:HexColor(#ff6d15) forState:UIControlStateNormal];
        [_getAuthCodeBtn setTitleColor:HexColor(#8a8a8a) forState:UIControlStateDisabled];
        _getAuthCodeBtn.titleLabel.font = UIFont_14;
        [_getAuthCodeBtn addTarget:self
                              action:@selector(clickGetAuthCodeButton)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _getAuthCodeBtn;
}

- (KPBottomButton *)nextStepBtn {
    if (_nextStepBtn == nil) {
        _nextStepBtn = [KPBottomButton bottomButtonWithTitle:@"下一步"];
        [_nextStepBtn addTarget:self action:@selector(clickNextStepButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}

- (KPButton *)agreeBtn {
    if (_agreeBtn == nil) {
        _agreeBtn = [KPButton new];
        [_agreeBtn setImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"cart_select"] forState:UIControlStateSelected];
        _agreeBtn.selected = YES;
        [_agreeBtn addTarget:self action:@selector(clickAgreeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}

- (UILabel *)agreeLB {
    if (_agreeLB == nil) {
        _agreeLB = [UILabel new];
        _agreeLB.font = UIFont_14;
        _agreeLB.textColor = GrayColor;
        _agreeLB.text = @"我已阅读并同意";
    }
    return _agreeLB;
}

- (KPButton *)serveProtocolBtn {
    if (_serveProtocolBtn == nil) {
        _serveProtocolBtn = [KPButton new];
        [_serveProtocolBtn setTitleColor:HexColor(#ff6d15) forState:UIControlStateNormal];
        _serveProtocolBtn.titleLabel.font = UIFont_14;
        [_serveProtocolBtn setTitle:@"《二一快品服务协议》" forState:UIControlStateNormal];
        [_serveProtocolBtn addTarget:self
                              action:@selector(clickServeProtocolButton)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _serveProtocolBtn;
}


@end















