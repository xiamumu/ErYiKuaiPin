//
//  KPTakeBackMoneyViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPTakeBackMoneyViewController.h"
#import "KPTakeBackMoneyCell.h"
#import "KPTakeBackMoneyHeaderView.h"
#import "KPTakeBackMoneyFooterView.h"
#import "KPAuthenticationController.h"
#import "KPSecretCodeView.h"
#import "KPBankCardModel.h"

@interface KPTakeBackMoneyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSMutableArray *bandCards;
@property (nonatomic, weak) KPSecretCodeView *secretVodeView;
@property (nonatomic, weak) KPTakeBackMoneyHeaderView *headerView;
@property (nonatomic, weak) KPButton *submit;

@end

@implementation KPTakeBackMoneyViewController

#pragma mark - 懒加载
- (NSMutableArray *)bandCards
{
    if (_bandCards == nil) {
        _bandCards = [NSMutableArray array];
    }
    return _bandCards;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    
    [self setupTableView];
    
    // 添加监听
    [self setupNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
    
    __weak typeof(self) weakSelf = self;
        
        [KPNetworkingTool bankCardListSuccess:^(id result) {
            
            NSInteger code = [result[@"code"] integerValue];
            
            if (code != 0) {
                WHYNSLog(@"%zd -- %@",code, result[@"message"]);
                return;
            }
            
            weakSelf.bandCards = [KPBankCardModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"cards"]];
            [weakSelf.table reloadData];
            
        } failure:^(NSError *error) {
            WHYNSLog(@"----------------%@", error);
        }];
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

#pragma mark - setupUI
- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 49) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    table.rowHeight = 50;
    [self.view addSubview:table];
    self.table = table;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [table addGestureRecognizer:gestureRecognizer];
    
    
    KPTakeBackMoneyHeaderView *headerView = [[KPTakeBackMoneyHeaderView alloc] init];
    headerView.width = SCREEN_W;
    headerView.height = 132;
    headerView.takeBackVc = self.takeBackVc;
    table.tableHeaderView = headerView;
    self.headerView = headerView;
    
    KPTakeBackMoneyFooterView *footerView = [[KPTakeBackMoneyFooterView alloc] init];
    footerView.width = SCREEN_W;
    footerView.height = 50 + 80 + 44 + CommonMargin;
    table.tableFooterView = footerView;
    
    
    KPButton *submit = [[KPButton alloc] init];
    [submit setTitle:@"确  定" forState:UIControlStateNormal];
    [submit setTitleColor:WhiteColor forState:UIControlStateNormal];
    submit.titleLabel.font = UIFont_20;
    submit.layer.cornerRadius = 5;
    submit.backgroundColor = OrangeColor;
    [submit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    self.submit = submit;
    
    
    __weak typeof (self) weakSelf = self;
    [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view).offset(-CommonMargin);
        make.left.mas_equalTo(weakSelf.view).offset(CommonMargin);
        make.right.mas_equalTo(weakSelf.view).offset(-CommonMargin);
        make.height.mas_equalTo(44);
    }];
}


- (void)hideKeyboard
{
    [self.headerView endEditing:YES];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bandCards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPTakeBackMoneyCell *cell = [KPTakeBackMoneyCell cellWithTable:tableView];
    cell.card = self.bandCards[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

#pragma mark - 监听通知
- (void)setupNotification
{
    // 添加银行卡
    NSAddObserver(plusBankCard, Noti_plusBankCard)
}

// 添加银行卡
- (void)plusBankCard
{
    KPAuthenticationController *authenticationVc = [[KPAuthenticationController alloc] init];
    authenticationVc.popToVC = self;
    [self.navigationController pushViewController:authenticationVc animated:YES];
}
// 提交
- (void)submitAction
{
    KPSecretCodeView *secretVodeView = [[KPSecretCodeView alloc] initWithFrame:self.view.bounds];
    secretVodeView.takeBackVc = self.takeBackVc;
    __weak typeof (secretVodeView) weakSecretVodeView = secretVodeView;
    __weak typeof(self) weakSelf = self;
    [secretVodeView setCompletion:^{
        if (weakSelf.takeBackVc) {
            [KPProgressHUD showSuccessWithStatus:@"余额提现成功" completion:^{
                [weakSecretVodeView removeFromSuperview];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [KPProgressHUD showSuccessWithStatus:@"余额充值成功" completion:^{
                [weakSecretVodeView removeFromSuperview];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            
        }
        
    }];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:secretVodeView];
    self.secretVodeView = secretVodeView;
    
}
- (void)dealloc
{
    NSRemoveObserver
}

@end
