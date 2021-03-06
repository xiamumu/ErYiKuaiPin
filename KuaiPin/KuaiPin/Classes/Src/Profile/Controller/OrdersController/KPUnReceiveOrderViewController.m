//
//  KPUnReceiveViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPUnReceiveOrderViewController.h"
#import "KPOrder.h"
#import "KPconfirmReceiptParam.h"

@interface KPUnReceiveOrderViewController ()

@end

@implementation KPUnReceiveOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 请求订单
    [self setupData];
    
    // 收货
    NSAddObserver(receive:, Noti_Receive)
    
    // 刷新订单
    NSAddObserver(refreshOrders, Noti_RefreshOrders)
    
    __weak typeof (self) weakSelf = self;
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setupData];
        [weakSelf.table.mj_header endRefreshing];
    }];
}
// 刷新订单
- (void)refreshOrders
{
    [self setupData];
}

// 请求订单
- (void)setupData
{
    KPOrderParam *param = [KPOrderParam param];
    param.state = @25;
    
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool orderWithParam:param Success:^(id result) {
        
        
        if (CODE != 0) { WHYNSLog(@"-------订单列表获取失败%@", result[@"message"]); return; }
        
        if (weakSelf.rowDatas.count != 0) {
            [weakSelf.rowDatas removeAllObjects];
        }
        
        weakSelf.rowDatas = [KPOrder mj_objectArrayWithKeyValuesArray:result[@"data"][@"orderList"]];
        
        // 如果无订单，则提示用户无可现实的内容
        weakSelf.withoutAnythingView.hidden = weakSelf.rowDatas.count != 0;
        [weakSelf.table reloadData];
        
    } failure:^(NSError *error) {  WHYNSLog(@"-------订单列表获取失败%@", error); }];
}

// 收货
- (void)receive:(NSNotification *)note
{
    KPOrder *order = (KPOrder *)note.object;
    
    __weak typeof (self) weakSelf = self;
    if (order.orderState.integerValue == 30) {
        [KPAlertController alertControllerWithTitle:@"请收到货以后再确定收货，确认以后无法更改！" cancelTitle:@"取消" defaultTitle:@"确定" handler:^(UIAlertAction *action) {
            
            KPconfirmReceiptParam *param = [KPconfirmReceiptParam param];
            param.orderSn = order.orderSn;
            
            [KPNetworkingTool receiveOrder:param Success:^(id result) {
                
//                NSLog(@"%@", result);
                if (CODE == 0) {
                    
                    WHYNSLog(@"--------确认收货-----");
                    
                    [KPProgressHUD showSuccessWithStatus:@"确认收货成功" completion:^{
                        
                        [weakSelf setupData];
                        
                        NSPostNote(Noti_RefreshOrders, nil)
                        
                    } ];
                }  else  {
                    [KPProgressHUD showErrorWithStatus:@"确认收货失败，请稍后重试"];
                }
                
            } failure:^(NSError *error) {
                [KPProgressHUD showErrorWithStatus:@"确认失败，请稍后重试"];
            }];
        }];
    }
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
