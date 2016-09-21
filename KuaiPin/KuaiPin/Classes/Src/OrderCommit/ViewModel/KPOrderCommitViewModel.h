//
//  KPOrderCommitViewModel.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseViewModel.h"

@class KPVendorModel;
@class KPAddressModel;

@interface KPOrderCommitViewModel : KPBaseViewModel

@property (nonatomic, strong) NSArray<KPVendorModel *> *vendors;

@property (nonatomic, strong) id defaultReceiver;

@property (nonatomic, assign) CGFloat totalPrice;

@property (nonatomic, assign) CGFloat actualPrice;

@property (nonatomic, copy) NSString *orderMessage;

- (NSString *)cartItemIds;

- (NSNumber *)receiverId;

@end
