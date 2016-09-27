//
//  KPBeLeftMoneyViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBeLeftMoneyViewController.h"
#import "KPBeLeftMoneyCell.h"
#import "KPBeLeftMoneyHeaderView.h"
#import "KPBeLeftMoneyRowData.h"
#import "KPTakeBackMoneyViewController.h"
#import "KPNetworkingTool.h"
#import "KPBalanceResult.h"
#import "KPCommonMarginView.h"

@interface KPBeLeftMoneyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *table;

@property (nonatomic, weak) KPBeLeftMoneyHeaderView *headerView;

@property (nonatomic, weak) KPCommonMarginView *marginView;

@property (nonatomic, strong) KPBalanceResult *balanceResult;

@end

@implementation KPBeLeftMoneyViewController

#pragma mark - 懒加载

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加tableView
    [self setupTableView];
    
    // 添加tableView
    [self setupData];
    
    // 添加通知
    [self setupNotification];
    
}
#pragma mark - setupUI
- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat top = Absolute_Y ? 0 : 64;
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, top, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    table.rowHeight = 50;
    [self.view addSubview:table];
    self.table = table;
    
    
    CGFloat height = SCREEN_W > 360? 200 - CommonMargin : 200;
    KPBeLeftMoneyHeaderView *headerView = [[KPBeLeftMoneyHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREEN_W, height);
    table.tableHeaderView = headerView;
    self.headerView = headerView;
    
}

#pragma mark - 请求数据
- (void)setupData
{
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool BalanceQueryWithWater:@"y" success:^(id result) {
        
        WHYNSLog(@"%@", result);
        weakSelf.balanceResult = [KPBalanceResult mj_objectWithKeyValues:result[@"data"]];
        
        weakSelf.headerView.balance = weakSelf.balanceResult.balance;
        
        [weakSelf.table reloadData];
    } failure:^(NSError *error) { }];
    
}

#pragma mark - 接收通知及事件
- (void)setupNotification
{
    // 提现
    NSAddObserver(takeBackMoney, Noti_TakeBackMoney)
    // 充值
//    NSAddObserver(fillInMoney, Noti_FillInMoney)
}

- (void)takeBackMoney
{
    KPTakeBackMoneyViewController *takeBackVc = [[KPTakeBackMoneyViewController alloc] init];
    takeBackVc.title = @"余额提现";
    takeBackVc.takeBackVc = YES;
    [self.navigationController pushViewController:takeBackVc animated:YES];
}

- (void)fillInMoney
{
    KPTakeBackMoneyViewController *takeBackVc = [[KPTakeBackMoneyViewController alloc] init];
    takeBackVc.title = @"余额充值";
    takeBackVc.takeBackVc = NO;
    [self.navigationController pushViewController:takeBackVc animated:YES];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.balanceResult.water.count;
//    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPBeLeftMoneyCell *cell = [KPBeLeftMoneyCell cellWithTable:tableView];
    cell.fundsFlow = self.balanceResult.water[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KPCommonMarginView *marginView = [[KPCommonMarginView alloc] init];
    marginView.title = @"余额明细";
    return marginView;
}



//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.001;
//}

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
