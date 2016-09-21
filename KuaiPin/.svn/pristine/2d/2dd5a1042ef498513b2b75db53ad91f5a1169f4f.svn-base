//
//  KPShopTableViewCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPShopTableViewCell.h"
#import "KPShopTableViewCellContentView.h"

@interface KPShopTableViewCell ()

@property (nonatomic, weak) KPShopTableViewCellContentView *shopContentView;

@end
@implementation KPShopTableViewCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *shopTableViewCell = @"shopTableViewCell";
    KPShopTableViewCell *cell = [table dequeueReusableCellWithIdentifier:shopTableViewCell];
    if (cell == nil) {
        cell = [[KPShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopTableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPShopTableViewCellContentView *shopContentView = [[KPShopTableViewCellContentView alloc] init];
        [self.contentView addSubview:shopContentView];
        self.shopContentView = shopContentView;
        
    }
    
    return self;
}

- (void)setProducts:(NSArray *)products
{
    _products = products;
    self.shopContentView.products = products;
}

- (void)layoutSubviews
{
    __weak typeof (self) weakSelf = self;
    [self.shopContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}
@end
