//
//  KPPropertyViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPropertyViewController.h"
#import "KPPayBackDetailViewController.h"
#import "XMScrollPageMenu.h"
#import "KPUnPayBackViewController.h"
#import "KPCanPayBackViewController.h"
#import "KPFinishPayBackViewController.h"

@interface KPPropertyViewController ()
@end

@implementation KPPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的消费资产";
    
    [self setupUI];

    
    // 添加监听
    [self setupNotification];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.title = @"我的消费资产";
}

- (void)setupUI
{
    XMScrollPageMenu *pageMenu = [XMScrollPageMenu menu];
    pageMenu.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64);
    
    // 添加未贴现页面
    KPUnPayBackViewController *unPayBack = [[KPUnPayBackViewController alloc] init];
    
    // 添加未可贴现页面
    KPCanPayBackViewController *canPayBack = [[KPCanPayBackViewController alloc] init];
    
    // 添加已完成贴现页面
    KPFinishPayBackViewController *finishPayBack = [[KPFinishPayBackViewController alloc] init];
    
    pageMenu.childViews = @[unPayBack, canPayBack, finishPayBack];
    pageMenu.titles = @[@"未贴现", @"可贴现", @"已贴现"];
    [self.view addSubview:pageMenu];
}

// 添加消息
- (void)setupNotification
{
    // 添加跳转到消费资产订单详情页面
    NSAddObserver(payBackOrderDetail:, Noti_PayBackOrderDetail)
}

// 贴现详情
- (void)payBackOrderDetail:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    KPPayBackDetailViewController *payBackDetailVc = [[KPPayBackDetailViewController alloc] init];
    payBackDetailVc.assetsSn = userInfo[@"assetsSn"];
    payBackDetailVc.orderSn = userInfo[@"orderSn"];
    payBackDetailVc.productId = userInfo[@"productId"];
    [self.navigationController pushViewController:payBackDetailVc animated:YES];
}
#pragma mark - 生命周期
- (void)dealloc
{
    NSRemoveObserver
}
@end
