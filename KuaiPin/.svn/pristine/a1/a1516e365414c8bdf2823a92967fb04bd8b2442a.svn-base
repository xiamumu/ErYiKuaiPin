//
//  KPPayBackDetailViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayBackDetailViewController.h"
#import "KPPayBackDetailHeaderView.h"
#import "KPAssetsOrderDetailParam.h"
#import "KPPayBackOrder.h"
#import "KPOrderItem.h"
#import "KPAlertController.h"
#import "KPApplyForPayBackParam.h"
#import "KPPayBackDetailOrder.h"


@interface KPPayBackDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) KPPayBackOrder *orderDetail;

@property (nonatomic, weak) KPPayBackDetailHeaderView *headerView;

@property (nonatomic, weak) KPPayBackDetailOrder *detailOrderView;

@property (nonatomic, weak) KPButton *payBackBtn;

@end

@implementation KPPayBackDetailViewController

#pragma mark - 懒加载
- (KPPayBackOrder *)orderDetail
{
    if (_orderDetail == nil) {
        _orderDetail = [[KPPayBackOrder alloc] init];
    }
    return _orderDetail;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseColor;
    self.title = @"贴现详情";
    
    // 设置UI
    [self setupUI];
    
    // 请求数据
    [self setupData];
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
    KPAssetsOrderDetailParam *param = [KPAssetsOrderDetailParam param];
    param.assetsSn = self.assetsSn;
    
    [KPNetworkingTool AssetsDetailWithParam:param success:^(id result) {
        
//        NSLog(@"%@", result);
        
        if (CODE != 0) return;
        
        weakSelf.orderDetail = [KPPayBackOrder mj_objectWithKeyValues:result[@"data"][@"assets"]];
    
        if (weakSelf.orderDetail.assetsState.integerValue == -1 || weakSelf.orderDetail.assetsState.integerValue == 0) {
            
             // 贴现时间未到的点击事件
            [weakSelf.payBackBtn addTarget:self action:@selector(canNotPayBackAction) forControlEvents:UIControlEventTouchUpInside];
            
        } else if (weakSelf.orderDetail.assetsState.integerValue == 1) {
            
            // 可申请贴现的点击事件
            [weakSelf.payBackBtn addTarget:self action:@selector(payBackAtinon) forControlEvents:UIControlEventTouchUpInside];
            
        } else if (weakSelf.orderDetail.assetsState.integerValue == 2) {
            
            // 待审核状态
            weakSelf.payBackBtn.backgroundColor = GrayColor;
            weakSelf.payBackBtn.enabled = YES;
            [weakSelf.payBackBtn setTitle:@"待审核" forState:UIControlStateNormal];
            
        } else if (weakSelf.orderDetail.assetsState.integerValue == 3) {
            // 已贴现的订单显示状态
            weakSelf.payBackBtn.hidden = YES;
        }

        weakSelf.payBackBtn.hidden = weakSelf.orderDetail.assetsState.integerValue == 3 ? YES : NO;
        
        // 设置资产详情显示情况
        
        
        CGFloat startH = 0.0;
        switch (weakSelf.orderDetail.assetsState.intValue) {
            case -1:
            case 0:
            case 1:
                startH = 430;
                break;
            case 2:
            case 3:
                startH = 285;
                break;
        }
        CGFloat height = iPhone5? ScaleHeight(startH) + CommonMargin: ScaleHeight(startH);
        weakSelf.headerView.frame = CGRectMake(0, 0, SCREEN_W, height);
        weakSelf.headerView.payBackOrderDetail = weakSelf.orderDetail;
        
        // 所属资产订单
        weakSelf.detailOrderView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.headerView.frame), SCREEN_W, 80);
        weakSelf.detailOrderView.payBackOrder = weakSelf.orderDetail;
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - setupUI
- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H - 49 - 64);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    KPPayBackDetailHeaderView *headerView = [[KPPayBackDetailHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREEN_W, ScaleHeight(460));
    [scrollView addSubview:headerView];
    self.headerView = headerView;
    
    KPPayBackDetailOrder *detailOrderView = [[KPPayBackDetailOrder alloc] init];
    [scrollView addSubview:detailOrderView];
    self.detailOrderView = detailOrderView;
    
    KPButton *payBackBtn = [[KPButton alloc] initWithFrame:CGRectMake(0, SCREEN_H - 49, SCREEN_W, 49)];
    payBackBtn.backgroundColor = OrangeColor;
    [payBackBtn setTitle:@"申请贴现" forState:UIControlStateNormal];
    payBackBtn.titleLabel.font = UIFont_18;
    [self.view addSubview:payBackBtn];
    self.payBackBtn = payBackBtn;
}

// 申请贴现点击事件
- (void)payBackAtinon
{
    KPApplyForPayBackParam *param = [KPApplyForPayBackParam param];
    param.orderSn = self.orderSn;
    param.productId = self.productId;
    
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool ApplyAssetsWithParam:param success:^(id result) {
        
//                NSLog(@"-=-=-=-=-=-=-=-=%@", result);
        if (CODE == 0) {
            
            NSString *message = @"您的资产已申请成功，我们会在两个工作日内转入您的余额。逾期未到，请联系客服。";
            
            [KPAlertController alertControllerWithTitle:@"提交结果" message:message cancelTitle:nil defaultTitle:@"确定" handler:^(UIAlertAction *action) {
                
                weakSelf.payBackBtn.backgroundColor = GrayColor;
                weakSelf.payBackBtn.enabled = YES;
                [weakSelf.payBackBtn setTitle:@"待审核" forState:UIControlStateNormal];
                
                NSPostNote(Noti_RefreshOrders, nil)
                
                [weakSelf setupData];
            }];
        }
    } failure:^(NSError *error) { }];
}

// 不可提现时的提示框
- (void)canNotPayBackAction
{
    [KPAlertController alertControllerWithTitle:@"提示" message:@"您的资产未到贴现时间" defaultTitle:@"确定"];
}


@end
