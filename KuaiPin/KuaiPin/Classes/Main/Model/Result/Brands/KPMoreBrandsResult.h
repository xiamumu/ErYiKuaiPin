//
//  KPMoreBrandsResult.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseResult.h"
@class KPBrand;
@interface KPMoreBrandsResult : KPBaseResult

/**  KPBrand 数组 */
@property (nonatomic, strong) NSArray <KPBrand *> *brands;


@end
