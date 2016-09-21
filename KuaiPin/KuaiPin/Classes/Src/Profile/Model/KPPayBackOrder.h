//
//  KPPayBackRowData.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPPayBackOrder : NSObject

/***  商品Id */
@property (nonatomic, copy) NSString *productId;

/***  商品名称 */
@property (nonatomic, copy) NSString *productName;

/***  商品图 */
@property (nonatomic, copy) NSString *productImage;

/***  商品价格 */
@property (nonatomic, copy) NSString *productPrice;

/***  商品数量 */
@property (nonatomic, copy) NSString *productAmount;

/***  用户名称 */
@property (nonatomic, copy) NSString *username;

/***  用户Id */
@property (nonatomic, copy) NSString *userId;

/***  订单号 */
@property (nonatomic, copy) NSString *orderSn;

/***  消费资产凭证号 */
@property (nonatomic, copy) NSString *assetsSn;

/*** 资产生成时间（支付成功后资产时间生成） */
@property (nonatomic, copy) NSString *assetsAddTime;

/*** 订单生成时间 (订单在购物车被提交订单时生成的时间) */
@property (nonatomic, copy) NSString *orderAddTime;

/***  贴现时间 */
@property (nonatomic, copy) NSString *subsidyTime;

/***  申请贴现时间 */
@property (nonatomic, copy) NSString *discountApplicationTime;

/***  审核贴现时间 */
@property (nonatomic, copy) NSString *discountVerifyTime;

/***  贴现金额 */
@property (nonatomic, copy) NSString *subsidyPrice;

/***  倒计时总时间 */
@property (nonatomic, copy) NSString *subsidyDay;

/***  订单状态 */
@property (nonatomic, copy) NSString *payBackState;

/***  订单贴现状态、资产状态   -1冻结中、 0倒计时中、 1可申请、2待审核、3已贴现、4审核未通过  */
@property (nonatomic, strong) NSNumber *assetsState;

/** 提前小时数 */
@property (nonatomic, strong) NSNumber *hour;

/** 提前天数 */
@property (nonatomic, strong) NSNumber *day;

/** 分享链接 */
@property (nonatomic, copy) NSString *shareUrl;


@end
