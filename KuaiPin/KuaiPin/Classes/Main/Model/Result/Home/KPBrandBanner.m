//
//  KPBrandBanner.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/30.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBrandBanner.h"

@implementation KPBrandBanner

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id", @"brandImage": @"logo"};
}

- (NSString *)url
{
    return [NSString stringWithFormat:@"http://192.168.199.237:8080/store/%@", self.storeId];
}
@end
