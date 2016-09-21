//
//  KPNetworkingStatusView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/6/22.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPNetworkingStatusView.h"

static BOOL isShowing = NO;

static NSDate *nextTime = nil;

@interface KPNetworkingStatusLabel : UILabel
@end


@implementation KPNetworkingStatusView

+ (void)showNoNetworkingStatus {

    if (isShowing) return;

    KPNetworkingStatusLabel *status = [[KPNetworkingStatusLabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, 35)];
    isShowing = YES;

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:status];
    
}

+ (void)hideNoNetworkingStatus {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [keyWindow.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[KPNetworkingStatusLabel class]]) {
            [obj removeFromSuperview];
            isShowing = NO;
        }
        
    }];
    
}

@end


@implementation KPNetworkingStatusLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.text = @"没有网络连接，请检查您的网络";
        self.textColor = WhiteColor;
        self.backgroundColor = BlackColor;
        self.alpha = 0.6;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
