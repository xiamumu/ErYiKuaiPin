//
//  KPBaseTableViewCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseTableViewCell.h"

@implementation KPBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *const ID = @"KPBaseTableViewCell";
    
    KPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[KPBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
    
}

//- (void)setModel:(__kindof KPBaseModel *)model {}
//
//- (KPBaseModel *)model {return nil;}

@end
