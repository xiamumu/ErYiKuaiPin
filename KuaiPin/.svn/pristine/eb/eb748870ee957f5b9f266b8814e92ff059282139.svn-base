//
//  KPOrderCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderCell.h"
#import "KPOrderCellContentView.h"
#import "KPOrder.h"
@interface KPOrderCell ()

@property (nonatomic, weak) KPOrderCellContentView *orderContentView;

@end
@implementation KPOrderCell
+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *orderCell = @"orderCell";
    KPOrderCell *cell = [table dequeueReusableCellWithIdentifier:orderCell];
    if (cell == nil) {
        cell = [[KPOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCell];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPOrderCellContentView *orderContentView = [[KPOrderCellContentView alloc] init];
        [self.contentView addSubview:orderContentView];
        self.orderContentView = orderContentView;
        
        __weak typeof (self)weakSelf = self;
        [orderContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
    }
    return self;
}

- (void)setOrder:(KPOrder *)order
{
    _order = order;
    self.orderContentView.order = order;
}
@end
