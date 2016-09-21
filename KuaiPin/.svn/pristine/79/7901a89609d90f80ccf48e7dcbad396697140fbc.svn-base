//
//  KPSearchTextField.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/16.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSearchTextField.h"

@interface KPSearchTextField ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) KPButton *cancelBtn;

@end

@implementation KPSearchTextField

#pragma mark - 点击事件
- (void)clickCancelButton {
    if (self.CancelHandler) {
        self.CancelHandler();
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    WHYNSLog(@"%@", string);

    if (string.length == 0) return YES;

    if([string isEqualToString:@"\n"]) {
        if (self.SearchHandler) {
            self.SearchHandler(self.textField.text);
        }
        textField.text = @"";
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - 重写set方法
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    self.textField.placeholder = placeholder;
}

#pragma mark - 重写父类方法
- (BOOL)becomeFirstResponder {
    [self.textField becomeFirstResponder];
    return [super becomeFirstResponder];
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    UIView *bg = [UIView new];
    bg.backgroundColor = ViewBgColor;
    bg.layer.cornerRadius = 4;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:bg];
    [self addSubview:self.iconView];
    [self addSubview:self.textField];
    [self addSubview:self.cancelBtn];
    [self addSubview:sep];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat leftRight = 9;
    CGFloat bgH = 28;
    CGFloat margin = 8;
    CGFloat iconWH = 13;
    CGFloat sepH = 1;
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRight);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(bgH);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(margin);
        make.centerY.mas_equalTo(bg);
        make.width.height.mas_equalTo(iconWH);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(margin);
        make.top.right.bottom.mas_equalTo(bg);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_right).offset(leftRight);
        make.right.mas_equalTo(weakSelf).offset(-leftRight);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    }
    return _iconView;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.font = UIFont_13;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySearch;
    }
    return _textField;
}

- (KPButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [KPButton new];
        _cancelBtn.titleLabel.font = UIFont_14;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:HexColor(#191919) forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
