//
//  KPButton+KPExtension.m
//  KuaiPin
//
//  Created by 王洪运 on 16/7/14.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPButton+KPExtension.h"

@implementation KPButton (KPExtension)

+ (KPButton *)addBtnWithTitle:(NSString *)title
{
    KPButton *btn = [[KPButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:HexColor(#8a8a8a) forState:UIControlStateNormal];
    [btn setTitleColor:HexColor(#191919) forState:UIControlStateSelected];
    btn.titleLabel.font = UIFont_14;
    return btn;
}

- (BOOL)willDealloc {
    return NO;
}

@end
