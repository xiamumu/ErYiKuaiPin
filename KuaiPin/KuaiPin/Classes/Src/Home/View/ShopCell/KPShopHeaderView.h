//
//  KPShopHeaderView.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPShopDataResult;
@interface KPShopHeaderView : UIImageView


@property (nonatomic, strong) KPShopDataResult *shopData;

@property (nonatomic, copy) void (^collectStore)(KPButton *collectBtn);

@property (nonatomic, copy) void (^deCollectStore)(KPButton *collectBtn);

@property (nonatomic, copy) void (^shareAction)(KPButton *collectBtn);

@property (nonatomic, assign) BOOL collectedBrand;

@end