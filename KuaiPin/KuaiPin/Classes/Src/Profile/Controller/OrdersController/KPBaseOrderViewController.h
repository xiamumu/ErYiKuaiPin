//
//  KPBaseOrderViewController.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/8.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMScrollPageMenu.h"
#import "KPOrderParam.h"

@interface KPBaseOrderViewController : UIViewController

@property (nonatomic, strong) XMScrollPageMenu *pageMenu;

@property (nonatomic, strong) KPOrderParam *orderParam;

/** 默认选中的页面 */
@property (nonatomic, assign) NSInteger selectedPageIndex;

@end
