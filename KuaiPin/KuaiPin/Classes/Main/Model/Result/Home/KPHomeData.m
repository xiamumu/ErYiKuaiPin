//
//  KPHomeData.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/24.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeData.h"

@implementation KPHomeData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bannerList":      @"KPBanner",
             @"firstList":       @"KPProduct",
             @"secondList":      @"KPProduct",
             @"thirdList":       @"KPProduct",
             @"fourthList":      @"KPProduct",
             @"brandList":       @"KPBrand",
             @"brandBannerList": @"KPBrand",
             @"activityBannerList": @"KPActivityBanner"
             };
}

@end
