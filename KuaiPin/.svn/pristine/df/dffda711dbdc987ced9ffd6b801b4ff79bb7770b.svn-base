//
//  KPSubsidizeViewModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseViewModel.h"

@class KPProduct;

@interface KPSubsidizeViewModel : KPBaseViewModel

@property (nonatomic, assign) BOOL selectedAll;

@property (nonatomic, assign) BOOL selectedAllEnable;

@property (nonatomic, assign) CGFloat totalPrice;

//添加商品到订单中
- (NSArray *)addGoodToOrderFormWithGoodModel:(id)goodModel;

- (NSArray *)addVendorAllGoodsToOrderFormWithVendorModel:(id)vendorModel;

- (NSArray *)addAllGoodsToOrderForm;

//从订单中移除商品
- (NSArray *)removeGoodToOrderFormWithGoodModel:(id)goodModel;

- (NSArray *)removeVendorAllGoodsToOrderFormWithVendorModel:(id)vendorModel;

- (NSArray *)removeAllGoodsToOrderForm;

//删除G库中的商品
- (NSString *)deleteCartItemIds;

//修改商品数量
- (NSArray *)changeGoodNumerWithGoodModel:(id)goodModel number:(NSString *)number;


- (KPProduct *)getProductWithIndexPath:(NSIndexPath *)indexPath;

@end
