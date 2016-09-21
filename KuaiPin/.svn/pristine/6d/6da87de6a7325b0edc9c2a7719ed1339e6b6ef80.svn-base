//
//  KPGoodsCollectionViewCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/29.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGoodsCollectionViewCell.h"
#import "KPCommonView.h"
#import "KPGoodsListData.h"

@interface KPGoodsCollectionViewCell()

@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) KPCommonView *commonView;

@end

@implementation KPGoodsCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.userInteractionEnabled = YES;
        bgView.image = [UIImage imageNamed:@"shadow_bg"];
        [self addSubview:bgView];
        self.bgView = bgView;
        KPCommonView *commonView = [[KPCommonView alloc] init];
        [commonView.addListBtn addTarget:self action:@selector(addListBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:commonView];
        self.commonView = commonView;
        
    }
    return self;
}

- (void)setGoodsListData:(KPGoodsListData *)goodsListData
{
    _goodsListData = goodsListData;
    self.commonView.commonViewType = KPCommonViewTypeTopImageWithTitlePriceAndCanBuy;
    [self.commonView.imgView sd_setImageWithURL:[NSURL URLWithString:goodsListData.imgStr] placeholderImage:PlaceholderImage];
    self.commonView.brandLab.text = goodsListData.brandText;
    self.commonView.priceLabel.text = goodsListData.priceText;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    [self.commonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.bgView).offset(2);
        make.right.bottom.mas_equalTo(self.bgView).offset(-2);
    }];
}

- (void)addListBtnAction:(UIButton *)addListBtn
{
    if (addListBtn.selected == YES) {
        NSLog(@"取消加入购物车");
        addListBtn.selected = NO;
    }
    else
    {
        NSLog(@"加入购物车");
        addListBtn.selected = YES;
    }}
@end
