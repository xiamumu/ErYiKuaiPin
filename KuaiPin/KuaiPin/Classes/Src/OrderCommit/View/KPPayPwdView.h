//
//  KPPayPwdView.h
//  KuaiPin
//
//  Created by 21_xm on 16/8/24.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPPayPwdView : UIAlertView

@property (nonatomic, copy) NSString *totalPrice;

/**
 *  返回支付密码
 */
@property (nonatomic, copy) void (^completion)(NSString *password);

/**
 *  移除密码输入框
 */
- (void)removeSelf;

/**
 *  类方法创建密码输入框
 */
+ (instancetype)payPwdView;

@end