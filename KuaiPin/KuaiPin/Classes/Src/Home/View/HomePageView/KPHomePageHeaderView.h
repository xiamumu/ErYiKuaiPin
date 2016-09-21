//
//  KPHomePageHeaderView.h
//  KuaiPin
//
//  Created by 21_xm on 16/9/1.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPActivityBanner;

@interface KPHomePageHeaderView : UIView

@property (nonatomic, strong) NSArray *bannerImages;

@property (nonatomic, strong) NSArray<KPActivityBanner *> *activityBannerList;

@property (nonatomic, copy) void(^leftItemAciton)(UIButton *);

@property (nonatomic, copy) void(^rightTopItemAciton)(UIButton *);

@property (nonatomic, copy) void(^rightBottomItemAciton)(UIButton *);

@property (nonatomic, copy) void(^didSelectCycleScrollViewItem)(NSInteger index);


@end
