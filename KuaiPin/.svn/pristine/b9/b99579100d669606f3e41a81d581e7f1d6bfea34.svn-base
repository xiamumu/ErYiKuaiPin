//
//  KPIDCardInputView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/8/25.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPIDCardInputView.h"

int const maxButtonCount = 12;

@interface KPIDCardInputView ()



@end

@implementation KPIDCardInputView

+ (instancetype)IDCardInputViewWithDelegate:(id<KPIDCardInputViewDelegate>)delegate {
    KPIDCardInputView *inputView = [[KPIDCardInputView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216)];
    inputView.delegate = delegate;
    return inputView;
}

- (void)clickButton:(UIButton *)btn {
    [self setWhiteBackGroundButton:btn];

    if (self.delegate && [self.delegate respondsToSelector:@selector(inputView: didInputWithNewString:)]) {
        [self.delegate inputView:self didInputWithNewString:btn.titleLabel.text];
    }

}

- (void)toucheDownButton:(UIButton *)btn {
    [self setGrayBackGroundButton:btn];
}

- (void)dragOutsideButton:(UIButton *)btn {
    [self setWhiteBackGroundButton:btn];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;

    NSInteger maxCol = 3;
    CGFloat btnW = screenW / maxCol;
    CGFloat btnH = 54;
    CGFloat sepWH = 1;

    for (int i = 0; i < maxButtonCount; i++) {

        NSInteger col = i % maxCol;
        NSInteger row = i / maxCol;

        CGFloat x = btnW * col;
        CGFloat y = btnH * row;

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, btnW, btnH)];
        [self setupButton:btn withIndex:i];

    }

    for (int i = 0; i < maxButtonCount; i++) {

        NSInteger col = i % maxCol;
        NSInteger row = i / maxCol;

        CGFloat x = btnW * col;
        CGFloat y = btnH * row;

        UIView *sep;
        CGFloat sepX = x - sepWH * 0.5;
        CGFloat sepY = y - sepWH * 0.5;
        CGFloat selfH = self.frame.size.height;
        CGFloat selfW = self.frame.size.width;
        switch (i) {
            case 1:
            case 2:
                sep = [[UIView alloc] initWithFrame:CGRectMake(sepX, 0, sepWH, selfH)];
                break;
            case 3:
            case 6:
            case 9:
                sep = [[UIView alloc] initWithFrame:CGRectMake(0, sepY, selfW, sepWH)];
                break;
            default:
                break;
        }
        sep.backgroundColor = [UIColor lightGrayColor];

        [self addSubview:sep];

    }

}

- (void)setupButton:(UIButton *)btn withIndex:(int)i {

    [self setWhiteBackGroundButton:btn];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    NSString *btnTitle = @"";
    switch (i) {
        case 9:
            btnTitle = @"X";
            break;
        case 10:
            btnTitle = @"0";
            break;
        case 11:
        {
            btnTitle = @"";
            [btn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        }
            break;
        default:
            btnTitle = [NSString stringWithFormat:@"%d", i + 1];
            break;
    }

    [btn setTitle:btnTitle forState:UIControlStateNormal];

    btn.titleLabel.font = [UIFont  boldSystemFontOfSize:22];

    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(toucheDownButton:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(dragOutsideButton:) forControlEvents:UIControlEventTouchDragOutside];


    [self addSubview:btn];

}

- (void)setWhiteBackGroundButton:(UIButton *)btn {
    btn.backgroundColor = [UIColor whiteColor];
}

- (void)setGrayBackGroundButton:(UIButton *)btn {
    btn.backgroundColor = [UIColor lightGrayColor];
}

@end
