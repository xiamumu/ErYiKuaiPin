//
//  KPAllOrdersView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAllOrdersView.h"
#import "KPOrderRowData.h"

@implementation KPAllOrdersView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupRowData];
    }
    return self;
}

- (void)setupRowData
{
    
    KPOrderRowData *rowdata = [[KPOrderRowData alloc] init];
    rowdata.orderNum = @"201505101241";
    rowdata.orderState = @0;
    rowdata.img = PlaceholderImage;
    rowdata.title = @"唉我丢了把刀，我想知道它现在正插在谁的身上。";
    rowdata.price = @"￥998.00";
    [self.rowDatas addObject:rowdata];
    
    KPOrderRowData *rowdata1 = [[KPOrderRowData alloc] init];
    rowdata1.orderNum = @"201505101241";
    rowdata1.orderState = @1;
    rowdata1.img = PlaceholderImage;
    rowdata1.title = @"唉我丢了把刀，我想知道它现在正插在谁的身上。";
    rowdata1.price = @"￥998.00";
    [self.rowDatas addObject:rowdata1];
    
    KPOrderRowData *rowdata2 = [[KPOrderRowData alloc] init];
    rowdata2.orderNum = @"201505101241";
    rowdata2.orderState = @2;
    rowdata2.img = PlaceholderImage;
    rowdata2.title = @"唉我丢了把刀，我想知道它现在正插在谁的身上。";
    rowdata2.price = @"￥998.00";
    [self.rowDatas addObject:rowdata2];
    
    KPOrderRowData *rowdata3 = [[KPOrderRowData alloc] init];
    rowdata3.orderNum = @"201505101241";
    rowdata3.orderState = @3;
    rowdata3.img = PlaceholderImage;
    rowdata3.title = @"唉我丢了把刀，我想知道它现在正插在谁的身上。";
    rowdata3.price = @"￥998.00";
    [self.rowDatas addObject:rowdata3];
}
@end
