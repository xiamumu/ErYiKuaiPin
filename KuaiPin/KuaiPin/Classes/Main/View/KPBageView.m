//
//  KPBageView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBageView.h"
#import "UIImage+XM.h"

@implementation KPBageView

+ (instancetype)bageView
{
    return [[self alloc] init];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setBackgroundImage:[UIImage resizedImage:@"tips_white"] forState:UIControlStateNormal];
        [self setTitleColor:OrangeColor forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage resizedImage:@"tips_orange"] forState:UIControlStateSelected];
        [self setTitleColor:WhiteColor forState:UIControlStateSelected];
        self.userInteractionEnabled = YES;
        self.adjustsImageWhenHighlighted = NO;
        // 按钮的高度就是背景图片的高度
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    // 设置文字
    if ([badgeValue integerValue] > 99) {
        badgeValue = @"99+";
    }
    // 根据文字计算自己的尺寸
    CGFloat title_W = [badgeValue sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].width;
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (title_W < bgW) {
        
        self.width = bgW + 2;
        
    } else {
        
        self.width = title_W + 6;
    }
    [self setTitle:badgeValue forState:UIControlStateNormal];
}

@end
