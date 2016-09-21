//
//  KPShopDetailParam.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/31.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPBaseParam.h"

@interface KPShopDetailParam : KPBaseParam

@property (nonatomic, strong) NSNumber *storeId;

/**
 *  按时间排序传 productAddtime ， 按价格排序 productPrice ，按销量排序 productSalenum ，按热度排序productClick
 */
@property (nonatomic, copy) NSString *sort;

/**
 *  按价格排序传 升序（默认）：asc  降序：desc
 */
@property (nonatomic, copy) NSString *dir;

/**
 *  是否显示推荐的商品
 */
@property (nonatomic, assign) NSUInteger isRecommend;



/**
 *  分页参数，不传就只显示一页
 */
@property (nonatomic, assign) NSUInteger pageNumber;

@end
