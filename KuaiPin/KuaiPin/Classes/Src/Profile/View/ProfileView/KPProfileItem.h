//
//  KPProfileItem.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPBageView.h"

@interface KPProfileItem : UIView

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UIImageView *lineImage;
@property (nonatomic, weak) KPBageView *bageView;

/** 提醒数字 */
@property (nonatomic, copy) NSString *badgeValue;


@end
