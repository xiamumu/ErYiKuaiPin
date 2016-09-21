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

@interface KPBeLeftMoneyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *table;

@property (nonatomic, strong) NSMutableArray *rowDatas;

@property (nonatomic, weak) KPBeLeftMoneyHeaderView *headerView;

@property (nonatomic, strong) KPBalanceResult *balanceResult;

@end

@implementation KPBeLeftMoneyViewController

#pragma mark - 懒加载
- (NSMutableArray *)rowDatas
{
    if (_rowDatas == nil) {
        _rowDatas = [NSMutableArray array];
    }
    return _rowDatas;
}

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
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    table.rowHeight = 50;
    [self.view addSubview:table];
    self.table = table;
    
}

#pragma mark - 请求数据
- (void)setupData
{
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool BalanceQuerySuccess:^(id result) {
        
        
        weakSelf.balanceResult = [KPBalanceResult mj_objectWithKeyValues:result[@"data"]];
        
        
        weakSelf.headerView.balance = weakSelf.balanceResult.balance;
        
        
    } failure:^(NSError *error) {
        
    }];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPBeLeftMoneyCell *cell = [KPBeLeftMoneyCell cellWithTable:tableView];
    cell.rowData = self.rowDatas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = SCREEN_W > 360? 235 - CommonMargin : 235;
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KPBeLeftMoneyHeaderView *headerView = [[KPBeLeftMoneyHeaderView alloc] init];
    self.headerView = headerView;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
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
