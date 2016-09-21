//
//  KPHomeDefaultView.m
//  KuaiPin
//
//  Created by 21_xm on 16/7/14.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeDefaultView.h"
#import "KPProduct.h"

@interface KPHomeDefaultView ()

@property (nonatomic, weak) UILabel *brandLab;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UIImageView *imgView;


@end
@implementation KPHomeDefaultView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    
    self.userInteractionEnabled = YES;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:imgView];
    self.imgView = imgView;
    
    UILabel *brandLab = [UILabel addLabelWithTitle:@"" textColor:RGBColor(25, 25, 25) font:UIFont_11];
    if (!(iPhone5)) {
        brandLab.font = UIFont_12;
    }
    brandLab.numberOfLines = 2;
    brandLab.textAlignment = NSTextAlignmentCenter;
//    brandLab.backgroundColor = RandomColor;
    [self addSubview:brandLab];
    self.brandLab = brandLab;
    
    UILabel *price = [UILabel addLabelWithTitle:@"" textColor:RGBColor(250, 72, 98) font:UIFont_13];
    if (!(iPhone5)) {
        price.font = UIFont_14;
    }
    price.textAlignment = NSTextAlignmentCenter;
    [self addSubview:price];
//    price.backgroundColor = RandomColor;
    self.price = price;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkGoodsDetailAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}
- (void)setProduct:(KPProduct *)product
{
    _product = product;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:product.productImage] placeholderImage:[UIImage imageNamed:@"homeGoods_Placeholder"]];
    self.brandLab.text = product.productName;
    self.price.text = [NSString stringWithFormat:@"￥%.2f", [product.productPrice floatValue]];
}

// 商品详情跳转
- (void)checkGoodsDetailAction:(UITapGestureRecognizer *)tap
{
    KPHomeDefaultView *defaultView = (KPHomeDefaultView *)tap.view;
    NSPostNote(Noti_CheckGoodsDetailAction, defaultView)
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf).offset(2);
        make.right.mas_equalTo(weakSelf).offset(-2);
        make.height.mas_equalTo(weakSelf.imgView.mas_width);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
    }];
    
    
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin * 0.5);
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin * 0.5);
        make.bottom.mas_equalTo(weakSelf.price.mas_top).offset(-3);
    }];
    
}

@end
