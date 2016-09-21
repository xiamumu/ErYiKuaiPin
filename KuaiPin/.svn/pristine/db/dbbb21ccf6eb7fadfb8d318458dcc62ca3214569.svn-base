//
//  KPLocalPickerController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/8/30.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPAddressModel.h"

typedef void(^FinishedHandler)(NSString *addressLocation);

@interface KPLocalPickerController : UIViewController

@property (nonatomic, copy) NSString *addressLocation;

    //provinceId cityId countryId townId
@property (nonatomic, copy) void(^finishedHandler)(NSString *addressLocation);

    // id provinceId cityId countryId townId
@property (nonatomic, strong) NSNumber *provinceId;
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, strong) NSNumber *countryId;
@property (nonatomic, strong) NSNumber *townId;

@property (nonatomic, strong) KPAddressModel *addressModel;

+ (instancetype)localPickerControllerWithFinishedHandler:(FinishedHandler)finishedHandler;

- (void)showView;

@end
