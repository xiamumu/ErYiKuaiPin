//
//  KPLocalTextView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPLocalTextView.h"

@interface KPLocalTextView ()

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *indicatorIcon;

@end

@implementation KPLocalTextView

#pragma mark - 类方法
+ (instancetype)localTextWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder {
    
    KPLocalTextView *tf = [KPLocalTextView new];
    tf.placeHolder = placeHolder;
    tf.title = title;
    
    return tf;
}

#pragma mark - 重写set方法
- (void)setTitle:(NSString *)title {
    
    _title = [title copy];
    
    if (title == nil || title.length == 0) {
        return;
    }
    
    self.leftLabel.text = [title copy];
    
    __weak typeof(self) weakSelf = self;
    CGFloat left = 9;
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : self.leftLabel.font}];
    
    [self.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(left);
        make.centerY.mas_equalTo(weakSelf.rightLabel);
        make.size.mas_equalTo(size);
    }];
    
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    
    if (placeHolder == nil || placeHolder.length == 0) {
        return;
    }
    
    _placeHolder = [placeHolder copy];
    
    self.rightLabel.text = placeHolder;
    self.rightLabel.textColor = GrayColor;
    
}

- (void)setText:(NSString *)text {
    _text = text;
    
    self.rightLabel.text = text;
    self.rightLabel.textColor = BlackColor;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self addSubview:self.indicatorIcon];
    
    __weak typeof(self) weakSelf = self;
    CGFloat right = 9;
    CGFloat top = 12;
    CGFloat left = 93;
    CGFloat H = 35;
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(left);
        make.right.mas_equalTo(weakSelf).offset(-right);
        make.top.mas_equalTo(top);
        make.height.mas_equalTo(H);
    }];
    
    [self.indicatorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-right);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(weakSelf.indicatorIcon.image.size);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)leftLabel {
    if (_leftLabel == nil) {
        _leftLabel = [UILabel new];
        _leftLabel.font = UIFont_16;
        _leftLabel.textColor = BlackColor;
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (_rightLabel == nil) {
        _rightLabel = [UILabel new];
    }
    return _rightLabel;
}

- (UIImageView *)indicatorIcon {
    if (_indicatorIcon == nil) {
        _indicatorIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orderCommit_nextIcon"]];
    }
    return _indicatorIcon;
}

@end
