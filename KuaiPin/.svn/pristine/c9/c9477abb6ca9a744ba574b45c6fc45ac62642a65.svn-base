//
//  KPAuthCodeView.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RegisterHandler)(NSString *pwd, NSString *repeatPwd);



@interface KPRegisterPwdView : UIView

@property (nonatomic, copy) RegisterHandler registerHandler;

@property (nonatomic, copy) NSString *bottomBtnTitle;

+ (instancetype)registerPwdViewWithFrame:(CGRect)frame
                      registerHandler:(RegisterHandler)registerHandler;



@end
