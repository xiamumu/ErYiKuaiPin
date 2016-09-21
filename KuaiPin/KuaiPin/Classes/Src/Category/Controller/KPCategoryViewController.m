//
//  KPCategoryViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/25.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCategoryViewController.h"
#import "XMSearchBar.h"
#import "KPCategoryCell.h"
#import "KPSeparatorSectionFooterView.h"
#import "UINavigationBar+XM.h"
#import <MJRefresh.h>
#import "KPNavigationController.h"
#import "KPGoodsListViewController.h"
#import "KPCategoryModel.h"

@interface KPCategoryViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<KPCategoryModel *> *categorise;

@end

@implementation KPCategoryViewController

#pragma mark - 点击事件


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categorise.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KPCategoryCell *cell = [KPCategoryCell cellWithTableView:tableView];
    cell.model = self.categorise[indexPath.section];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KPGoodsListViewController *goodsListVc = [KPGoodsListViewController new];
    KPCategoryCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    goodsListVc.title = cell.categoryTitle;
    goodsListVc.pcId = self.categorise[indexPath.section].pcId;
    [self.navigationController pushViewController:goodsListVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [KPCategoryCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == self.categorise.count - 1) {
        return 10;
    }
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [KPSeparatorSectionFooterView footerViewWithTableView:tableView];
}


#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupNavigationBar];
    

            
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 改变视图控制器的背景颜色
//    [self.navigationController.navigationBar setBarBackgroundColorWithColor:HexColor(#f8f8f8)];
    self.navigationController.navigationBar.shadowImage = nil;
    KPStatisticsEndWithViewName(SelfClassStr)
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupNotification];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)

    if (self.categorise.count == 0) {

        __weak typeof(self) weakSelf = self;
        [KPNetworkingTool productCategoryWithSuccess:^(id result) {
//            WHYNSLog(@"%@", result);
            NSInteger code = [result[@"code"] integerValue];

            if (code != 0) {
                WHYNSLog(@"%zd -- %@", code, result[@"message"]);
                return;
            }

            weakSelf.categorise = [KPCategoryModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"categoryList"]];
            [weakSelf.tableView reloadData];

        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
        }];
        
    }

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSRemoveObserverWithName(Noti_SearchGoods)
}

#pragma mark - setup
- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
}

- (void)setupNavigationBar {
    
    XMSearchBar *searchBar = [XMSearchBar searchBar];
    searchBar.searchBarType = XMSearchBarTypeHome;
    searchBar.x = 9;
    searchBar.width = SCREEN_W - 20;
    searchBar.placeholder = @"搜索商品名";
    self.navigationItem.titleView = searchBar;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

#pragma mark - 添加监听事件
- (void)setupNotification {

    // 搜索商品
    NSAddObserver(seacrchGoodsAction:, Noti_SearchGoods)
}

// 搜索商品
- (void)seacrchGoodsAction:(NSNotification *)note {

    if (!note.object) return;

    KPGoodsListViewController *goodsListVc = [KPGoodsListViewController new];
    goodsListVc.keyword = note.object;
    [self.navigationController pushViewController:goodsListVc animated:YES];
    
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = ViewBgColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray<KPCategoryModel *> *)categorise {
    if (_categorise == nil) {
        _categorise = [NSArray array];
    }
    return _categorise;
}

@end
