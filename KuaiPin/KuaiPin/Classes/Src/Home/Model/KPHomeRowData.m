//
//  KPHoomeRowData.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeRowData.h"

@implementation KPHomeRowData

+ (instancetype)initWithTitle:(NSString *)title headerImageName:(NSString *)imageNmae type:(KPHomeRowDataType)homeRowDataType
{
    KPHomeRowData *rowData = [[self alloc] init];
    rowData.title = title;
    rowData.headerImageName = imageNmae;
    rowData.rowDataType = homeRowDataType;
    return rowData;
}

+ (instancetype)initWithTitle:(NSString *)title type:(KPHomeRowDataType)homeRowDataType
{
    return [self initWithTitle:title headerImageName:nil type:homeRowDataType];
}

- (CGFloat)cellHeight
{
    switch (self.rowDataType) {
        case KPHomeRowDataTypeDefault:
        {
            return 35 + ScaleHeight(119);
        }
            break;
        case KPHomeRowDataTypeGoods:
        {
            return 35 + ScaleHeight(242);
        }
            break;
        case KPHomeRowDataTypeBrand:
        {
            return 35 + ScaleHeight(187);
        }
            break;
            
        default:
            break;
    }
}


@end












