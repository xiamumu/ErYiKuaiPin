//
//  KPBottomButton.m
//  KuaiPin
//
//  Created by 王洪运 on 16/8/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBottomButton.h"

@implementation KPBottomButton

- (void)setBtnTitle:(NSString *)btnTitle {
    _btnTitle = [btnTitle copy];
    [self setTitle:btnTitle forState:UIControlStateNormal];
}

+ (instancetype)bottomButtonWithTitle:(NSString *)title {

    KPBottomButton *btn = [KPBottomButton new];
    btn.btnTitle = title;
    return btn;
}

+ (instancetype)bottomButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {

    KPBottomButton *btn = [KPBottomButton new];
    btn.btnTitle = title;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

+ (instancetype)bottomButtonWithTitle:(NSString *)title
                              imgName:(NSString *)imgName
                               target:(id)target
                               action:(SEL)action {

    KPBottomButton *btn = [KPBottomButton bottomButtonWithTitle:title target:target action:action];

    if (imgName) {
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }

    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.titleLabel.font = UIFont_20;
    [self setBackgroundColor:OrangeColor];
    [self setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.layer.cornerRadius = 6;
    self.adjustsImageWhenHighlighted = NO;

}


@end
