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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
}

- (void)setProduct:(KPProduct *)product
{
    _product = product;
    [self sd_setImageWithURL:[NSURL URLWithString:product.productCommendCategoryImage] placeholderImage:[UIImage imageNamed:@"banner_Placeholder"]];
    self.iden = @"product";
}
- (void)setBrand:(KPBrand *)brand
{
    _brand = brand;
        [self sd_setImageWithURL:[NSURL URLWithString:brand.storeAvatar] placeholderImage:[UIImage imageNamed:@"banner_Placeholder"]];
    self.iden = @"brand";
    
}
@end
