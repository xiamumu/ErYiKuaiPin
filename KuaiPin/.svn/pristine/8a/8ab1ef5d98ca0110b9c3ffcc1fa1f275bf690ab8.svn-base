//
//  KPOrder.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/8.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPOrder : NSObject
/**   订单号  */
@property (nonatomic, copy) NSString *orderSn;
/**   买家Id  */
@property (nonatomic, strong) NSNumber *buyerId;
/**   买家名字  */
@property (nonatomic, copy) NSString *buyerName;
/**   下单时间  */
@property (nonatomic, copy) NSString *addTime;
/**   付款时间  */
@property (nonatomic, strong) NSNumber *paymentTime;
/**   完成时间  */
@property (nonatomic, strong) NSNumber *finnshedTime;
/**   订单总价  */
@property (nonatomic, copy) NSString *orderTotalprice;
/**   订单状态  0:已取消; 10:未付款; 25:待收货; 40:已收货 （不传返回所有订单） */
@property (nonatomic, strong) NSNumber *orderState;
/**   具体订单详情  */
@property (nonatomic, strong) NSArray *orderItems;

@end
