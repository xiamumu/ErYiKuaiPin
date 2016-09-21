//
//  KPAddressManageViewController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPAddressModel.h"

typedef NS_ENUM(NSUInteger, KPAddressManageType) {
    KPAddressManageTypeAdd,
    KPAddressManageTypeEdit,
};

@interface KPAddressManageViewController : UIViewController

@property (nonatomic, assign) KPAddressManageType type;

@property (nonatomic, strong) KPAddressModel *addressModel;

@property (nonatomic, copy) void (^NewCompletion)();

@property (nonatomic, copy) void (^EditCompletion)();

+ (instancetype)addressManageViewControllerWithType:(KPAddressManageType)type;



@end
