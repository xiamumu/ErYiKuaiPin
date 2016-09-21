//
//  KPPayBackDetailHeaderView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayBackDetailHeaderView.h"
#import "KPPayBackDetailHeaderTopView.h"
#import "KPPayBackDetailHeaderMiddleView.h"
#import "KPCommonMarginView.h"
#import "KPPayBackOrder.h"

@interface KPPayBackDetailHeaderView ()
@property (nonatomic, weak) KPPayBackDetailHeaderTopView *topView;
@property (nonatomic, weak) KPPayBackDetailHeaderMiddleView *midView;
@property (nonatomic, weak) KPCommonMarginView *marginView;
@end
@implementation KPPayBackDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        KPPayBackDetailHeaderTopView *topView = [[KPPayBackDetailHeaderTopView alloc] init];
        [self addSubview:topView];
        self.topView = topView;
        
        
        KPPayBackDetailHeaderMiddleView *midView = [[KPPayBackDetailHeaderMiddleView alloc] init];
        [self addSubview:midView];
        self.midView = midView;
        
        KPCommonMarginView *marginView = [[KPCommonMarginView alloc] init];
        marginView.backgroundColor = ClearColor;
        marginView.title = @"对应订单";
        marginView.headerImageName = @"title_bg";
        [self addSubview:marginView];
        self.marginView = marginView;
    }
    return self;
}

- (void)setPayBackOrderDetail:(KPPayBackOrder *)payBackOrderDetail
{
    _payBackOrderDetail = payBackOrderDetail;
    
    self.midView.countDownTime = payBackOrderDetail.subsidyTime;
    self.topView.payBackOrderDetail = payBackOrderDetail;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.topView.frame = CGRectMake(0, 0, SCREEN_W, ScaleHeight(250));
    self.midView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame) + CommonMargin, SCREEN_W, ScaleHeight(135));
    if (self.payBackOrderDetail.assetsState.integerValue == 3 || self.payBackOrderDetail.assetsState.integerValue == 2) {
        self.midView.hidden = YES;
        self.midView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_W, 0);
        
    }
    self.marginView.frame = CGRectMake(0, CGRectGetMaxY(self.midView.frame), SCREEN_W, 35);
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

@end
