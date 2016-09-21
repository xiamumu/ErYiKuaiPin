//
//  KPRoorOrderViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/8.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPRootOrderViewController.h"
#import "KPOrderCell.h"
#import "KPOrder.h"
#import "KPOrderItem.h"
#import "KPOrderDetailViewController.h"


@interface KPRootOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation KPRootOrderViewController

- (KPWithoutAnythingView *)withoutAnythingView
{
    if (_withoutAnythingView == nil) {
        KPWithoutAnythingView *withoutView = [[KPWithoutAnythingView alloc] init];
        withoutView.frame = CGRectMake(0, 0, SCREEN_W, 300);
        withoutView.message = @"对不起，没有可显示的订单";
        [self.view addSubview:withoutView];
        _withoutAnythingView = withoutView;
    }
    return _withoutAnythingView;
}
- (NSMutableArray *)rowDatas
{
    if (_rowDatas == nil) {
        _rowDatas = [NSMutableArray array];
    }
    return _rowDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    table.rowHeight = 119;
    table.backgroundColor = ClearColor;
    [self.view addSubview:table];
    self.table = table;
    
    table.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64 - 40);
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rowDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPOrderCell *cell = [KPOrderCell cellWithTable:tableView];
    cell.order = self.rowDatas[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CommonMargin;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPOrder *order = self.rowDatas[indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KPOrderDetailViewController *orderDetailVc = [KPOrderDetailViewController new];
    orderDetailVc.orderSn = order.orderSn;
    [self.navigationController pushViewController:orderDetailVc animated:YES];
    
}
@end
