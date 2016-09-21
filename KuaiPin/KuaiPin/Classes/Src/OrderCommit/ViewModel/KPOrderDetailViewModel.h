//
//  KPOrderDetailViewModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseViewModel.h"
#import "KPOrderDetailModel.h"

@interface KPOrderDetailViewModel : KPBaseViewModel

@property (nonatomic, strong) id orderDetail;

@property (nonatomic, strong) NSNumber *orderAddTime;

@property (nonatomic, strong) NSNumber *orderState;

@property (nonatomic, assign) NSInteger paymentTag;

@property (nonatomic, strong) NSNumber *totalPrice;

@end
