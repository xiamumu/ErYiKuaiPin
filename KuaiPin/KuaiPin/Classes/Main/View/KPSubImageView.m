//
//  KPSubImageView.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/1.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSubImageView.h"
#import "KPProduct.h"
#import "KPBrand.h"

@implementation KPSubImageView

- (void)setProduct:(KPProduct *)product
{
    _product = product;
    
    [self sd_setImageWithURL:[NSURL URLWithString:product.productImage] placeholderImage:[UIImage imageNamed:@"banner_Placeholder"]];
    self.iden = @"female";
}

- (void)setBrand:(KPBrand *)brand
{
    _brand = brand;
    
    [self sd_setImageWithURL:[NSURL URLWithString:brand.storeAvatar] placeholderImage:[UIImage imageNamed:@"banner_Placeholder"]];
    self.iden = @"brand";
    
}
@end
