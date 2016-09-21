//
//  KPAreaSelectedButton.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAreaSelectedButton.h"

@interface KPAreaSelectedButton ()



@end

@implementation KPAreaSelectedButton

- (UIFont *)currentTitleFont {
    return self.titleLabel.font;
}

- (void)setAreaName:(NSString *)areaName {
    _areaName = areaName;
    
    [self setTitle:areaName forState:UIControlStateNormal];
}

+ (instancetype)areaSelectedButtonAreaName:(NSString *)areaName {
    
    KPAreaSelectedButton *btn = [KPAreaSelectedButton new];
    btn.areaName = areaName;
    
    return btn;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self setTitleColor:HexColor(#191919) forState:UIControlStateSelected];
    [self setTitleColor:HexColor(#ff6d15) forState:UIControlStateNormal];
    self.titleLabel.font = UIFont_13;
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setHighlighted:(BOOL)highlighted {}

#pragma mark - 懒加载


@end
