//
//  KPFinishPayBackView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPFinishPayBackView.h"
#import "KPPayBackRowData.h"
@implementation KPFinishPayBackView



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
    for (int i = 0; i < 4 ; i++) {
        KPPayBackRowData *rowData = [[KPPayBackRowData alloc] init];
        rowData.orderNum = @"123456789011";
        rowData.orderBeginTime = @"201505110955";
        rowData.payBackBeginTime = @"201605110955";
        rowData.payBackMoney = @"998.00";
        rowData.payBackState = 2;
        [self.rowDatas addObject:rowData];
    }
}
@end
