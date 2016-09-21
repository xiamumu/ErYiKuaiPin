//
//  KPOrderModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/6/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseModel.h"
#import "KPGoodModel.h"


@interface KPOrderModel : KPBaseModel

@property (strong, nonatomic) NSNumber *orderId;

@property (strong, nonatomic) NSNumber *orderSn;

@property (strong, nonatomic) NSNumber *orderTotalprice;

@property (strong, nonatomic) NSNumber *buyerId;

@property (copy, nonatomic) NSString *buyerName;

@property (strong, nonatomic) NSNumber *addTime;

@property (strong, nonatomic) NSNumber *evaluationState;

// 订单状态：0(已取消)10(默认):未付款;20:已付款;30:已发货;40:已收货;
@property (strong, nonatomic) NSNumber *orderState;

@property (strong, nonatomic) NSNumber *lockState;

@property (strong, nonatomic) NSNumber *deleteState;

@property (strong, nonatomic) NSArray<KPGoodModel *> *orderItems;

@property (nonatomic, copy) NSString *orderPayTimeStr;

@property (nonatomic, strong) NSNumber *paymentTag;

@end
