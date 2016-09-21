//
//  KPFootTraceCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGoodsCollectionCell.h"
#import "KPGoodsCollectionCellContentView.h"
#import "KPProduct.h"

@interface KPGoodsCollectionCell ()

@property (nonatomic, weak) KPGoodsCollectionCellContentView *goodsCollectionCellContentView;

@end
@implementation KPGoodsCollectionCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *goodsCollectionCell = @"goodsCollectionCell";
    KPGoodsCollectionCell *cell = [table dequeueReusableCellWithIdentifier:goodsCollectionCell];
    if (cell == nil) {
        cell = [[KPGoodsCollectionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:goodsCollectionCell];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPGoodsCollectionCellContentView *goodsCollectionCellContentView = [[KPGoodsCollectionCellContentView alloc] init];
        [self.contentView addSubview:goodsCollectionCellContentView];
        self.goodsCollectionCellContentView = goodsCollectionCellContentView;
        
        __weak typeof (self) weakSelf = self;
        [self.goodsCollectionCellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (void)setProduct:(KPProduct *)product
{
    _product = product;
    self.goodsCollectionCellContentView.product = product;
}


@end
