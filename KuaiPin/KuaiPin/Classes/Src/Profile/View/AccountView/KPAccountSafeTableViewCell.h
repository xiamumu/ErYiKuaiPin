//
//  KPAccountSafeTableViewCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPAccountRowData;

@interface KPAccountSafeTableViewCell : UITableViewCell

@property (nonatomic, strong) KPAccountRowData *rowData;

+ (instancetype)cellWithTable:(UITableView *)table;
@end
