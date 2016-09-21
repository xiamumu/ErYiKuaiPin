//
//  KPBeLeftMoneyCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPBeLeftMoneyRowData.h"

@interface KPBeLeftMoneyCell : UITableViewCell

@property (nonatomic, strong) KPBeLeftMoneyRowData *rowData;

+ (instancetype)cellWithTable:(UITableView *)table;

@end
