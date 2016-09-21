//
//  KPWithoutAnythingView.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPWithoutAnythingView.h"

@interface KPWithoutAnythingView ()

@property (nonatomic, weak) UILabel *lab;

@end

@implementation KPWithoutAnythingView

- (void)setMessage:(NSString *)message {
    _message = message;
    self.lab.text = message;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"no_results"];
        [self addSubview:img];
        
        UILabel *lab = [UILabel addLabelWithTitle:nil textColor:ClearColor font:UIFont_16];
        lab.textColor = GrayColor;
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        self.lab = lab;
        
        __weak typeof (self) weakSelf = self;
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf).offset(30);
            make.centerX.mas_equalTo(weakSelf);
            make.size.mas_equalTo(img.image.size);
        }];

        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(img.mas_bottom).offset(18);
            make.left.mas_equalTo(weakSelf).offset(CommonMargin);
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
        }];
        
    }
    return self;
}

@end
