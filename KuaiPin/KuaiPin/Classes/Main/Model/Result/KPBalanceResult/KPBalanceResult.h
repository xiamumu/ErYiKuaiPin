//
//  KPBalanceResult.h
//  KuaiPin
//
//  Created by 21_xm on 16/8/24.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPBalanceResult : NSObject

/**
 *  资产总额
 */
@property (nonatomic, strong) NSNumber *totalBalance;
/**
 *  可用余额
 */
@property (nonatomic, strong) NSNumber *balance;
/**
 *  待收资产
 */
@property (nonatomic, strong) NSNumber *collectBalance;
/**
 *  冻结资产
 */
@property (nonatomic, strong) NSNumber *freezeBalance;

/**
 资金流水
 */
@property (nonatomic, strong) NSArray *water;


@end
