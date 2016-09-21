//
//  KPAddressListViewController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPAddressListViewController : UIViewController

@property (nonatomic, copy) void (^changeReceiverHandler)(id receiver);



@end
