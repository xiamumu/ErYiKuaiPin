//
//  KPBaseTabelViewHeaderViewCommonProtocol.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KPBaseTabelViewHeaderViewCommonProtocol <NSObject>

@optional

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

+ (CGFloat)headerViewHeight;

@end
