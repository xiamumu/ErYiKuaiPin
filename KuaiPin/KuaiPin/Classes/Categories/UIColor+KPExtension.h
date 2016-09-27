//
//  UIColor+KPExtension.h
//  
//
//  Created by 王洪运 on 16/3/7.
//  Copyright © 2016年 王洪运. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBColor(r, g, b)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]

#define RGBAColor(r, g, b, a)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]

#define RandomColor [UIColor randomColor]

#define HexColor(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]

// 常用颜色
#define ClearColor [UIColor clearColor]
#define WhiteColor HexColor(#ffffff)
#define OrangeColor HexColor(#ff6d15)
#define BlackColor HexColor(#191919)
#define RedColor [UIColor redColor]
#define GrayColor HexColor(#8a8a8a)
#define LightRedColor HexColor(#fa4862)
#define ViewBgColor HexColor(#f2f2f2)
#define BaseColor HexColor(#f6f6f6)
#define SeperatorColor HexColor(#dedede)

@interface UIColor (KPExtension)

/// 随机颜色
+(UIColor *)randomColor;

/// 用HexString创建一个color
///
/// @param hexStr HexString
///
/// @return color
+ (UIColor *)colorWithHexString:(NSString *)hexStr;

@end
