//
//  KPProgressHUD.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface KPProgressHUD : SVProgressHUD

+ (void)showErrorWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval;

+ (void)showSuccessWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval;

+ (void)showErrorWithStatus:(NSString *)status completion:(void(^)())completion;

+ (void)showSuccessWithStatus:(NSString *)status completion:(void(^)())completion;

+ (void)showErrorWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval completion:(void(^)())completion;

+ (void)showSuccessWithStatus:(NSString *)status timeInterval:(NSTimeInterval)interval completion:(void(^)())completion;

+ (BOOL)isShowLoading;

+ (void)showLoading;

+ (void)hideLoading;

@end
