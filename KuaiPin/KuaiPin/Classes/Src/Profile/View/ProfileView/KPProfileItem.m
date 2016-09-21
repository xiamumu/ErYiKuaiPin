//
//  KPProfileItem.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPProfileItem.h"

@interface KPProfileItem ()

@end
@implementation KPProfileItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeCenter;
        [self addSubview:imgView];
        self.imgView = imgView;
        
        UILabel *title = [UILabel addLabelWithTitle:@"" textColor:HexColor(#191919) font:UIFont_12];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        self.title = title;
        
        KPBageView *bageView = [KPBageView bageView];
        bageView.selected = YES;
        bageView.hidden = YES;
        [self addSubview:bageView];
        self.bageView = bageView;
        
        UIImageView *lineImage = [[UIImageView alloc] init];
        lineImage.image = [UIImage imageNamed:@"my_bg_arrow"];
        lineImage.hidden = YES;
        [self addSubview:lineImage];
        self.lineImage = lineImage;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemAction:)];
        [self addGestureRecognizer:tap];
        
        __weak typeof (self) weakSelf = self;
        CGFloat lineImageW = lineImage.image.size.width;
        
        [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.mas_equalTo(weakSelf);
            make.width.mas_equalTo(lineImageW);
        }];
        
        [self.bageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf).offset(15);
            make.centerY.mas_equalTo(weakSelf).offset(-25);
        }];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat title_H = 30;
    self.title.frame = CGRectMake(0, self.height - title_H, self.width, title_H);
    self.imgView.frame = CGRectMake(0, 0, self.width, self.height - title_H);

}
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    if ([badgeValue integerValue] > 0) {
        self.bageView.hidden = NO;
        self.bageView.badgeValue = badgeValue;
    }
    else
    {
        self.bageView.hidden = YES;
    }
}
- (void)itemAction:(UITapGestureRecognizer *)tap
{
    KPProfileItem *item = (KPProfileItem *)tap.view;
    NSPostNote(Noti_ProfileItemTapAction, item)
}
@end
