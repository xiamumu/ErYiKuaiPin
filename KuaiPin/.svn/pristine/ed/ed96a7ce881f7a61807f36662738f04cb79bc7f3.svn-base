//
//  KPFinishPayBackViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPFinishPayBackViewController.h"
#import "KPOrderParam.h"
#import "KPPayBackOrder.h"
@interface KPFinishPayBackViewController ()

@end

@implementation KPFinishPayBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    
    __weak typeof (self) weakSelf = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNumber = 1;
        [weakSelf setupData];
        [weakSelf.table.mj_header endRefreshing];
    }];
    
    // 刷新订单
    NSAddObserver(refreshOrders, Noti_RefreshOrders)
}

#pragma mark - NSNotification
- (void)refreshOrders
{
    [self setupData];
}

- (void)setupData
{
    __weak typeof (self) weakSelf = self;
    
    KPPayBackOrderParam *param = [KPPayBackOrderParam param];
//    param.pageNumber = self.pageNumber;
    param.assetsState = 3;
    
    [KPNetworkingTool GetAssetsOrdersWithParam:param success:^(id result) {
        
//        NSLog(@"%@", result);
        
        if (CODE == 0) {
            
            if (weakSelf.payBackOrders.count != 0) {
                [weakSelf.payBackOrders removeAllObjects];
            }
            
            weakSelf.payBackOrders = [KPPayBackOrder mj_objectArrayWithKeyValuesArray:result[@"data"][@"assets"]];
    
            // 刷新表格
            [weakSelf.table reloadData];
            
        } else {  WHYNSLog(@"请求数据失败%@",result[@"message"]); }
        
        // 如果无订单，则提示用户无可现实的内容
        weakSelf.withoutAnythingView.hidden = weakSelf.payBackOrders.count != 0;
        
        if (weakSelf.payBackOrders.count == 0) {
            weakSelf.table.mj_header = nil;
        }
        
        
    } failure:^(NSError *error) { }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *assetsSn = self.payBackOrders[indexPath.section].assetsSn;
    NSString *orderSn = self.payBackOrders[indexPath.section].orderSn;
    NSString *productId = self.payBackOrders[indexPath.section].productId;
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"assetsSn"] = assetsSn;
    userInfo[@"orderSn"] = orderSn;
    userInfo[@"productId"] = productId;
    
    NSPostNoteWithUserInfo(Noti_PayBackOrderDetail, nil, userInfo)
    
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
