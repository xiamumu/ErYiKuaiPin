//
//  KPTextField.m
//  KuaiPin
//
//  Created by 王洪运 on 16/8/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPTextField.h"
#import "KPButton.h"
#import <YYText.h>
#import "KPIDCardInputView.h"

@interface KPTextField ()<UITextFieldDelegate, KPIDCardInputViewDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) KPButton *titleBtn;

@end

@implementation KPTextField

#pragma mark - KPIDCardInputViewDelegate
- (void)inputView:(KPIDCardInputView *)inputView didInputWithNewString:(NSString *)string {

    BOOL shouldReplace = [self textField:self.textField
           shouldChangeCharactersInRange:NSRangeFromString(self.textField.text)
                       replacementString:string];
    if (!shouldReplace) return;

    if (string.length) {
        self.textField.text = [self.textField.text stringByAppendingString:string];
        return;
    }

    if (self.textField.text.length != 0 && (string.length == 0)) {
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length - 1];
    }

}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textField: shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return self.editing;
}

#pragma mark - 类方法
+ (instancetype)textFieldWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder {

    KPTextField *tf = [KPTextField new];
    tf.placeHolder = placeHolder;
    tf.title = title;

    return tf;
}

+ (instancetype)textFieldWithImgName:(NSString *)imgName title:(NSString *)title placeHolder:(NSString *)placeHolder {

    KPTextField *tf = [KPTextField textFieldWithTitle:title placeHolder:placeHolder];
    tf.imgName = imgName;

    return tf;
}

#pragma mark - 重写set方法
- (void)setInputView:(__kindof UIView *)inputView {
    _inputView = inputView;
    self.textField.inputView = inputView;
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
    _clearButtonMode = clearButtonMode;
    self.textField.clearButtonMode = clearButtonMode;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (void)setKeyboardType:(KPKeybordType)keyboardType {
    _keyboardType = keyboardType;

    if (keyboardType == KPKeyboardTypeIDCard) {
        KPIDCardInputView *inputView = [KPIDCardInputView IDCardInputViewWithDelegate:self];
        self.textField.inputView =  inputView;
    }else {
        self.textField.inputView = nil;
        NSInteger type = keyboardType;
        self.textField.keyboardType = type;
    }

}

- (void)setMidMargin:(CGFloat)midMargin {
    _midMargin = midMargin;
    __weak typeof(self) weakSelf = self;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(midMargin);
    }];
}

- (void)setTitle:(NSString *)title {

    if (title.length == 0) return;

    _title = [title copy];

    [self.titleBtn setTitle:title forState:UIControlStateNormal];

    __weak typeof(self) weakSelf = self;
    CGFloat left = 9;

    [self.titleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(left);
        make.centerY.mas_equalTo(weakSelf.textField);
    }];

    CGFloat textFieldLeft = 93;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(textFieldLeft);
    }];

}

- (void)setImgName:(NSString *)imgName {

    if (imgName.length == 0) return;

    _imgName = [imgName copy];

    [self.titleBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];

    __weak typeof(self) weakSelf = self;
    CGFloat left = 15;
    CGFloat H = self.titleBtn.currentImage.size.height;
    CGFloat W = 20;

    [self.titleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(left);
        make.centerY.mas_equalTo(weakSelf.textField);
        make.height.mas_equalTo(H);
        make.width.mas_equalTo(W);
    }];

    CGFloat textFieldLeft = 57;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(textFieldLeft);
    }];

}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;

    self.textField.secureTextEntry = secureTextEntry;
}

- (void)setPlaceHolder:(NSString *)placeHolder {

    if (placeHolder.length == 0) return;

    _placeHolder = [placeHolder copy];

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:placeHolder];
    attr.yy_font = UIFont_16;
    attr.yy_color = GrayColor;
    self.textField.attributedPlaceholder = [attr copy];

}

#pragma mark - 重写get方法
- (NSString *)text {
    return self.textField.text;
}

#pragma mark - 重写父类方法
- (BOOL)isFirstResponder {
    return self.textField.isFirstResponder;
}

- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    return [self.textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    return [self.textField resignFirstResponder];
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.editing = YES;
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupUI {

    self.backgroundColor = WhiteColor;

    [self addSubview:self.titleBtn];
    [self addSubview:self.textField];

    __weak typeof(self) weakSelf = self;
    CGFloat right = 9;
    CGFloat top = 12;
    CGFloat left = 93;
    CGFloat H = 35;

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(left);
        make.right.mas_equalTo(weakSelf).offset(-right);
        make.top.mas_equalTo(top);
        make.height.mas_equalTo(H);
    }];

}

#pragma mark - 懒加载
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.delegate = self;
    }
    return _textField;
}

- (KPButton *)titleBtn {
    if (_titleBtn == nil) {
        _titleBtn = [KPButton new];
        _titleBtn.titleLabel.font = UIFont_16;
        [_titleBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    }
    return _titleBtn;
}



@end
