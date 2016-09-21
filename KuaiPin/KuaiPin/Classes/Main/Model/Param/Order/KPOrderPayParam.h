//
//  KPOrderPayParam.h
//  KuaiPin
//
//  Created by 王洪运 on 16/7/2.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseParam.h"

@interface KPOrderPayParam : KPBaseParam

@property (nonatomic, copy) NSString *orderSn;

@property (nonatomic, copy) NSString *totalFee;

@property (nonatomic, strong) NSNumber *payId;

@property (nonatomic, strong) NSNumber *accNo;

@end
