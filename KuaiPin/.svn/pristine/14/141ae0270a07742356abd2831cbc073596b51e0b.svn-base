//
//  KPChangeButton.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPChangeButton.h"

@implementation KPChangeButton

+ (instancetype)changeButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    KPChangeButton *btn = [KPChangeButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = WhiteColor;
        self.titleLabel.font = UIFont_16;
        [self setTitleColor:HexColor(#191919) forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"my_nextarrow"] forState:UIControlStateNormal];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = 9;
    self.imageView.x = self.width - self.currentImage.size.width - 9;
}

@end
