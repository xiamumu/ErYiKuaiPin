//
//  KPHomeCommonCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/4/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPHomeRowData.h"
@class KPHomeRowData;


@interface KPHomeTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) KPHomeRowData *rowData;

+ (instancetype)cellWithTable:(UITableView *)table;
@end
