//
//  UIBarButtonItem+XM.m
//  KP
//
//  Created by 21_xm on 16/3/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "UIBarButtonItem+XM.h"

@implementation UIBarButtonItem (XM)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName selectedImageName:(NSString *)selectedImageName targe:(id)targe action:(SEL)action
{
    
    UIImage *image = [UIImage imageNamed:imageName];
    KPButton *btn = [KPButton buttonWithType:UIButtonTypeCustom];
    btn.width = image.size.width;
    btn.height = image.size.height;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highImageName) {
        [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    if (selectedImageName) {
        
        [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    
    [btn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title titleColor:(UIColor *)color hightLightColor:(UIColor *)hightLightColor targe:(id)targe action:(SEL)action
{
    
    KPButton *btn = [KPButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}];
    btn.size = titleSize;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:hightLightColor forState:UIControlStateHighlighted];
    [btn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
