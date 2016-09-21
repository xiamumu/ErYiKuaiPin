//
//  KPLoginRegisterSegmentControl.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPLoginRegisterSegmentControl.h"

@implementation KPLoginRegisterSegmentControl

+ (instancetype)loginRegisterSegmentControl {
    KPLoginRegisterSegmentControl *loginRegisterSegment = [[KPLoginRegisterSegmentControl alloc] initWithItems:@[@"登录", @"注册"]];
    loginRegisterSegment.selectedSegmentIndex = 0;
    loginRegisterSegment.tintColor = OrangeColor;
    loginRegisterSegment.width = 157;
    loginRegisterSegment.height = 30;
    [loginRegisterSegment setTitleTextAttributes:@{NSFontAttributeName : UIFont_14} forState:UIControlStateNormal];
    [loginRegisterSegment setTitleTextAttributes:@{NSFontAttributeName : UIFont_14} forState:UIControlStateSelected];
    return loginRegisterSegment;
}

@end
