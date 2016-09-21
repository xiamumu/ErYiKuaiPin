//
//  KPPayBackDetailRowData.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayBackOrderDetail.h"

@implementation KPPayBackOrderDetail


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"payBackBeginTime": @"finnshedTime", @"payBackMoney": @"orderTotalprice", @"payBackTime": @"discountTime"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"orderItems": @"KPOrderItem"};
}
@end
