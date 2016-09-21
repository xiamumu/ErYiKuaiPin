//
//  KPAlertController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPAlertController : UIAlertController

+ (void)alertControllerWithTitle:(NSString *)title
                     cancelTitle:(NSString *)cancelTitle
                    defaultTitle:(NSString *)defaultTitle
                         handler:(void (^)(UIAlertAction *action))handler;

+ (void)alertActionSheetControllerWithTitle:(NSString *)title
                                cancelTitle:(NSString *)cancelTitle
                               defaultTitle:(NSString *)defaultTitle
                                    handler:(void (^)(UIAlertAction *action))handler;

+(void)alertControllerWithTitle:(NSString *)title
                        message:(NSString *)message
                   defaultTitle:(NSString *)defaultTitle;

 
+(void)alertControllerWithTitle:(NSString *)title
                        message:(NSString *)message
                    cancelTitle:(NSString *)cancelTitle
                   defaultTitle:(NSString *)defaultTitle
                        handler:(void (^)(UIAlertAction *action))handler;
@end
