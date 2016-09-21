//
//  KPPayPwdTextField.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayPwdTextField.h"

#define kDotCount 6

@interface KPPayPwdTextField ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSMutableArray<UIView *> *dots;

@property (nonatomic, assign) NSInteger lastDotIndex;

@end

@implementation KPPayPwdTextField

- (NSString *)text {
    return self.textField.text;
}

- (void)clearPayPwd {
    self.textField.text = @"";
    [self hideAllDots];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField becomeFirstResponder];
}

- (void)showNextDot {
//    WHYNSLog(@"%zd", self.lastDotIndex);
    self.dots[self.lastDotIndex].hidden = NO;
    self.lastDotIndex++;
}

- (void)hideLastDot {
    self.dots[self.lastDotIndex].hidden = YES;
    self.lastDotIndex--;
}

- (void)hideAllDots {
    for (int i = 0; i < self.dots.count; i++) {
        self.dots[i].hidden = YES;
    }
    self.textField.text = @"";
    self.lastDotIndex = 0;
}

- (void)showAllDots {
    for (int i = 0; i < self.dots.count; i++) {
        self.dots[i].hidden = NO;
    }
    
    if (self.inputCompletion) {
        self.inputCompletion(self.textField.text);
    }
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSInteger length = textField.text.length;
    
    if(string.length == 0) {
        //判断是不是删除键
        [self hideLastDot];
        
        if (length > 0) {
            length--;
        }
        
        if (length == 0) {
            [self hideAllDots];
        }
        
        return YES;
    }
    
    if (string.isEmoji) return NO;
    
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        WHYNSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        
        [self showNextDot];
        
        if (length < 6) {
            length++;
        }
        
        if (length == 6) {
            textField.text = [NSString stringWithFormat:@"%@%@", textField.text, string];
            [self showAllDots];
            return NO;
        }
        
        return YES;
    }
}

- (void)setLastDotIndex:(NSInteger)lastDotIndex {
    if (lastDotIndex < 0) {
        _lastDotIndex = 0;
    }else if (lastDotIndex > 5) {
        _lastDotIndex = 5;
    }else {
        _lastDotIndex = lastDotIndex;
    }
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
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block"]];
    
    [self addSubview:bg];
    [self addSubview:self.textField];
    
    __weak typeof(self) weakSelf = self;
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    CGFloat sepW = 1;
    CGFloat sepLeft = 40;
    for (int i = 1; i < kDotCount; i++) {
        KPSeparatorView *sep = [KPSeparatorView new];
        [self addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(weakSelf);
            make.centerX.mas_equalTo(weakSelf.mas_left).offset(sepLeft * i);
            make.width.mas_equalTo(sepW);
        }];
    }
    
    CGSize dotSize = CGSizeMake (10.0f,10.0f);
    for (int i = 0; i < kDotCount; i++) {
        UIView *dot = [UIView new];
        dot.backgroundColor = BlackColor;
        dot.layer.cornerRadius = 5;
        dot.hidden = YES;
        [self.dots addObject:dot];
        [self addSubview:dot];
        
        CGFloat centerX = 20 + i * 40;
        
        [dot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf);
            make.centerX.mas_equalTo(weakSelf.mas_left).offset(centerX);;
            make.size.mas_equalTo(dotSize);
        }];
        
    }
    
}

- (BOOL)becomeFirstResponder {
    [self.textField becomeFirstResponder];
    return [super becomeFirstResponder];
}

#pragma mark - 懒加载
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.hidden = YES;
    }
    return _textField;
}

- (NSMutableArray<UIView *> *)dots {
    if (_dots == nil) {
        _dots = [NSMutableArray array];
    }
    return _dots;
}

@end
