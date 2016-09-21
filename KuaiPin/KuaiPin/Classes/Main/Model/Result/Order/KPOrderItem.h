//
//  KPOrderItem.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/8.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPOrderItem : NSObject

/**   订单Id  */
@property (nonatomic, strong) NSNumber *orderId;
/**   商品Id  */
@property (nonatomic, strong) NSNumber *productId;
/**   商品所属商家  */
@property (nonatomic, strong) NSNumber *storeId;
/**   商品购买者Id  */
@property (nonatomic, strong) NSNumber *buyerId;
/**   商品促销Id  */
@property (nonatomic, strong) NSNumber *promotionsId;
/**   商品所属分类Id  */
@property (nonatomic, strong) NSNumber *gcId;
/**   商品购买数量  */
@property (nonatomic, strong) NSNumber *productAmount;
/**   商品库存  */
@property (nonatomic, strong) NSNumber *productStorage;
/**   商品名称  */
@property (nonatomic, copy) NSString *productName;
/**   商品价格  */
@property (nonatomic, copy) NSString *productPrice;
/**   商品图  */
@property (nonatomic, copy) NSString *productImage;
/**   商品实际付款价格  */
@property (nonatomic, copy) NSString *productPayPrice;
/**   商品全部价格  */
@property (nonatomic, copy) NSString *productTotalPrice;

@end
