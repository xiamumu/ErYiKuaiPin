//
//  KPMySelfKeFuView.m
//  KuaiPin
//
//  Created by 21_xm on 16/8/29.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPMySelfKeFuView.h"

@implementation KPMySelfKeFuView

+ (instancetype)keFuView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"KPMySelfKeFuView" owner:nil options:nil] objectAtIndex:0];
}

- (IBAction)keFuTellAction:(UIButton *)sender
{
    
    [KPAlertController alertActionSheetControllerWithTitle:@"拨号"
                                               cancelTitle:@"取消"
                                              defaultTitle:@"400-9921-365"
                                                   handler:^(UIAlertAction *action) {
                                                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4009-921-365"]];
                                                   }];
}


@end
