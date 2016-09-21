//
//  KPProfileOtherTableViewCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPProfileRowData.h"

@interface KPProfileOtherTableViewCell : UITableViewCell

@property (nonatomic, strong) KPProfileRowData *rowData;

+ (instancetype)cellWithTable:(UITableView *)table;
@end
