//
//  KPSubsidizeButton.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/28.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSubsidizeButton.h"
#import "KPBageView.h"

@interface KPSubsidizeButton ()

@property (nonatomic, weak) KPBageView *bageView;

@end

@implementation KPSubsidizeButton

+ (instancetype)subsidizeButton
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setImage:[UIImage imageNamed:@"goods_cart"] forState:UIControlStateNormal];
        
        KPBageView *bageView = [KPBageView bageView];
        bageView.hidden = YES;
        [self addSubview:bageView];
        self.bageView = bageView;
        
        __weak typeof (self) weakSelf = self;
        [self.bageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf).offset(10);
            make.centerY.mas_equalTo(weakSelf).offset(-9);
        }];
    }
    return self;
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


@end
