//
//  KPProduct.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPProduct.h"

@implementation KPProduct

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"productId": @"id",
             @"storeAvatar" : @"brand.storeAvatar"};
}
@end
