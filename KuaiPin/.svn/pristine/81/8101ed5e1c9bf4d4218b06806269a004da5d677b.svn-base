//
//  KPBaseTableViewHeaderView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseTableViewHeaderView.h"

@implementation KPBaseTableViewHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPBaseTableViewHeaderView";
    
    KPBaseTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (headerView == nil) {
        headerView = [[KPBaseTableViewHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return headerView;
}

@end
