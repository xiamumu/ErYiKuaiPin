//
//  KPProfileFooderCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPProfileRowData.h"

typedef void(^PhoneButtonHandler)();

@interface KPProfileFooderCell : UITableViewCell
@property (nonatomic, strong) KPProfileRowData *rowData;

@property (nonatomic, copy) PhoneButtonHandler handler;

+ (instancetype)cellWithTable:(UITableView *)table handler:(PhoneButtonHandler)handler;
@end
