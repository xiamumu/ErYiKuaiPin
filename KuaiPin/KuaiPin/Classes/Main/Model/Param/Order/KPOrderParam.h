//
//  KPOrderParam.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/8.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseParam.h"

@interface KPOrderParam : KPBaseParam
/**
 *  0:已取消; 10:待付款; 20:待发货; 30:待收货; 40:已收货 （不传返回所有订单）
 */
@property (nonatomic, strong) NSNumber *state;

@end
