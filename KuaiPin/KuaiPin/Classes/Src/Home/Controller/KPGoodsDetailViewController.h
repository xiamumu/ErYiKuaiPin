//
//  KPGoodsDetailViewController.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/8.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPProduct.h"

@interface KPGoodsDetailViewController : UIViewController

@property (nonatomic, strong) KPProduct *product;

/**
 *  活动id
 */
@property (nonatomic, copy) NSString *activity_id;

/** 是否是新手特权商品 */
@property (nonatomic, copy) NSString *virginUser;


@end
