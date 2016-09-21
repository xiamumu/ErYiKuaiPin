//
//  KPOrderCommitCompletionLabel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderCommitCompletionLabel.h"
#import <YYText.h>

@interface KPCustomLabel : UILabel
@end

@interface KPOrderCommitCompletionLabel ()

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) KPCustomLabel *textLB;

@end

@implementation KPOrderCommitCompletionLabel

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:detail];
    attr.yy_lineBreakMode = NSLineBreakByTruncatingTail;
    attr.yy_lineSpacing = 4;
    attr.yy_headIndent = 0.5;
    
    self.textLB.attributedText = attr;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLB.text = title;
}

+ (instancetype)completionLabelWithTitle:(NSString *)title {
    
    KPOrderCommitCompletionLabel *label = [KPOrderCommitCompletionLabel new];
    label.title = title;
    
    return label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.titleLB];
    [self addSubview:self.textLB];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat leftRight = 18;
    CGFloat textLeft = 115;
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRight);
        make.top.mas_equalTo(weakSelf);
    }];
    
    [self.textLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(textLeft);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-leftRight);
        make.top.bottom.mas_equalTo(weakSelf);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.font = UIFont_14;
        _titleLB.textColor = GrayColor;
    }
    return _titleLB;
}

- (KPCustomLabel *)textLB {
    if (_textLB == nil) {
        _textLB = [KPCustomLabel new];
        _textLB.font = UIFont_14;
        _textLB.textColor = BlackColor;
        _textLB.numberOfLines = 2;
    }
    return _textLB;
}

@end

#pragma mark - KPCustomLabel
@implementation KPCustomLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = 0;
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
