//
//  KPBankCardInputController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPAddBankCardParam.h"


@interface KPBankCardInputController : UIViewController

@property (nonatomic, strong) KPAddBankCardParam *addBankCardParam;

@property (nonatomic, strong) __kindof UIViewController *popToVC;

@end
