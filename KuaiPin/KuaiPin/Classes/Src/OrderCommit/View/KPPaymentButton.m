//
//  KPPaymentButton.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPaymentButton.h"

@interface KPPaymentButton ()

@property (nonatomic, strong) UIImageView *selectedIcon;

@end

@implementation KPPaymentButton

- (void)setHighlighted:(BOOL)highlighted {}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    NSString *imgStr = selected ? @"Check" : @"circular";
    
    self.selectedIcon.image = [UIImage imageNamed:imgStr];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.x = 9;
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    self.titleLabel.font = UIFont_14;
    [self setTitleColor:HexColor(#191919) forState:UIControlStateNormal];
    
    [self addSubview:self.selectedIcon];
    
    __weak typeof(self) weakSelf = self;
    CGFloat right = 9;
    [self.selectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf).offset(-right);
        make.size.mas_equalTo(weakSelf.selectedIcon.image.size);
    }];
    
}

#pragma mark - 懒加载
- (UIImageView *)selectedIcon {
    if (_selectedIcon == nil) {
        _selectedIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circular"]];
    }
    return _selectedIcon;
}

@end
