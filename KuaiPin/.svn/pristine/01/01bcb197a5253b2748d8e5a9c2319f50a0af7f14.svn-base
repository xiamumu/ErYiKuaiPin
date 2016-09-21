//
//  KPCommonTextField.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCommonTextField.h"
#import <YYText.h>


@interface XMTextField :UITextField

@end

@implementation XMTextField
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = BlackColor;
        self.font = UIFont_24;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    CGFloat X = CommonMargin;
    CGFloat H = 16;
    CGFloat Y = 5;
    CGFloat W = self.width - CommonMargin;
    return CGRectMake(X, Y, W, H);
}

@end
@interface KPCommonTextField ()

@property (nonatomic, weak) UILabel *leftLab;
@property (nonatomic, weak) UITextField *textField;


@end
@implementation KPCommonTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *leftLab = [UILabel addLabelWithTitle:@"" textColor:BlackColor font:UIFont_17];
        [self addSubview:leftLab];
        self.leftLab = leftLab;
        
        XMTextField *textField = [[XMTextField alloc] init];
        [self addSubview:textField];
        self.textField = textField;
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.leftLab.text = title;
    self.leftLab.x = CommonMargin;
    self.leftLab.width = [self.leftLab.text sizeWithAttributes:@{NSFontAttributeName: self.leftLab.font}].width;
    
    self.textField.x = CGRectGetMaxX(self.leftLab.frame) + CommonMargin;
    self.textField.width = SCREEN_W - self.textField.x;
    
    
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:placeholder];
    attr.yy_font = UIFont_16;
    attr.yy_color = GrayColor;
    attr.yy_firstLineHeadIndent = 3;
    self.textField.attributedPlaceholder = attr;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftLab.y = 0;
    self.leftLab.height = self.height;
    
    self.textField.y = 0;
    self.textField.height = self.height;
}
@end
