//
//  KPHomePageItem.m
//  KuaiPin
//
//  Created by 21_xm on 16/9/1.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomePageItem.h"

@implementation KPHomePageItem

+ (instancetype)item
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)addActionWithTarget:(id)target selector:(SEL)selector
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

// 商品详情跳转
- (void)checkGoodsDetailAction:(UITapGestureRecognizer *)tap
{
    WHYNSLog(@"-----点击商品或活动跳转-----");
    //    KPHomeBrandView *brandView = (KPHomeBrandView *)tap.view;
    //    NSPostNote(Noti_CheckGoodsDetailAction, brandView)
}
@end
