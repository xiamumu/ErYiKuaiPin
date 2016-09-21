//
//  KPRootPayBackViewController.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPWithoutAnythingView.h"
#import "KPPayBackOrderParam.h"

@class KPPayBackOrder;


@interface KPRootPayBackViewController : UIViewController

@property (nonatomic, weak) KPWithoutAnythingView *withoutAnythingView;

@property (nonatomic, weak) UITableView *table;


@property (nonatomic, strong) NSMutableArray <KPPayBackOrder *> *payBackOrders;

/**
 *   分页页码
 */
@property (nonatomic, assign) NSUInteger pageNumber;

@end
