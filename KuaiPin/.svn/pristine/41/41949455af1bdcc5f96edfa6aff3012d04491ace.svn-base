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
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemAction:)];
        [self addGestureRecognizer:tap];
        
        __weak typeof (self) weakSelf = self;
        
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
    self.imgView.frame = CGRectMake(0, 8, self.width, self.height - title_H);
    self.title.frame = CGRectMake(0, self.height - title_H, self.width, title_H);

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
