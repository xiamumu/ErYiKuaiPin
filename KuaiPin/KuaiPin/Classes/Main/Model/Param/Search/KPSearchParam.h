//
//  KPSearchParam.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/28.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPBaseParam.h"

@interface KPSearchParam : KPBaseParam

/***  搜索关键词 */
@property (nonatomic, copy) NSString *keyword;

/***  店铺id */
@property (nonatomic, copy) NSString *storeId;

/***  按时间排序传 productAddtime   按价格排序 productPrice */
@property (nonatomic, copy) NSString *sort;

/***  按价格排序传 升序（默认）：asc  降序：desc */
@property (nonatomic, copy) NSString *dir;

/***  分页参数，不传就只显示一页 */
@property (nonatomic, assign) NSUInteger pageNumber;

@end
