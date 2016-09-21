//
//  KPOrderModel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/6/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderModel.h"

@implementation KPOrderModel

- (void)setPaymentTag:(NSNumber *)paymentTag {
    _paymentTag = @(paymentTag.integerValue + 1000);
}

- (void)setAddTime:(NSNumber *)addTime {
    NSTimeInterval time = addTime.doubleValue / 1000;
    _addTime = @(time);

    NSDate *payDate = [NSDate dateWithTimeIntervalSince1970:_addTime.floatValue];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy年MM月dd日";
    self.orderPayTimeStr = [dateFormatter stringFromDate:payDate];
    
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"orderId" : @"id",
             @"paymentTag" : @"payment.paymentMethodId"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"orderItems" : @"KPGoodModel"};
}

@end
