//
//  KPRootPayBackViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPRootPayBackViewController.h"
#import "KPPayBackCell.h"

@interface KPRootPayBackViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation KPRootPayBackViewController


- (KPWithoutAnythingView *)withoutAnythingView
{
    if (_withoutAnythingView == nil) {
        KPWithoutAnythingView *withoutView = [[KPWithoutAnythingView alloc] init];
        withoutView.frame = CGRectMake(0, 0, SCREEN_W, 300);
        withoutView.message = @"对不起，没有可显示的消费资产订单";
        [self.view addSubview:withoutView];
        _withoutAnythingView = withoutView;
    }
    return _withoutAnythingView;
}

- (NSMutableArray *)payBackOrders
{
    if (_payBackOrders == nil) {
        _payBackOrders = [NSMutableArray array];
    }
    return _payBackOrders;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    [self setupUI];
}

- (void)setupUI
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsHorizontalScrollIndicator = NO;
    table.showsVerticalScrollIndicator = NO;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.rowHeight = 89;
    table.backgroundColor = ClearColor;
    [self.view addSubview:table];
    self.table = table;
    
    table.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64 - 40);
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.payBackOrders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPPayBackCell *cell = [KPPayBackCell cellWithTable:tableView];
    cell.payBackOrder = self.payBackOrders[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CommonMargin;
}


@end
