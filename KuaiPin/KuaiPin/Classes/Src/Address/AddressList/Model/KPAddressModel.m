//
//  KPAddressModel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAddressModel.h"

@implementation KPAddressModel

- (NSString *)addressLocal {
    
    if (_addressLocal == nil) {
        return [NSString stringWithFormat:@"%@%@%@", self.provinceName, self.cityName, self.countryName];
    }
    return _addressLocal;
}

- (NSString *)address {
    return [self.addressLocal stringByAppendingString:self.details];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"receiverId" : @"id"};
}

@end
