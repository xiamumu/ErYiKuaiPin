//
//  KPOrderDetailViewController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPSubsidizeViewController.h"

@interface KPOrderDetailViewController : UIViewController

@property (nonatomic, copy) NSString *orderSn;

@property (nonatomic, assign) BOOL popToRootVc;

@property (nonatomic, weak) KPSubsidizeViewController *popToSubsidizeVc;

@end
