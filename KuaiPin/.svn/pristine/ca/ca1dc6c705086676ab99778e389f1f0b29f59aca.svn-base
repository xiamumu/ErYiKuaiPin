//
//  KPDiscoveryHeaderView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/6/2.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPDiscoveryHeaderView.h"

@interface KPDiscoveryHeaderView ()

@property (nonatomic, strong) UILabel *timeLB;

@end

@implementation KPDiscoveryHeaderView

- (void)setTime:(NSString *)time {
    _time = time;
    self.timeLB.text = time;
}

+ (CGFloat)headerViewHeight {
    return 36;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = ViewBgColor;
    
    [self addSubview:self.timeLB];
    
    __weak typeof(self) weakSelf = self;
    
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(weakSelf);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)timeLB {
    if (_timeLB == nil) {
        _timeLB = [UILabel new];
        _timeLB.font = UIFont_12;
        _timeLB.textColor = GrayColor;
        _timeLB.backgroundColor = ViewBgColor;
        _timeLB.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLB;
}

@end
