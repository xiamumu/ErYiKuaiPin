//
//  UILabel+XM.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "UILabel+XM.h"

@implementation UILabel (XM)
// 添加一个Label
+ (UILabel *)addLabelWithTitle:(NSString *)title textColor:(UIColor *)bgcolor font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = bgcolor;
    label.font = font;
    label.text = title;
    return label;
}
@end
