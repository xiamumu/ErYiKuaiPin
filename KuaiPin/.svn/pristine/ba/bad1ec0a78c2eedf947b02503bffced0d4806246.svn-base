//
//  KPPayBackDetailHeaderMiddleView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayBackDetailHeaderMiddleView.h"
#import "KPTimeDownView.h"

@interface KPPayBackDetailHeaderMiddleView ()

@property (nonatomic, weak) KPTimeDownView *timeDownView;
@end
@implementation KPPayBackDetailHeaderMiddleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"tiexian_bg"];
        
        KPTimeDownView *timeDownView = [[KPTimeDownView alloc] init];
        [self addSubview:timeDownView];
        self.timeDownView = timeDownView;
    }
    return self;
}

- (void)setCountDownTime:(NSString *)countDownTime
{
    _countDownTime = countDownTime;
    self.timeDownView.countDownTime = countDownTime;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat timeDownViewY = ScaleHeight(47);
    CGFloat timeDownViewW = self.timeDownView.width;
    CGFloat timeDownViewX = (SCREEN_W - timeDownViewW) * 0.5;
    CGFloat timeDownViewH = self.timeDownView.height;
    self.timeDownView.frame = CGRectMake(timeDownViewX, timeDownViewY, timeDownViewW, timeDownViewH);
    
}

- (BOOL)willDealloc
{
    return NO;
}
@end
