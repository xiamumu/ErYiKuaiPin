//
//  KPShopTableViewCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPShopTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *products;

+ (instancetype)cellWithTable:(UITableView *)table;

@end
