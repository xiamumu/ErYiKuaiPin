//
//  KPAllOrderViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

// Controller
#import "KPAllOrderViewController.h"
#import "KPOrder.h"


@implementation KPAllOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    // 刷新订单
    NSAddObserver(refreshOrders, Noti_RefreshOrders)
    
    
    __weak typeof (self) weakSelf = self;
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setupData];
        [weakSelf.table.mj_header endRefreshing];
    }];
}

- (void)refreshOrders
{
    [self setupData];
}

- (void)setupData
{
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool orderWithParam:nil Success:^(id result) {
        
        if (CODE != 0) { WHYNSLog(@"-------订单列表获取失败%@", result[@"message"]); return; }
        
        if (weakSelf.rowDatas.count != 0) {
            [weakSelf.rowDatas removeAllObjects];
        }
        
        weakSelf.rowDatas = [KPOrder mj_objectArrayWithKeyValuesArray:result[@"data"][@"orderList"]];
        
        // 如果无订单，则提示用户无可现实的内容
        weakSelf.withoutAnythingView.hidden = weakSelf.rowDatas.count != 0;
        [weakSelf.table reloadData];
        
    } failure:^(NSError *error) {
        
        WHYNSLog(@"-------订单列表获取失败%@", error);
    }];
}

- (void)dealloc
{
    NSRemoveObserver
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

@end
