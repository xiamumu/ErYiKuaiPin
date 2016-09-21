//
//  KPBrandTableViewCell.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPBrand;

@interface KPBrandTableViewCell : UITableViewCell

@property (nonatomic, strong) KPBrand *brand;
+ (instancetype)cellWithTable:(UITableView *)table;
@end
