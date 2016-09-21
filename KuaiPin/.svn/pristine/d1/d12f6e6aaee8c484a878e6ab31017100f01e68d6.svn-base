//
//  KPAlertController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAlertController.h"
#import <YYText.h>

@interface KPAlertController ()

@end

@implementation KPAlertController

+(void)alertControllerWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle defaultTitle:(NSString *)defaultTitle handler:(void (^)(UIAlertAction *))handler {
    
    KPAlertController *alert = [KPAlertController alertControllerWithTitle:title
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];

    if (cancelTitle) {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle
                                                  style:UIAlertActionStyleCancel
                                                handler:nil]];
    }

    if (defaultTitle && handler) {
        [alert addAction:[UIAlertAction actionWithTitle:defaultTitle
                                                  style:UIAlertActionStyleDefault
                                                handler:handler]];
    }

    [self presentAlert:alert];
}

+(void)alertControllerWithTitle:(NSString *)title message:(NSString *)message defaultTitle:(NSString *)defaultTitle {
    
    KPAlertController *alert = [self alertControllerWithTitle:title
                                                      message:message
                                               preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:defaultTitle
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    
    [self presentAlert:alert];
}


+(void)alertControllerWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle defaultTitle:(NSString *)defaultTitle handler:(void (^)(UIAlertAction *))handler {
    
    KPAlertController *alert = [self alertControllerWithTitle:title
                                                      message:message
                                               preferredStyle:UIAlertControllerStyleAlert];
    if (cancelTitle) {
        
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle
                                                  style:UIAlertActionStyleCancel
                                                handler:nil]];
    }
    
    if (defaultTitle) {
        
        [alert addAction:[UIAlertAction actionWithTitle:defaultTitle
                                                  style:UIAlertActionStyleDefault
                                                handler:handler]];
    }
    
    [self presentAlert:alert];}

+ (void)alertActionSheetControllerWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle defaultTitle:(NSString *)defaultTitle handler:(void (^)(UIAlertAction *))handler {
    
    KPAlertController *alert = [KPAlertController alertControllerWithTitle:title
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:defaultTitle
                                              style:UIAlertActionStyleDefault
                                            handler:handler]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
    str.yy_font = UIFont_18;
    str.yy_color = BlackColor;
    [alert setValue:str forKey:@"attributedTitle"];
    
    [self presentAlert:alert];
}

+ (void)presentAlert:(KPAlertController *)alert {
    UIViewController *mainVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (mainVc.presentedViewController) {
        mainVc = mainVc.presentedViewController;
    }
    [mainVc presentViewController:alert animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
