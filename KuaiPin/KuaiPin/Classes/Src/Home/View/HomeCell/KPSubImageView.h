//
//  KPSubImageView.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/1.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPProduct;
@class KPBrand;

@interface KPSubImageView : UIImageView

@property (nonatomic, strong) KPProduct *product;
@property (nonatomic, strong) KPBrand *brand;
@property (nonatomic, copy) NSString *iden;

@end
