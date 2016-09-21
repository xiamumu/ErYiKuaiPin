//
//  KPAddressListViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAddressListViewController.h"
#import "KPAddressListViewModel.h"
#import "KPAddressManageViewController.h"

#import "KPSeparatorSectionFooterView.h"
#import "KPSeparatorSectionHeaderView.h"
#import "KPBottomButton.h"

#import "KPGetReceiversParam.h"
#import "KPSetDefaultReceiverParam.h"
#import "KPDeleteReceiverParam.h"

#import <MJRefresh.h>

@interface KPAddressListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) KPBottomButton *addNewAddressBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) KPAddressListViewModel *viewModel;

@property (nonatomic, copy) id localData;

@end

@implementation KPAddressListViewController

#pragma mark - 点击事件
- (void)clickAddNewAddressButton {
    
    __weak typeof(self) weakSelf = self;
    KPAddressManageViewController *addressManageVC = [KPAddressManageViewController addressManageViewControllerWithType:KPAddressManageTypeAdd];
    [addressManageVC setNewCompletion:^() {
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    [self.navigationController pushViewController:addressManageVC animated:YES];
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [KPSeparatorSectionHeaderView headerViewWithTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [KPSeparatorSectionHeaderView headerViewHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [KPSeparatorSectionFooterView footerViewWithTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WHYNSLog(@"");

    __weak typeof(self) weakSelf = self;

    if (weakSelf.changeReceiverHandler) {
        weakSelf.changeReceiverHandler([weakSelf.viewModel getCellModelAtIndexPath:indexPath]);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }

}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupNavigationBar];
    [self setupNotification];
    
    __weak typeof(self) weakSelf = self;
    
    KPGetReceiversParam *param = [KPGetReceiversParam param];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [KPNetworkingTool getReceiversWithParam:param success:^(id result) {
            
            [weakSelf.tableView.mj_header endRefreshing];
            
            NSInteger code = [result[@"code"] integerValue];
            
            if (code != 0) {
                WHYNSLog(@"%zd -- %@",code, result[@"message"]);
                return;
            }
            
//            WHYNSLog(@"%@", result);
            weakSelf.localData = result[@"data"];
            
            weakSelf.viewModel.data = weakSelf.localData;
            [weakSelf.tableView reloadData];
            
        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
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

#pragma mark - 私有方法
- (void)setupNavigationBar {
    
    self.navigationItem.title = @"收货地址列表";
    
}

- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addNewAddressBtn];
    
    __weak typeof(self) weakSelf = self;
    CGFloat addNewAddressH = 50;
    CGFloat leftRight = 9;
    CGFloat bottom = 10;
    [self.addNewAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(leftRight);
        make.right.mas_equalTo(weakSelf.view).offset(-leftRight);
        make.bottom.mas_equalTo(weakSelf.view).offset(-bottom);
        make.height.mas_equalTo(addNewAddressH);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.addNewAddressBtn.mas_top).offset(-bottom);
    }];
    
}

- (void)setupNotification {
    
    NSAddObserver(changeDefaultAddress:, Noti_AddressManagerClickDefaultAddressButton)
    NSAddObserver(editAddress:, Noti_AddressManagerClickEditButton)
    NSAddObserver(deleteAddress:, Noti_AddressManagerClickDeleteButton)
    NSAddObserver(reloadData:, Noti_AddressListVcReloadData)
}

- (void)changeDefaultAddress:(NSNotification *)noti {
    
    KPSetDefaultReceiverParam *param = [KPSetDefaultReceiverParam param];
    param.receiverId = noti.userInfo[ReceiverIdKey];
    
    __weak typeof(self) weakSelf = self;
    [KPNetworkingTool setDefaultReceiverWithParam:param success:^(id result) {
       
        NSInteger code = [result[@"code"] integerValue];
        
        if (code != 0) {
            WHYNSLog(@"%zd -- %@",code, result[@"message"]);
            return;
        }
        
        [weakSelf.viewModel changedDefaultAddress:noti.object];
        [weakSelf.tableView reloadData];
        [KPProgressHUD showSuccessWithStatus:@"设置成功" completion:^{
            if (weakSelf.changeReceiverHandler) {
                weakSelf.changeReceiverHandler(noti.object);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
    }];
    
    
}

- (void)editAddress:(NSNotification *)noti {
    KPAddressManageViewController *addressManageVC = [KPAddressManageViewController addressManageViewControllerWithType:KPAddressManageTypeEdit];
    addressManageVC.addressModel = noti.object;
    
    __weak typeof(self) weakSelf = self;
    [addressManageVC setEditCompletion:^() {
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    
    [self.navigationController pushViewController:addressManageVC animated:YES];
}

- (void)deleteAddress:(NSNotification *)noti {
    
    KPDeleteReceiverParam *param = [KPDeleteReceiverParam param];
    param.receiverId = noti.userInfo[ReceiverIdKey];

    BOOL isDefaultReceiver = [self.viewModel checkDefaultReceiverWithId:param.receiverId];

    if (isDefaultReceiver) {
        [KPProgressHUD showErrorWithStatus:@"不允许删除默认地址，请更改后再删除"];
        return;
    }

    __weak typeof(self) weakSelf = self;

    [KPAlertController alertControllerWithTitle:@"删除地址会影响您收货" message:@"您真的要删除么？" cancelTitle:@"取消" defaultTitle:@"删除" handler:^(UIAlertAction *action) {

        [KPNetworkingTool deleteReceiverWithParam:param success:^(id result) {

            NSInteger code = [result[@"code"] integerValue];

            if (code != 0) {
                WHYNSLog(@"%zd -- %@", code, result[@"message"]);
                return;
            }

            [weakSelf.tableView.mj_header beginRefreshing];

        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
        }];

    }];

}

- (void)reloadData:(NSNotification *)noti {
    if (!noti.object) {
        self.viewModel.data = self.localData;
        [self.tableView reloadData];
    }
}

#pragma mark - 懒加载
- (KPBottomButton *)addNewAddressBtn {
    if (_addNewAddressBtn == nil) {

        _addNewAddressBtn = [KPBottomButton bottomButtonWithTitle:@"新建地址"
                                                          imgName:@"jia_white"
                                                           target:self
                                                           action:@selector(clickAddNewAddressButton)];
        _addNewAddressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0);
    }
    return _addNewAddressBtn;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ViewBgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return _tableView;
}

- (KPAddressListViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [KPAddressListViewModel sharedViewModel];
    }
    return _viewModel;
}

@end
