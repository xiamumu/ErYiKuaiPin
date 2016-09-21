//
//  KPHomeBrandView.h
//  KuaiPin
//
//  Created by 21_xm on 16/7/14.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPProduct;
@class KPBrand;

@interface KPHomeBrandView : UIImageView

@property (nonatomic, strong) KPProduct *product;
@property (nonatomic, strong) KPBrand *brand;

@end
