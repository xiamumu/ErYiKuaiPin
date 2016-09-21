//
//  KPSearchController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/16.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KPSearchType) {
    KPSearchTypeALL,
    KPSearchTypeVendor,
};

@interface KPSearchController : UIViewController

+ (void)startSearchWithType:(KPSearchType)type;

@end
