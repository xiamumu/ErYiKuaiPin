//
//  NSString+KPExtension.h
//  KuaiPin
//
//  Created by 王洪运 on 16/6/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KPExtension)

/// 用"*"替换手机号中间四位
///
/// @return 带"*"的手机号
- (NSString *)phoneSecurityString;

/// 检查是否是表情
///
/// @return 是否是表情
- (BOOL)isEmoji;

/// 检查是否是手机号
///
/// @return 是否是手机号
- (BOOL)isPhoneString;

/// 检查是否是密码
///
/// @return 是否是密码
- (BOOL)isPasswordString;

/// 检查是否是数字
///
/// @return 是否是数字
- (BOOL)isNumber;

/// 检查是否是字母
///
/// @return 是否是字母
- (BOOL)isCharacter;

/// 检查是否是汉字
///
/// @return 是否是汉字
- (BOOL)isHans;

+ (NSString *)dateStrFromTimestamp:(NSString *)timeStamp withFormatter:(NSString *)formatter;

@end
