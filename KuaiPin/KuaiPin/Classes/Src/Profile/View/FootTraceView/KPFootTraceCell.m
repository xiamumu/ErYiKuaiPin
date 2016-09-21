//
//  KPFootTraceCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPFootTraceCell.h"
#import "KPFootTraceContentView.h"
#import "KPGoodsDetailResult.h"

@interface KPFootTraceCell ()

@property (nonatomic, weak) KPFootTraceContentView *footTraceContentView;

@end
@implementation KPFootTraceCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *footTraceCell = @"footTraceCell";
    KPFootTraceCell *cell = [table dequeueReusableCellWithIdentifier:footTraceCell];
    if (cell == nil) {
        cell = [[KPFootTraceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:footTraceCell];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPFootTraceContentView *footTraceContentView = [[KPFootTraceContentView alloc] init];
        [self.contentView addSubview:footTraceContentView];
        self.footTraceContentView = footTraceContentView;
        
        __weak typeof (self) weakSelf = self;
        [self.footTraceContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (void)setGoodsDetailResult:(KPGoodsDetailResult *)goodsDetailResult
{
    _goodsDetailResult = goodsDetailResult;
    self.footTraceContentView.goodsDetailResult = goodsDetailResult;
}


@end
