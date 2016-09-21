//
//  KPFootTraceViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPFootTraceViewController.h"
#import "KPGoodsDetailViewController.h"
#import "UIBarButtonItem+XM.h"
#import "KPFootTraceCell.h"
#import "KPCollectGoodsParam.h"
#import "KPDatabase.h"
#import "KPProduct.h"
#import "KPAlertController.h"

@interface KPFootTraceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation KPFootTraceViewController
    
#pragma mark - 懒加载
- (NSMutableArray *)products
{
    if (_products == nil) {
        _products = [NSMutableArray arrayWithArray:[[KPDatabase sharedDatabase] selectAllProduct]];
    }
    return _products;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

#pragma mark - setupUI
- (void)setupTableView
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    table.showsVerticalScrollIndicator = NO;
    table.rowHeight = 100;
    [self.view addSubview:table];
    self.table = table;
}

- (void)setupNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"清空"
                                                                 titleColor:BlackColor
                                                            hightLightColor:OrangeColor
                                                                      targe:self
                                                                     action:@selector(rightBtnAction)];;
}

- (void)rightBtnAction
{
    __weak typeof (self) weakSelf = self;
    [KPAlertController alertControllerWithTitle:@"您确定要删除浏览足迹么？" cancelTitle:@"取消" defaultTitle:@"确定" handler:^(UIAlertAction *action) {
        [weakSelf.products removeAllObjects];
        // 删除数据库中所有数据
        [[KPDatabase sharedDatabase] deleteAllProduct];
        [weakSelf.table reloadData];
    }];
    
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPFootTraceCell *cell = [KPFootTraceCell cellWithTable:tableView];
    cell.goodsDetailResult = self.products[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
// 自定义左滑显示编辑按钮
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof (self) weakSelf = self;
    UITableViewRowAction *deleteBtn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        KPProduct *product = self.products[indexPath.row];
        [[KPDatabase sharedDatabase] deleteWithProductId:product.productId];
        
        [weakSelf.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView reloadData];
        
    }];
    deleteBtn.backgroundColor = OrangeColor;
    return @[deleteBtn];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KPProduct *product = self.products[indexPath.row];
    
    KPGoodsDetailViewController *goodsDetailVc = [[KPGoodsDetailViewController alloc] init];
    goodsDetailVc.product = product;
    [self.navigationController pushViewController:goodsDetailVc animated:YES];
}

// 滑动删除一行
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
