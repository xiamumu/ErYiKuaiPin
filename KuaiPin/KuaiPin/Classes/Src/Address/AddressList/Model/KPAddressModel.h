//
//  KPAddressModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseModel.h"

@interface KPAddressModel : KPBaseModel

@property (nonatomic, copy) NSString *receiverName;

@property (nonatomic, copy) NSString *receiverMobile;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *addressLocal;

@property (nonatomic, copy) NSString *details;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *countryName;

@property (nonatomic, strong) NSNumber *isDefault;

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, strong) NSNumber *provinceId;

@property (nonatomic, strong) NSNumber *cityId;

@property (nonatomic, strong) NSNumber *countryId;

@property (nonatomic, strong) NSNumber *receiverId;

@end
