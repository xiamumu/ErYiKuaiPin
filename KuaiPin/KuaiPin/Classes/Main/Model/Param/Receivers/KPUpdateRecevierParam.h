//
//  KPUpdateRecevierParam.h
//  KuaiPin
//
//  Created by 王洪运 on 16/6/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseParam.h"

@interface KPUpdateRecevierParam : KPBaseParam

@property (nonatomic, strong) NSNumber *receiverId;

@property (nonatomic, copy) NSString *receiverName;

@property (nonatomic, copy) NSString *receiverMobile;

@property (nonatomic, copy) NSString *details;

@property (nonatomic, strong) NSNumber *provinceId;

@property (nonatomic, strong) NSNumber *cityId;

@property (nonatomic, strong) NSNumber *countryId;

@end
