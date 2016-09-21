//
//  KPFootTraceViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGoodsCollectionViewController.h"
#import "KPGoodsDetailViewController.h"
#import "KPGoodsCollectionCell.h"
#import "UIBarButtonItem+XM.h"
#import "KPCollectGoodsParam.h"
#import "KPGoodsDetailResult.h"
#import "KPCollectionProductsListParam.h"
#import "KPProduct.h"
#import "KPGoodsListViewController.h"

@interface KPGoodsCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation KPGoodsCollectionViewController

#pragma mark - 懒加载
- (NSMutableArray *)products
{
    if (_products == nil) {
        _products = [NSMutableArray array];
    }
    return _products;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupNavigationBar];
    
    [self setupData];
    
    NSAddObserver(CheckOthersAtion:, Noti_CheckOthers)
}

// 点击查看更多跳转到所属一级分类
- (void)CheckOthersAtion:(NSNotification *)note
{
    NSDictionary *dict = note.userInfo;
    KPGoodsListViewController *goodsListVc = [[KPGoodsListViewController alloc] init];
    goodsListVc.pcId = dict[PcIdKey];
    goodsListVc.title = dict[PcIdNameKey];
    [self.navigationController pushViewController:goodsListVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

- (void)setupData
{
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool GetProductsCollectionListSuccess:^(id result) {
        
        if (CODE != 0) return;
        
        if (weakSelf.products.count != 0) {
            [weakSelf.products removeAllObjects];
        }
        
        weakSelf.products = [KPProduct mj_objectArrayWithKeyValuesArray:result[@"data"][@"productCollectionList"]];
        [weakSelf.table reloadData];
        
    } failure:^(NSError *error) {
        
    }];
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
    
    __weak typeof (self) weakSelf = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setupData];
        [weakSelf.table.mj_header endRefreshing];
    }];
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
    [KPAlertController alertControllerWithTitle:@"是否删除所有收藏的商品？" cancelTitle:@"取消" defaultTitle:@"确定" handler:^(UIAlertAction *action) {
        
        KPCollectionProductsListParam *param = [KPCollectionProductsListParam param];
        
        NSMutableArray *idsArr = [NSMutableArray array];
        for (KPProduct *product in weakSelf.products) {
            [idsArr addObject:product.brandId];
        }
        param.ids = [idsArr componentsJoinedByString:@","];
        
        [KPNetworkingTool CancelAllProductsCollection:param Success:^(id result) {
            
            if (CODE != 0) return;
            
            [weakSelf.products removeAllObjects];
            [weakSelf.table reloadData];
            
        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
        }];
    }];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.navigationItem.rightBarButtonItem.enabled = (self.products.count != 0);
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPGoodsCollectionCell *cell = [KPGoodsCollectionCell cellWithTable:tableView];
    cell.product = self.products[indexPath.row];
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
        
        KPProduct *product = weakSelf.products[indexPath.row];
        
        KPCollectGoodsParam *param = [[KPCollectGoodsParam alloc] init];
        param.productId = product.productId;
        [KPNetworkingTool CollectProduct:param Success:^(id result) {
            
            if (CODE != 0) { [KPProgressHUD showErrorWithStatus:@"取消关注失败,请重新尝试"]; return; }
            
            [KPProgressHUD showSuccessWithStatus:@"取消关注成功"];
            
            [weakSelf.products removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView reloadData];
            
        } failure:^(NSError *error) {
            [KPProgressHUD showErrorWithStatus:@"取消关注失败,请重新尝试"];
            
        }];
        
    }];
    deleteBtn.backgroundColor = OrangeColor;
    return @[deleteBtn];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KPGoodsDetailResult *goodsDetailResult = self.products[indexPath.row];
    
    KPProduct *product = [[KPProduct alloc] init];
    product.productId = goodsDetailResult.productId;
    product.storeId = goodsDetailResult.storeId;
    
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
