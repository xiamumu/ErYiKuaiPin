//
//  KPGoodsCollectionViewCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/29.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGoodsCollectionViewCell.h"
#import "KPProduct.h"
#import "KPUpdateSubsidizeParam.h"
#import "KPSoldoutView.h"

@interface KPGoodsCollectionViewCell()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIImageView *storeAvatar;
@property (nonatomic, weak) UIImageView *sealImg;
@property (nonatomic, weak) KPButton *subsidyDay;
@property (nonatomic, weak) UILabel *productDesc;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) KPButton *sealBtn;
@property (nonatomic, weak) KPSoldoutView *soldoutView;

@end

@implementation KPGoodsCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.layer.masksToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        self.imgView = imgView;
        
        KPButton *subsidyDay = [[KPButton alloc] init];
        [subsidyDay setBackgroundImage:[UIImage imageNamed:@"list_day_bg"] forState:UIControlStateNormal];
        [subsidyDay.titleLabel setFont:UIFont_10];
        [subsidyDay setTitleEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, 0)];
        [subsidyDay setEnabled:YES];
        [self addSubview:subsidyDay];
        self.subsidyDay = subsidyDay;
        
        UIView *line = [UIView line];
        [self addSubview:line];
        
        UIImageView *storeAvatar = [[UIImageView alloc] init];
        storeAvatar.layer.masksToBounds = YES;
        storeAvatar.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:storeAvatar];
        self.storeAvatar = storeAvatar;
        
        UIImageView *sealImg = [[UIImageView alloc] init];
        sealImg.image = [UIImage imageNamed:@"list_seal"];
        [self addSubview:sealImg];
        self.sealImg = sealImg;
        
        KPSoldoutView *soldoutView = [[KPSoldoutView alloc] init];
        soldoutView.titleFont = UIFont_18;
        soldoutView.hidden = YES;
        [imgView addSubview:soldoutView];
        self.soldoutView = soldoutView;
        
        UILabel *productDesc = [UILabel addLabelWithTitle:nil textColor:RGBColor(25, 25, 25) font:UIFont_13];
        productDesc.numberOfLines = 2;
//        productDesc.backgroundColor = RandomColor;
        [self addSubview:productDesc];
        self.productDesc = productDesc;
        
        UILabel *price = [UILabel addLabelWithTitle:nil textColor:RGBColor(250, 72, 98) font:UIFont_18];
        price.textAlignment = NSTextAlignmentRight;
        [self addSubview:price];
        self.price = price;
        
        
        __weak typeof(self) weakSelf = self;
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(weakSelf);
            make.height.mas_equalTo(weakSelf.imgView.mas_width);
        }];
        
        [soldoutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf.imgView);
            make.height.mas_equalTo(ScaleHeight(87));
        }];
        
        [subsidyDay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf);
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.size.mas_equalTo(subsidyDay.currentBackgroundImage.size);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).offset(CommonMargin);
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.top.mas_equalTo(imgView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        
        [storeAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf);
            make.top.mas_equalTo(weakSelf.imgView.mas_bottom).offset(6);
            make.size.mas_equalTo(CGSizeMake(48, 24));
        }];
        
        [productDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).offset(5);
            make.right.mas_equalTo(weakSelf).offset(- 5);
            make.top.mas_equalTo(weakSelf.storeAvatar.mas_bottom).offset(6);
        }];
        
        
        [sealImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.productDesc.mas_bottom).offset(5);
            make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.size.mas_equalTo(sealImg.image.size);
        }];
        
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.productDesc);
            make.centerY.mas_equalTo(weakSelf.sealImg);
        }];
        
    }
    return self;
}

- (void)setProduct:(KPProduct *)product
{
    _product = product;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:product.productCategoryImage] placeholderImage:[UIImage imageNamed:@"homeGoods_Placeholder"]];
    
    [self.storeAvatar sd_setImageWithURL:[NSURL URLWithString:product.storeAvatar] placeholderImage:[UIImage imageNamed:@"homeGoods_Placeholder"]];
    [self.subsidyDay setTitle:[NSString stringWithFormat:@"%@天",product.subsidyDay] forState:UIControlStateNormal];
    self.productDesc.text = product.productName;
    self.price.text = [NSString stringWithFormat:@"￥%@", product.productPrice];

    // 售罄
    if (product.productStorage.integerValue == 0) {
        self.soldoutView.hidden = NO;
        self.productDesc.textColor = HexColor(8a8a8a);
        self.price.textColor = HexColor(8a8a8a);
    } else {
        self.soldoutView.hidden = YES;
        self.productDesc.textColor = BlackColor;
        self.price.textColor = OrangeColor;
    }
    
}

@end
