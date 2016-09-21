//
//  KPLikeBrandViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPLikeBrandViewController.h"
#import "KPLikeBrandCell.h"
#import "KPBrandViewController.h"
#import "UINavigationBar+XM.h"
#import "UIBarButtonItem+XM.h"
#import "KPAlertController.h"
#import "KPCollectStoreParam.h"
#import "KPCollectionStoreListParam.h"
#import "KPBrand.h"

@interface KPLikeBrandViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSMutableArray *brands;
@end

@implementation KPLikeBrandViewController

- (NSMutableArray *)brands
{
    if (_brands == nil) {
        _brands = [NSMutableArray array];
    }
    return _brands;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加table
    [self setupTable];
    
    // 设置setupData
    [self setupData];
    
    // 设置NavigationBar
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

- (void)setupData
{
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool GetStoresCollectionListSuccess:^(id result) {
        
        if (CODE != 0) return;
        
        if (weakSelf.brands.count != 0) {
            [weakSelf.brands removeAllObjects];
        }
        
        weakSelf.brands = [KPBrand mj_objectArrayWithKeyValuesArray:result[@"data"][@"brandCollectionList"]];
        
        [weakSelf.table reloadData];
        
    } failure:nil];
}
- (void)setupNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"清空" titleColor:BlackColor hightLightColor:OrangeColor targe:self action:@selector(rightBtnAction)];;
}

- (void)setupTable
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.separatorStyle = UITableViewCellAccessoryNone;
    table.tableFooterView = [[UIView alloc] init];
    table.backgroundColor = ViewBgColor;
    table.rowHeight = 80;
    [self.view addSubview:table];
    self.table = table;
    
    __weak typeof (self) weakSelf = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setupData];
        [weakSelf.table.mj_header endRefreshing];
    }];
    
}

- (void)rightBtnAction
{
    __weak typeof (self) weakSelf = self;
    [KPAlertController alertControllerWithTitle:@"是否删除所有收藏的店铺？" cancelTitle:@"取消" defaultTitle:@"确定" handler:^(UIAlertAction *action) {
        
        KPCollectionStoreListParam *param = [KPCollectionStoreListParam param];
        
        NSMutableArray *idsArr = [NSMutableArray array];
        for (KPBrand *brand in weakSelf.brands) {
            [idsArr addObject:brand.brandId];
        }
        param.ids = [idsArr componentsJoinedByString:@","];
        
        [KPNetworkingTool CancelAllStoreCollectionList:param Success:^(id result) {
            
            if (CODE != 0) return;

            if ([result[@"data"][@"msg"] isEqualToString:@"true"]) {
                [weakSelf.brands removeAllObjects];
                [weakSelf.table reloadData];
            }
            
        } failure:nil];
    }];
}
#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.navigationItem.rightBarButtonItem.enabled = (self.brands.count != 0);
    return self.brands.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPLikeBrandCell *cell = [KPLikeBrandCell cellWithTable:tableView];
    cell.brand = self.brands[indexPath.row];
    return cell;
}

// 自定义左滑显示编辑按钮
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *deleteBtn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        KPBrand *brand = weakSelf.brands[indexPath.row];
        
        KPCollectStoreParam *param = [[KPCollectStoreParam alloc] init];
        param.storeId = brand.storeId;
        [KPNetworkingTool CollectStore:param Success:^(id result) {
            
            if (CODE != 0) { [KPProgressHUD showErrorWithStatus:@"取消关注失败,请重新尝试"]; return; }
            
            [KPProgressHUD showSuccessWithStatus:@"取消关注成功"];
            
            [weakSelf.brands removeObjectAtIndex:indexPath.section];
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
    
    KPBrand *brand = self.brands[indexPath.row];
    KPBrandViewController *shopVc = [[KPBrandViewController alloc] init];
    shopVc.brand = brand;
    [self.navigationController pushViewController:shopVc animated:YES];
}
@end
