//
//  KPVendorModel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPVendorModel.h"

@implementation KPVendorModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"items" : @"KPGoodModel"
             };
}

- (void)setItems:(NSMutableArray<KPGoodModel *> *)items {
    _items = items;

    __block BOOL vendorSelecteEnable = NO;
    __block NSInteger goodsCount = 0;
    [items enumerateObjectsUsingBlock:^(KPGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.selecteEnable) {
            vendorSelecteEnable = YES;
            goodsCount++;
        }
    }];
    _vendorSelecteEnable = vendorSelecteEnable;
    _goodsCount = goodsCount;
}

@end
