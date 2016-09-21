//
//  KPAppCatchExceptionHandler.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/24.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPAppCatchExceptionHandler : NSObject



/// 收件人
@property (nonatomic, strong) NSArray<NSString *> *toRecipients;
/// 抄送
@property (nonatomic, strong) NSArray<NSString *> *ccRecipients;
/// 密送
@property (nonatomic, strong) NSArray<NSString *> *bccRecipients;

+ (instancetype)shared;

/// 设置默认的回调
- (void)setDefaultHandler;

/// 获取未捕获的异常处理
///
/// @return 未捕获的异常处理
+ (NSUncaughtExceptionHandler *)getUncaughtExceptionHandler;


@end
