//
//  KPAppCatchExceptionHandler.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/24.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAppCatchExceptionHandler.h"

#define AppExceptionFile @"log_ErrorFile_%@.txt"

@implementation KPAppCatchExceptionHandler

+ (NSUncaughtExceptionHandler *)getUncaughtExceptionHandler {
    return NSGetUncaughtExceptionHandler();
}

- (void)setDefaultHandler {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

static id _instance;
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

NSString *documentDirectory() {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString * documentsDirectory  =[paths objectAtIndex:0];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeinterval =[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.0f", timeinterval];//转为字符型
    NSString *logFilename = [NSString stringWithFormat:AppExceptionFile, timeString];
    return [documentsDirectory stringByAppendingPathComponent:logFilename ];
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSLog(@"%@", arr);
    NSLog(@"%@", reason);
    NSLog(@"%@", name);
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeinterval =[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.0f", timeinterval];//转为字符型
    NSString *strTime =timeString;
    NSString *strError = [NSString stringWithFormat:@"\n\n\n=============异常崩溃报告=============\n当前版本的编译时间:\n%@\n崩溃发生的时间:\n %@\n崩溃名称:\n%@\n崩溃原因:\n%@\n堆栈信息:\n%@",timeString ,strTime,name,reason,[arr componentsJoinedByString:@"\n"]];
    
    NSString *path = documentDirectory();
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSString *lasterror = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        strError  = [NSString stringWithFormat:@"%@%@", lasterror, strError];
    }
    [strError writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
    NSArray *toRecipients = [KPAppCatchExceptionHandler shared].toRecipients;
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    //添加抄送
    NSArray *ccRecipients = [KPAppCatchExceptionHandler shared].ccRecipients;
    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
    //添加密送
    NSArray *bccRecipients = [KPAppCatchExceptionHandler shared].bccRecipients;
    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    [mailUrl appendString:@"&subject=崩溃日志"];
    //添加邮件内容
    [mailUrl appendString:[NSString stringWithFormat:@"&body=%@", strError]];
//    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];

    //#ifdef _DEBUG_LOG_
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
    //#endif
}



@end
