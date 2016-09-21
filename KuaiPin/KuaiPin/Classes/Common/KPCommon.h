//
//  KPCommon.h
//  KuaiPin
//
//  Created by 王洪运 on 16/7/8.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    //    KPOrderStateAllOrder,
    KPOrderStateCancel      = 0,    // 已取消
    KPOrderStateUnPay       = 10,   // 待付款
    KPOrderStateUnSendOut   = 20,   // 待发货
    KPOrderStateUnReceive   = 30,   // 待收货
    KPOrderStateFinish      = 40,   // 已收货
} KPOrderState;




