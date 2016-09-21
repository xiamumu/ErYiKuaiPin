//
//  KPGoodsDetailResult.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/1.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KPSpecTitle;
@class KPProductSpec;

@interface KPGoodsDetailResult : NSObject

/**
 *  分享的广告语
 */
@property (nonatomic, copy) NSString *productJingle;

/** brandId */
@property (nonatomic, strong) NSNumber *brandId;

/***  商品Id */
@property (nonatomic, strong) NSNumber *productId;

/***  商品名称 */
@property (nonatomic, copy) NSString *productName;

/***  商品图 */
@property (nonatomic, copy) NSString *productImage;

/***  商品webViewUrl */
@property (nonatomic, copy) NSString *mobileBody;

/***  商品价格 */
@property (nonatomic, copy) NSString *productPrice;

/***  详情链接 */
@property (nonatomic, copy) NSString *detailUrl;

/***  商品是否被收藏 */
@property (nonatomic, copy) NSString *isCollection;

/***  商品所属店铺Id */
@property (nonatomic, strong) NSNumber *storeId;

/***  库存 */
@property (nonatomic, strong) NSNumber *productStorage;

/***  商品详情主图数组 */
@property (nonatomic, strong) NSArray *images;

/***  类别名称 */
@property (nonatomic, strong) NSArray <KPSpecTitle *> *specTitles;

/***  不同类别下所有可能的商品组合 */
@property (nonatomic, strong) NSArray <KPProductSpec *> *productSpecList;

@property (nonatomic, strong) NSNumber *isNewUser;

/**
 *  活动id
 */
@property (nonatomic, copy) NSString *activity_id;

/** 是否是新手特权商品 */
@property (nonatomic, copy) NSString *virginUser;

@end
