//
//  KPPayBackCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayBackCell.h"
#import "KPPayBackContentView.h"
#import "KPPayBackOrder.h"

@interface KPPayBackCell ()

@property (nonatomic, weak) KPPayBackContentView *payBackContentView;

@end
@implementation KPPayBackCell
+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *orderCell = @"orderCell";
    KPPayBackCell *cell = [table dequeueReusableCellWithIdentifier:orderCell];
    if (cell == nil) {
        cell = [[KPPayBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCell];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPPayBackContentView *payBackContentView = [[KPPayBackContentView alloc] init];
        [self.contentView addSubview:payBackContentView];
        self.payBackContentView = payBackContentView;
        
        __weak typeof (self)weakSelf = self;
        [payBackContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
    }
    return self;
}

- (void)setPayBackOrder:(KPPayBackOrder *)payBackOrder
{
    _payBackOrder = payBackOrder;
    self.payBackContentView.payBackOrder = payBackOrder;
}
@end
