//
//  KPNewReceiverParam.h
//  KuaiPin
//
//  Created by 王洪运 on 16/6/2.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseParam.h"

// provinceId cityId countryId receiverName receiverMobile details isDefault
@interface KPNewReceiverParam : KPBaseParam

@property (nonatomic, copy) NSString *receiverName;

@property (nonatomic, copy) NSString *receiverMobile;

@property (nonatomic, copy) NSString *details;

@property (nonatomic, strong) NSNumber *provinceId;

@property (nonatomic, strong) NSNumber *cityId;

@property (nonatomic, strong) NSNumber *countryId;

@property (nonatomic, strong) NSNumber *isDefault;

@end
