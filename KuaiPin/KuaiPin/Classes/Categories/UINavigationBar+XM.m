//
//  UINavigationBar+XM.m
//  KP
//
//  Created by 21_xm on 16/3/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "UINavigationBar+XM.h"

@implementation UINavigationBar (XM)

- (void)setBarBackgroundColorWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, SCREEN_W, 64);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

@end
