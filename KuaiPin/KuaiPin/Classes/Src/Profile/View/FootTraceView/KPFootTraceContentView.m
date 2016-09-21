//
//  KPFootTraceContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPFootTraceContentView.h"
#import "KPGoodsDetailResult.h"

@interface KPFootTraceContentView ()
@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIImageView *arrow;
@property (nonatomic, weak) UIView *line;
@end
@implementation KPFootTraceContentView

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
        
    }
    return self;
}

- (void)setGoodsDetailResult:(KPGoodsDetailResult *)goodsDetailResult
{
    _goodsDetailResult = goodsDetailResult;
    self.titleLab.text = goodsDetailResult.productName;
    self.price.text = [NSString stringWithFormat:@"￥%.2f",[goodsDetailResult.productPrice floatValue]];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:goodsDetailResult.productImage] placeholderImage:[UIImage imageNamed:@"homeGoods_Placeholder"]];
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
