//
//  KPOrderMessageCell.h
//  KuaiPin
//
//  Created by 王洪运 on 16/8/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseTableViewCell.h"

@interface KPOrderMessageCell : KPBaseTableViewCell

@property (nonatomic, copy) void (^changedOrderMessage)(NSString *orderMessage);

@end
