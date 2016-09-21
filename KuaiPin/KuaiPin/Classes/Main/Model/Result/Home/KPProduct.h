//
//  KPProduct.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPProduct : NSObject

@property (nonatomic, copy) NSString *brandId;

/***  商品名称 */
@property (nonatomic, copy) NSString *productName;

/***  商品价格 */
@property (nonatomic, copy) NSString *productPrice;

/***  是否被加入购物车 */
@property (nonatomic, copy) NSString *isCartItem;

/***  商品Id */
@property (nonatomic, strong) NSNumber *productId;

/***  G库购物车项Id */
@property (nonatomic, strong) NSNumber *itemId;

/***  商品所属商家Id */
@property (nonatomic, strong) NSNumber *storeId;

/***  商品所属商家头像 */
@property (nonatomic, copy) NSString *storeAvatar;

/***  商品贴现时间 */
@property (nonatomic, strong) NSNumber *subsidyDay;

/***  一级分类Id */
@property (nonatomic, copy) NSString *pcId1;

/***  一级分类名 */
@property (nonatomic, copy) NSString *strPcId1;

/***  二级分类Id */
@property (nonatomic, copy) NSString *pcId2;

/***  二级分类名 */
@property (nonatomic, copy) NSString *strPcId2;

/***  库存 */
@property (nonatomic, strong) NSNumber *productStorage;

/***  商品方图 */
@property (nonatomic, copy) NSString *productImage;

/***  商品小长图 */
@property (nonatomic, copy) NSString *productCommendImage;

/***  商品长图 */
@property (nonatomic, copy) NSString *productCommendCategoryImage;

/***  分类商品方图 */
@property (nonatomic, copy) NSString *productCategoryImage;

@property (nonatomic, copy) NSString *activityId;

@property (nonatomic, copy) NSString *virginUser;


@end