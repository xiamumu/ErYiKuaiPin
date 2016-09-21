//
//  KPEncrypt.h
//  KPEncrypt
//
//  Created by 王洪运 on 16/8/22.
//  Copyright © 2016年 王洪运. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPEncrypt : NSObject

/// 对网络请求参数进行签名
///
/// @param paramter 参数，类型为字典。当参数不为字典或为空时，返回@""
///
/// @return 签名后的网络请求参数字符串
NSString *encryptWithParameter(id paramter);

/// 对一个字符串进行MD5加密
///
/// @param str 字符串。当str为nil或空字符串时，返回@""
///
/// @return MD5加密后的字符串
NSString *MD5WithStr(NSString *str);

@end
