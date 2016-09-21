//
//  KPDatabase.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/21.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class KPProduct;

@interface KPDatabase : NSObject

singleton_interface(Database)

/**
 *  存储请求来的数据
 */
- (void)saveData:(NSDictionary *)dict;

/**
 *  查询数据库中的所有数据
 */
- (NSArray *)selectAllProduct;

/**
 *  删除数据库中的所有数据
 */
- (void)deleteAllProduct;

/**
 *  按照productId来删除数据
 */
- (void)deleteWithProductId:(NSNumber *)productId;

/**
 *  按照productId来查询数据
 */
- (KPProduct *)selectProductWithProductId:(NSNumber *)productId;
@end
