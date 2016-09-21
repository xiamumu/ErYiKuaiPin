//
//  KPProfileTableViewCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPProfileRowData.h"

@interface KPProfileTableViewCell : UITableViewCell

@property (nonatomic, strong) KPProfileRowData *rowData;
@property (nonatomic, assign) NSUInteger section;

+ (instancetype)cellWithTable:(UITableView *)table;


@end
