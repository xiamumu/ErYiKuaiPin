//
//  KPFootTraceContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGoodsCollectionCellContentView.h"
#import "KPProduct.h"
#import "KPSoldoutView.h"

@interface KPGoodsCollectionCellContentView ()
@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIImageView *arrow;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) KPSoldoutView *soldoutView;
@property (nonatomic, strong) KPButton *checkOthers;

@end
@implementation KPGoodsCollectionCellContentView

- (KPButton *)checkOthers
{
    if (_checkOthers == nil) {
        
        _checkOthers = [[KPButton alloc] init];
        _checkOthers.backgroundColor = OrangeColor;
        _checkOthers.layer.cornerRadius = 5;
        _checkOthers.titleLabel.font = UIFont_13;
        [_checkOthers setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_checkOthers setTitle:@"查看其它" forState:UIControlStateNormal];
        [_checkOthers addTarget:self action:@selector(checkOthersAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkOthers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = BlackColor;
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.numberOfLines = 2;
        titleLab.font = UIFont_15;
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        UILabel *price = [[UILabel alloc] init];
        price.textColor = RedColor;
        price.textAlignment = NSTextAlignmentLeft;
        price.font = UIFont_14;
        [self addSubview:price];
        self.price = price;
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_nexticon"]];
        [self addSubview:arrow];
        self.arrow = arrow;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = SeperatorColor;
        [self addSubview:line];
        self.line = line;
        
        KPSoldoutView *soldoutView = [[KPSoldoutView alloc] init];
        soldoutView.titleFont = UIFont_14;
        soldoutView.hidden = YES;
        [imgView addSubview:soldoutView];
        self.soldoutView = soldoutView;
        
    }
    return self;
}

- (void)setProduct:(KPProduct *)product
{
    _product = product;
    self.titleLab.text = product.productName;
    self.price.text = [NSString stringWithFormat:@"￥%.2f",[product.productPrice floatValue]];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:product.productImage] placeholderImage:[UIImage imageNamed:@"homeGoods_Placeholder"]];

//    product.productStorage = 0;
    if (product.productStorage.integerValue == 0) {
        self.titleLab.textColor = GrayColor;
        self.price.textColor = GrayColor;
        self.soldoutView.hidden = NO;
        [self addSubview:self.checkOthers];
        
        __weak typeof (self) weakSelf = self;
        CGFloat width = [self.checkOthers.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.checkOthers.titleLabel.font}].width + 10;
        [self.checkOthers mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.height.mas_equalTo(23);
            make.width.mas_equalTo(width);
        }];
        
    } else {
        self.soldoutView.hidden = YES;
        [self.checkOthers removeFromSuperview];
        self.checkOthers = nil;
    }
}

// 查看更多点击发送通知
- (void)checkOthersAction:(KPButton *)checkOthers
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[PcIdKey] = self.product.pcId1;
    dict[PcIdNameKey] = self.product.strPcId1;
    NSPostNoteWithUserInfo(Noti_CheckOthers, nil, dict)
}

- (void)layoutSubviews
{
    
    __weak typeof (self) weakSelf = self;
    
    CGSize imgViewSize = CGSizeMake(82, 82);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(imgViewSize);
    }];
    
    CGFloat titleLabH = [self.titleLab.text sizeWithAttributes:@{NSFontAttributeName: self.titleLab.font}].height * 2 + 5;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(CommonMargin);
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin * 3);
        make.top.mas_equalTo(self.imgView).offset(5);
        make.height.mas_equalTo(titleLabH);
    }];
    
    
    CGFloat priceH = [self.price.text sizeWithAttributes:@{NSFontAttributeName: self.price.font}].height;
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(CommonMargin);
        make.bottom.mas_equalTo(self.imgView).offset(-CommonMargin);
        make.height.mas_equalTo(priceH);
    }];
    
    [self.soldoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.imgView);
        make.height.mas_equalTo(ScaleHeight(40));
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-CommonMargin);
        make.size.mas_equalTo(self.arrow.image.size);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
}

@end
