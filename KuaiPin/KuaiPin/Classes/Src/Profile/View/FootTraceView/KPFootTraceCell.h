//
//  KPFootTraceCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPGoodsDetailResult;
@interface KPFootTraceCell : UITableViewCell


@property (nonatomic, strong) KPGoodsDetailResult *goodsDetailResult;

+ (instancetype)cellWithTable:(UITableView *)table;
@end
