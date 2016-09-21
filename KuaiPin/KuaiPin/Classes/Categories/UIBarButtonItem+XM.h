//
//  UIBarButtonItem+XM.h
//  KP
//
//  Created by 21_xm on 16/3/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XM)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName selectedImageName:(NSString *)selectedImageName targe:(id)targe action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title titleColor:(UIColor *)color hightLightColor:(UIColor *)hightLightColor targe:(id)targe action:(SEL)action;

@end
