//
//  KPOrderCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPOrderRowData;

@interface KPOrderCell : UITableViewCell

@property (nonatomic, strong) KPOrderRowData *rowData;
+ (instancetype)cellWithTable:(UITableView *)table;
@end
