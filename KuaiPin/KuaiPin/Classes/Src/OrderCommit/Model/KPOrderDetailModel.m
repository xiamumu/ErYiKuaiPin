//
//  KPOrderDetailModel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/6/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderDetailModel.h"

@implementation KPOrderDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"stores" : @"KPVendorModel"};
}

- (void)setOrder:(KPOrderModel *)order {
    _order = order;

    KPGoodModel *good = nil;
    KPVendorModel *vendorTemp = nil;
    NSMutableArray *tempItems = [NSMutableArray array];

    for (int i = 0; i < order.orderItems.count; i++) {

        good = order.orderItems[i];

        for (KPVendorModel *vendor in self.stores) {

            if (good.storeId == vendor.storeId) {
                [tempItems addObject:good];
                vendorTemp = vendor;
            }

        }

        vendorTemp.items = [tempItems copy];

    }

}

@end
