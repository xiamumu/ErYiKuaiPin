//
//  KPBankCardManageController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBankCardManageController.h"
#import "KPBottomButton.h"
#import "KPBankCardViewModel.h"
#import "KPAuthenticationController.h"
#import <MJRefresh.h>


@interface KPBankCardManageController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) KPBottomButton *addBtn;

@property (nonatomic, strong) KPBankCardViewModel *viewModel;

@property (nonatomic, assign) BOOL willRefresh;

@end

@implementation KPBankCardManageController

#pragma mark - 点击事件
- (void)clickAddButton {
    
    KPAuthenticationController *authVc = [KPAuthenticationController new];
    authVc.popToVC = self;
    [self.navigationController pushViewController:authVc animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel cellForRowAtIndexPath:indexPath tableView:tableView];
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.viewModel viewForHeaderInSection:section tableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.viewModel viewForFooterInSection:section tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.viewModel heightForFooterInSection:section];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"解绑"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
    {

        [KPAlertController alertControllerWithTitle:@"确定要解绑银行卡？" cancelTitle:@"取消" defaultTitle:@"解绑" handler:^(UIAlertAction *action) {

            NSInteger bankCardNumber = [weakSelf.viewModel deleteBankCardAtIndexPath:indexPath];

            [KPNetworkingTool bankCardDeleteWithNumber:bankCardNumber success:^(id result) {

                NSInteger code = [result[@"code"] integerValue];

                if (code != 0) {
                    WHYNSLog(@"%zd -- %@",code, result[@"message"]);
                    [KPProgressHUD showErrorWithStatus:@"解绑失败，请稍后重试"];
                    return;
                }

                [weakSelf.tableView.mj_header beginRefreshing];

            } failure:^(NSError *error) {
                WHYNSLog(@"%@", error);
            }];

        }];

        [weakSelf.tableView reloadData];
        
    }];
    
    deleteAction.backgroundColor = OrangeColor;
    
    return  @[deleteAction];
}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupUI];
    [self setupNotification];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [KPNetworkingTool bankCardListSuccess:^(id result) {
            
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.willRefresh = NO;
            
            NSInteger code = [result[@"code"] integerValue];
            
            if (code != 0) {
                WHYNSLog(@"%zd -- %@",code, result[@"message"]);
                return;
            }
            
            weakSelf.viewModel.data = result[@"data"][@"cards"];
            [weakSelf.tableView reloadData];
            
        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.willRefresh = NO;
        }];
        
    }];
    
//    [self.tableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    if (self.willRefresh) {
        [self.tableView.mj_header beginRefreshing];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

#pragma mark - 私有方法
- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addBtn];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat bottom = 10;
    CGFloat leftRight = 9;
    CGFloat addH = 45;
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(leftRight);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRight);
        make.bottom.mas_equalTo(weakSelf.view).offset(-bottom);
        make.height.mas_equalTo(addH);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.addBtn.mas_top);
    }];
    
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"银行卡";
}

- (void)setupNotification {
    NSAddObserver(refresh, Noti_RefreshBankCardList)
}

- (void)refresh {
    self.willRefresh = YES;
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = ViewBgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (KPBottomButton *)addBtn {
    if (_addBtn == nil) {
        _addBtn = [KPBottomButton bottomButtonWithTitle:@"添加银行卡" imgName:@"jia_white" target:self action:@selector(clickAddButton)];
        _addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    return _addBtn;
}

- (KPBankCardViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [KPBankCardViewModel sharedViewModel];
    }
    return _viewModel;
}







@end
