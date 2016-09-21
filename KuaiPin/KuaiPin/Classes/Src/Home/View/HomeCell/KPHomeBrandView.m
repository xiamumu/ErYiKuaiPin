//
//  KPHomeBrandView.m
//  KuaiPin
//
//  Created by 21_xm on 16/7/14.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeBrandView.h"
#import "KPBrand.h"


@implementation KPHomeBrandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
//        self.layer.masksToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkGoodsDetailAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)setBrand:(KPBrand *)brand
{
    _brand = brand;
    [self sd_setImageWithURL:[NSURL URLWithString:brand.storeAvatar] placeholderImage:[UIImage imageNamed:@"brandList_Placeholder"]];
}

// 商品详情跳转
- (void)checkGoodsDetailAction:(UITapGestureRecognizer *)tap
{
    KPHomeBrandView *brandView = (KPHomeBrandView *)tap.view;
    NSPostNote(Noti_CheckGoodsDetailAction, brandView)
}

@end
