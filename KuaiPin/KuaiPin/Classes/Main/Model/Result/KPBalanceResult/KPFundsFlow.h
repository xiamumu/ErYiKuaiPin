//
//  KPFundsFlow.h
//  KuaiPin
//
//  Created by 21_xm on 16/9/23.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPFundsFlow : NSObject


/**
 该操作添加时间
 */
@property (nonatomic, copy) NSString *addTime;

/**
 10:收入，20：支出
 */
@property (nonatomic, copy) NSString *operationType;

/**
 该操作的金额
 */
@property (nonatomic, copy) NSString *money;

/**
 "消费"，"贴现"，"提现"，"充值"
 */
@property (nonatomic, copy) NSString *type;

/**
 操作涉及的订单号如果没有可以为空
 */
@property (nonatomic, copy) NSString *orderSn;

/**
 生成的交易流水号
 */
@property (nonatomic, copy) NSString *sn;

/**
 执行该操作的用户名
 */
@property (nonatomic, copy) NSString *username;


@end
