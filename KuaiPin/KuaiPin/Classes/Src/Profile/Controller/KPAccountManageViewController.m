//
//  KPAccountManageTableViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAccountManageViewController.h"
#import "KPAddressListViewController.h"
#import "KPAccountSafeViewController.h"
#import "KPAccountSafeTableViewCell.h"
#import "KPChangeUsernameViewController.h"
#import "KPLoginRegisterViewController.h"
#import "KPFeedbackViewController.h"
#import "KPActivityWebViewController.h"
#import "KPAccountRowData.h"

#define CellHeight 57
#define HeaderFooderHeight 10
@interface KPAccountManageViewController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *rowDatas;
@property (nonatomic, weak) UIImagePickerController *picker;

@end

@implementation KPAccountManageViewController

#pragma mark - 懒加载
- (NSMutableArray *)rowDatas
{
    if (_rowDatas == nil) {
        _rowDatas = [NSMutableArray array];
        NSArray *titles = @[@"头像", @"昵称", @"地址管理", @"账户安全", @"常见问题", @"意见反馈", @"当前版本"];
        for (int i = 0; i < titles.count ; i++) {
            KPAccountRowData *rowData = [[KPAccountRowData alloc] init];
            rowData.titleText = titles[i];
            [_rowDatas addObject:rowData];
        }
    }
    return _rowDatas;
}

#pragma mark - 私有方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户管理";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:table];
    
    KPButton *logoutBtn = [[KPButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, CellHeight)];
    logoutBtn.backgroundColor = WhiteColor;
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = UIFont_20;
    [logoutBtn addTarget:self action:@selector(logoutBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    table.tableFooterView = logoutBtn;
    if (!IsLogin) {
        table.tableFooterView = nil;
    }
    
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    self.picker = picker;
    if (buttonIndex == actionSheet.cancelButtonIndex) {
    }
    else if (buttonIndex == 0)
    { // 从相册选择
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    { // 调取相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *iconImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSPostNote(Noti_ChangeUserIconImage, iconImage)
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
    if (indexPath.row == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选取", @"相机拍照", nil];
        [actionSheet showInView:self.view];
    }
    else if (indexPath.row == 1) {
        KPChangeUsernameViewController *changeUsername = [[KPChangeUsernameViewController alloc] init];
        [self.navigationController pushViewController:changeUsername animated:YES];
        
    }
    else if (indexPath.row == 2) {
        KPAddressListViewController *addressList = [[KPAddressListViewController alloc] init];
        addressList.title = @"地址管理";
        [self.navigationController pushViewController:addressList animated:YES];
    }
    else if (indexPath.row == 3) {
        KPAccountSafeViewController *safeVc = [[KPAccountSafeViewController alloc] init];
        [self.navigationController pushViewController:safeVc animated:YES];
    }
    else if (indexPath.row == 4) {
        WHYNSLog(@"常见问题");
        KPActivityWebViewController *webVc = [KPActivityWebViewController new];
        webVc.urlStr = @"http://21kp.21my.com/qa.html";
        webVc.title = @"常见问题";
        [self.navigationController pushViewController:webVc animated:YES];
    }
    else if (indexPath.row == 5) {
        KPFeedbackViewController *feedBack = [[KPFeedbackViewController alloc] init];
        feedBack.title = @"意见反馈";
        [self.navigationController pushViewController:feedBack animated:YES];
    }
    else if (indexPath.row == 6) {
        NSString *message = [NSString stringWithFormat:@"当前版本号为：%@", [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey]];
        [KPAlertController alertControllerWithTitle:@"提示" message:message defaultTitle:@"确定"];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeaderFooderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return HeaderFooderHeight;
}

// 退出点击事件
- (void)logoutBtnAction:(KPButton *)logoutBtn
{
    WHYNSLog(@"退出登录");
    if (self.isLogout) {
        self.isLogout();
    }
    [KPUserManager removeUser];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)willDealloc
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    self.picker = nil;
    return NO;
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