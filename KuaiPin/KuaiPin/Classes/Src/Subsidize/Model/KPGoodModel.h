//
//  KPGoodModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseModel.h"

@class KPVendorModel;

@interface KPGoodModel : KPBaseModel

@property (nonatomic, strong) NSNumber *cartItemId;

@property (nonatomic, weak) KPVendorModel *vendor;

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, strong) NSNumber *storeId;

@property (nonatomic, strong) NSString *storeName;

@property (nonatomic, copy) NSString *productImage;

@property (nonatomic, strong) NSNumber *productAmount;

@property (nonatomic, strong) NSNumber *productId;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSNumber *productPrice;

@property (nonatomic, assign) NSInteger maxNum;
//商品状态 0下架、1正常、10违规禁售
@property (nonatomic, copy) NSNumber *productState;
//商品审核状态 1通过、0未通过、10审核中
@property (nonatomic, copy) NSNumber *productVerify;
//商品剩余库存
@property (nonatomic, copy) NSNumber *productStorage;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) BOOL selecteEnable;

@property (nonatomic, copy) NSString *pcId1Name;

@property (nonatomic, strong) NSNumber *pcId1;
/** 规格 */
@property (nonatomic, strong) NSNumber *productSpecId;
@property (nonatomic, copy) NSString *strSpec;
@property (nonatomic, strong) NSNumber *spec1;
@property (nonatomic, copy) NSString *strSpec1;
@property (nonatomic, copy) NSString *strParentSpec1;
@property (nonatomic, strong) NSNumber *spec2;
@property (nonatomic, copy) NSString *strSpec2;
@property (nonatomic, copy) NSString *strParentSpec2;
@property (nonatomic, strong) NSNumber *spec3;
@property (nonatomic, copy) NSString *strSpec3;
@property (nonatomic, copy) NSString *strParentSpec3;

/** 新手特权 */
@property (nonatomic, copy) NSString *virginUser;

@property (nonatomic, copy) NSString *activityId;

@end
