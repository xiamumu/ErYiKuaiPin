//
//  KPBaseTableViewCell.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPBaseTableViewCellCommonProtocol.h"
#import "KPBaseModel.h"

@interface KPBaseTableViewCell : UITableViewCell<KPBaseTableViewCellCommonProtocol>

@property (nonatomic, strong) __kindof KPBaseModel *model;

@end
