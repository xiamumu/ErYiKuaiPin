//
//  KPLoginView.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginHandler)(NSString *account, NSString *pwd);

typedef void(^ForgetPwdHandler)();

typedef void(^AuthCodeLoginHandler)();

@interface KPLoginView : UIView

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) LoginHandler loginHandler;

@property (nonatomic, copy) ForgetPwdHandler forgetPwdHandler;

@property (nonatomic, copy) AuthCodeLoginHandler authCodeLoginHandler;

+ (instancetype)loginViewWithFrame:(CGRect)frame
                      loginHandler:(LoginHandler)loginHandler
                  forgetPwdHandler:(ForgetPwdHandler)forgetPwdHandler
              authCodeLoginHandler:(AuthCodeLoginHandler)authCodeLoginHandler;

@end
