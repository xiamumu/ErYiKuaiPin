//
//  KPCancelOrdersView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCancelOrdersView.h"
#import "KPOrderRowData.h"
@implementation KPCancelOrdersView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupRowData];
    }
    return self;
}
- (void)setupRowData
{
    for (int i = 0; i < 5 ; i++) {
        KPOrderRowData *rowdata = [[KPOrderRowData alloc] init];
        rowdata.orderNum = @"201505101241";
        rowdata.orderState = @2;
        rowdata.img = PlaceholderImage;
        rowdata.title = @"唉我丢了把刀，我想知道它现在正插在谁的身上。";
        rowdata.price = @"￥998.00";
        [self.rowDatas addObject:rowdata];
    }
}
@end
