//
//  KPShopDataResult.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/31.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPShopDataResult.h"

@implementation KPShopDataResult
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"products": @"KPProduct"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"brandId" : @"id"};
}

- (NSString *)shareUrl {
    return @"http://app.21my.com/share/download/136";
}

@end
