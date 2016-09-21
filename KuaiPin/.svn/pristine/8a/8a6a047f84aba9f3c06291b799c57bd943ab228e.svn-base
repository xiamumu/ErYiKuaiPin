//
//  KPAccountSafeViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAccountSafeViewController.h"
#import "KPAccountSafeTableViewCell.h"
#import "KPNewPayPwdViewController.h"
#import "KPChangePwdViewController.h"
#import "KPChangePhoneViewController.h"

#import "KPAccountRowData.h"

@interface KPAccountSafeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *rowDatas;

@end

@implementation KPAccountSafeViewController

- (NSMutableArray *)rowDatas
{
    if (_rowDatas == nil) {
        _rowDatas = [NSMutableArray array];
        NSArray *titleTexts = @[@"修改登录密码", @"修改手机验证", @"支付密码"];
        NSArray *detailTexts = @[@"", [KPUserManager sharedUserManager].userModel.mobile.phoneSecurityString, @""];
//        test
//        NSArray *detailTexts = @[@"", @"15632137573", @""];
        for (int i = 0; i < titleTexts.count ; i++) {
            KPAccountRowData *rowData = [[KPAccountRowData alloc] init];
            rowData.titleText = titleTexts[i];
            rowData.detailText = detailTexts[i];
            [_rowDatas addObject:rowData];
        }
    }
    return _rowDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户安全";
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 添加TableView
    [self setupTableView];
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
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:table];
    
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPAccountSafeTableViewCell *cell = [KPAccountSafeTableViewCell cellWithTable:tableView];
    cell.rowData = self.rowDatas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KPAccountRowData *rowData = self.rowDatas[indexPath.row];
    if (indexPath.row == 0) {
        KPChangePwdViewController *pwdVc = [[KPChangePwdViewController alloc] init];
        pwdVc.title = rowData.titleText;
        __weak typeof(pwdVc) weakPwdVc = pwdVc;
        [self.navigationController pushViewController:weakPwdVc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        KPChangePhoneViewController *phoneNumVc = [[KPChangePhoneViewController alloc] init];
        phoneNumVc.title = rowData.titleText;
        [self.navigationController pushViewController:phoneNumVc animated:YES];
        
    }
    else if (indexPath.row == 2)
    {
        KPNewPayPwdViewController *payPwdVc = [[KPNewPayPwdViewController alloc] init];
        payPwdVc.needOldPayPwd = YES;
        [self.navigationController pushViewController:payPwdVc animated:YES];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
@end
