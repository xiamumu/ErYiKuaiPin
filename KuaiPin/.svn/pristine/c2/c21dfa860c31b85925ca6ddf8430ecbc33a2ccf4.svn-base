//
//  KPCommonNavigationBar.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/20.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPMessageButton.h"
#import "XMSearchBar.h"

typedef enum : NSUInteger {
    KPCommonNavigationBarTypeHome,
    KPCommonNavigationBarTypeGoodsDetail,
} KPCommonNavigationBarType;

@interface KPCommonNavigationBar : UIView

@property (nonatomic, weak) KPButton *leftBtn;
@property (nonatomic, weak) KPButton *rightBtn;
@property (nonatomic, weak) XMSearchBar *searchBar;
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, weak) KPMessageButton *messageBtn;
@property (nonatomic, assign) KPCommonNavigationBarType navigationBarType;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) void(^leftBtnAction)();

@property (nonatomic, copy) void(^rightBtnAction)();

@property (nonatomic, copy) void(^messageBtnAction)();



+ (instancetype)navigationBar;
- (void)setBarBackgroundColorWithColor:(UIColor *)color;
@end
