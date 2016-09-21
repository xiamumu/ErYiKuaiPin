//
//  KPSpecValue.h
//  KuaiPin
//
//  Created by 21_xm on 16/7/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPProductSpec : NSObject

/**
 *  可能的规格组合的id
 */
@property (nonatomic, copy) NSString *productSpecId;

/**
 *  每种规格下的商品的价格
 */
@property (nonatomic, copy) NSString *specPrice;

/**
 *  规格1 参数
 */
@property (nonatomic, copy) NSString *spec1;

/**
 *  规格1 参数  对应的显示名称
 */
@property (nonatomic, copy) NSString *strSpec1;

/**
 *  规格2 参数
 */
@property (nonatomic, copy) NSString *spec2;

/**
 *  规格2 参数  对应的显示名称
 */
@property (nonatomic, copy) NSString *strSpec2;

/**
 *  规格3 参数
 */
@property (nonatomic, copy) NSString *spec3;

/**
 *  规格3 参数  对应的显示名称
 */
@property (nonatomic, copy) NSString *strSpec3;

/**
 *  库存（此种规格下的库存）
 */
@property (nonatomic, copy) NSString *specStorage;



@end
