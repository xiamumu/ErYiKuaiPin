//
//  KPGetExpressInfoCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/7/21.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPExpressInfoCellFrame.h"

@interface KPGetExpressInfoCell : UITableViewCell

@property (nonatomic, strong) KPExpressInfoCellFrame *expressInfoCellFrame;

@property (nonatomic, assign) NSUInteger expressInfoCellFrameCount;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellWithTable:(UITableView *)table;

@end
