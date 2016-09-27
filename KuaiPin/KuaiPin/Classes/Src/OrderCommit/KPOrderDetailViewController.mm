//
//  KPOrderDetailViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderDetailViewController.h"
#import "KPOrderDetailViewModel.h"
#import "KPOrderDetaileBottomTool.h"
#import "KPOrderCommitCompletionViewController.h"
#import "KPOrderDetailParam.h"
#import "KPPayManager.h"
#import "KPOrderCommitViewController.h"
#import "KPOrder.h"
#import "KPOrderPayParam.h"
#import "UIBarButtonItem+XM.h"
#import "KPGetExpressInfoViewController.h"
#import "KPconfirmReceiptParam.h"
#import "KPBankCardPickerController.h"
#import "KPAuthenticationController.h"
#import "KPBalancePayParam.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "KPBalanceResult.h"
#import "KPPayPwdView.h"
#import "KPActivityWebViewController.h"
#import "KPNavigationController.h"



@interface KPOrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) KPOrderDetailViewModel *viewModel;

@property (nonatomic, strong) KPOrderDetaileBottomTool *bottomTool;

@property (nonatomic, copy) NSString *tn;

@property (nonatomic, assign) NSInteger paymentTag;

@property (nonatomic, weak) KPAlertController *payAlert;

@property (nonatomic, strong) KPBalanceResult *balanceResult;

@property (nonatomic, weak) KPPayPwdView *payPwdView;

@property (nonatomic, assign) BOOL willCheckJDPayCompletion;

@end

@implementation KPOrderDetailViewController

#pragma mark - 点击事件
- (void)closeVc {
    [self.navigationController popToViewController:self.popToSubsidizeVc animated:YES];
}

- (void)clickCommitButtonWithState:(NSNumber *)state {

    NSInteger stateInt = state.integerValue;

    __weak typeof (self) weakSelf = self;
    switch (stateInt) {
        case KPOrderStateUnPay:
        {

            switch (self.paymentTag) {
                case 0:
                case WexinPaymentTag:
                    [weakSelf weixinPay];
                    break;
                case BalancePaymentTag:
                    [weakSelf balancePay];
                    break;
                case BankCardPaymentTag:
                    [weakSelf upPay];
                    break;
                case AliPaymentTag:
                    [weakSelf aliPay];
                    break;
                case JDPaymentTag:
                    [weakSelf jdPay];
                    break;
                default:
                    break;
            }

        }
            break;
        case KPOrderStateUnSendOut:
        case KPOrderStateUnReceive:
        {
            KPOrder *order = [KPOrder mj_objectWithKeyValues:self.viewModel.orderDetail[@"order"]];
            NSInteger orderState = order.orderState.integerValue;

            if (orderState == KPOrderStateUnSendOut) {
                [KPProgressHUD showErrorWithStatus:@"你的订单还未发货，请不要确认收货"];
                return;
            }

            if (order.orderState.integerValue == 30) [weakSelf receiveOrder:order];

        }
            break;
        default:
            break;
    }

}

- (void)clickCancelButton {

    __weak typeof(self) weakSelf = self;


    [KPAlertController alertControllerWithTitle:@"您真的要取消支付吗？" cancelTitle:@"继续支付" defaultTitle:@"取消支付" handler:^(UIAlertAction *action) {

        KPOrderDetailParam *param = [KPOrderDetailParam new];
        param.orderSn = weakSelf.orderSn;


        [KPNetworkingTool orderCancelWithParam:param success:^(id result) {

            NSInteger code = [result[@"code"] integerValue];

            if (code != 0) {
                WHYNSLog(@"%zd -- %@", code, result[@"message"]);
                return;
            }

            NSPostNote(Noti_RefreshOrders, nil);

            [weakSelf popViewController];
            
        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
        }];

    }];


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
    return [self.viewModel viewForHeaderInSection:section tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.viewModel viewForFooterInSection:section tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.viewModel heightForFooterInSection:section];
}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupNavigationBar];

    NSAddObserver(changePayment:, Noti_ChangePayment)
    NSAddObserver(payTimeOut:, Noti_PayTimeOut)
    NSAddObserver(lookUpLogisticsInfo:, Noti_LookUpLogisticsInfo)
    NSAddObserver(checkJDPayCompletion:, Noti_CheckJDPayCompletion)

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    NSRemoveObserver
}

- (BOOL)willDealloc {

    [self.bottomTool removeFromSuperview];
    self.bottomTool = nil;
    self.viewModel.orderDetail = nil;

    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    KPOrderDetailParam *param = [KPOrderDetailParam param];
    param.orderSn = self.orderSn;

    __weak typeof(self) weakSelf = self;
    [KPNetworkingTool orderDetailWithParam:param success:^(id result) {

        NSInteger code = [result[@"code"] integerValue];

        if (code != 0) {
            WHYNSLog(@"%zd -- %@", code, result[@"message"]);
            return;
        }

        weakSelf.viewModel.orderDetail = result[@"data"];
        weakSelf.bottomTool.addTime = weakSelf.viewModel.orderAddTime;

        if (weakSelf.bottomTool.state.integerValue == KPOrderStateUnPay && ![weakSelf.bottomTool.state isEqual:weakSelf.viewModel.orderState]) {
            NSPostNote(Noti_RefreshOrders, nil);
        }

        weakSelf.bottomTool.state = weakSelf.viewModel.orderState;
        [weakSelf.tableView reloadData];

        weakSelf.paymentTag = weakSelf.viewModel.paymentTag;

    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
    }];

    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.popToSubsidizeVc) {
        self.fd_interactivePopDisabled = YES;
    }

    if (self.willCheckJDPayCompletion) {
        [self checkPayCompletionStateWithShowAlert:YES];
        self.willCheckJDPayCompletion = NO;
    }

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - 私有方法
- (void)setupUI {
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomTool];

    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.bottomTool.mas_top);
    }];

    [self.bottomTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo([KPOrderDetaileBottomTool orderDetailBottomToolHeight]);
    }];

}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"订单详情";

    if (self.popToSubsidizeVc) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"close"
                                                                     highImageName:nil
                                                                 selectedImageName:nil
                                                                             targe:self
                                                                            action:@selector(closeVc)];
    }

}

- (void)changePayment:(NSNotification *)noti {
    
    if (!noti.userInfo) return;
    
    self.paymentTag = [noti.userInfo[PaymentTagKey] integerValue];
    
}

- (void)payTimeOut:(NSNotification *)noti {
    [self popViewController];
}

- (void)lookUpLogisticsInfo:(NSNotification *)noti {

    if (!noti.object) return;

    WHYNSLog(@"查看物流信息");

    KPGetExpressInfoViewController *expressInfoVc = [KPGetExpressInfoViewController new];
    KPVendorModel *vendor = (KPVendorModel *)noti.object;
    expressInfoVc.expresssn = vendor.expressSn;
    expressInfoVc.expresscode = vendor.expressCode;
    
    [self.navigationController pushViewController:expressInfoVc animated:YES];

}

- (void)jdPay {
    __weak typeof (self) weakSelf = self;

    [KPPayManager jdPayWithOrderSn:weakSelf.orderSn totalPrice:weakSelf.viewModel.totalPrice completionHandler:^(NSString *resultStr) {

        if ([resultStr isEqualToString:@"fail"]) {
            [weakSelf payFailed];
            return;
        }

        KPActivityWebViewController *webVc = [KPActivityWebViewController new];
        webVc.html = resultStr;
        webVc.title = @"京东支付";
        webVc.hideSharedButton = YES;
        [weakSelf.navigationController pushViewController:webVc animated:YES];

    }];

}

- (void)balancePay {

    __weak typeof (self) weakSelf = self;

    [KPNetworkingTool BalanceQueryWithWater:nil success:^(id result) {
        
        weakSelf.balanceResult = [KPBalanceResult mj_objectWithKeyValues:result[@"data"]];
        
        if (weakSelf.balanceResult.balance.floatValue < weakSelf.viewModel.totalPrice.floatValue) {
            
            [KPAlertController alertControllerWithTitle:@"您的余额不足"
                                                message:@"请选择其他支付方式"
                                           defaultTitle:@"确定"];
            return;
            
        }

        [weakSelf.payPwdView setCompletion:^(NSString *password) {

            [KPPayManager balancePayWithOrderSn:weakSelf.orderSn
                                     totalPrice:weakSelf.viewModel.totalPrice
                                    payPassword:password
                              completionHandler:^(NSInteger code, NSString *paymentTime) {

                                  [weakSelf.payPwdView removeSelf];

                                  switch (code) {
                                      case 0:
                                      {
                                          KPOrderCommitCompletionViewController *completionVc = [KPOrderCommitCompletionViewController new];
                                          completionVc.orderDetail = weakSelf.viewModel.orderDetail;
                                          completionVc.popNav = weakSelf.navigationController;
                                          completionVc.payTime = paymentTime;
                                          [weakSelf.navigationController pushViewController:completionVc animated:YES];
                                          NSPostNote(Noti_RefreshOrders, nil)
                                      }
                                          break;
                                      case 20:
                                      {
                                          [KPAlertController alertControllerWithTitle:@"支付结果"
                                                                              message:@"支付密码错误，请重新填写"
                                                                          cancelTitle:@"取消"
                                                                         defaultTitle:@"确定"
                                                                              handler:^(UIAlertAction *action) {
                                                                                  [weakSelf balancePay];
                                                                              }];
                                      }
                                          break;
                                      case 90:
                                      {
                                          [KPProgressHUD showErrorWithStatus:@"订单已支付" completion:^{
                                              [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                                          }];
                                      }
                                          break;
                                      default:
                                          [weakSelf payFailed];
                                          break;
                                  }

                              }];

        }];

    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
    }];
}

- (void)weixinPay {

    __weak typeof(self) weakSelf = self;

    [KPPayManager weiPayWithOrderSn:weakSelf.orderSn
                         totalPrice:weakSelf.viewModel.totalPrice
                  completionHandler:^(NSString *resultStr) {

                      if ([resultStr isEqualToString:@"未安装微信"]) {
                          [KPAlertController alertControllerWithTitle:@"您还未安装微信，请安装微信后支付" message:nil defaultTitle:@"确定"];
                          return;
                      }

                      if (![resultStr isEqualToString:@""]) {
                          [weakSelf payFailed];
                          return;
                      }

                       [weakSelf presentViewController:weakSelf.payAlert animated:YES completion:nil];

                   }];

//#warning 处理支付跳转
    [KPPayManager weiPayCompletionHandler:^(int errCode) {

        [weakSelf.payAlert dismissViewControllerAnimated:NO completion:nil];

        switch (errCode) {
            case WXSuccess:
                [weakSelf checkPayCompletionStateWithShowAlert:YES];
                break;
            default:
            {
                [KPProgressHUD hideLoading];
                [weakSelf payFailed];
            }
                break;
        }

    }];

}

- (void)upPay {
    __weak typeof(self) weakSelf = self;

    [KPBankCardPickerController showBankCardPickerController];

    [[KPBankCardPickerController sharedController] setSelectedBankCardHnadler:^(NSNumber *bankCardNumber) {

        [KPPayManager upPayWithOrderSn:weakSelf.orderSn
                              totalFee:weakSelf.viewModel.totalPrice
                        bankCardNumber:bankCardNumber
                        viewController:weakSelf];

        [KPPayManager upPayCompleteBlock:^(NSString *resultStr) {
            if ([resultStr isEqualToString:@"success"]) {
                [weakSelf checkPayCompletionStateWithShowAlert:YES];
            }else {
                [weakSelf payFailed];
            }
        }];

    }];
//UICollectionView
    [[KPBankCardPickerController sharedController] setAddBankCardHandler:^{
        KPAuthenticationController *authVc = [KPAuthenticationController new];
        authVc.popToVC = weakSelf;
        [weakSelf.navigationController pushViewController:authVc animated:YES];
    }];


}

- (void)aliPay {

    __weak typeof(self) weakSelf = self;

    [KPProgressHUD showLoading];
    [KPPayManager aliPayOrder:weakSelf.orderSn
                     totalFee:weakSelf.viewModel.totalPrice
                   completion:^(BOOL success){

                       if (success) {
                           [KPProgressHUD hideLoading];
                           [weakSelf presentViewController:weakSelf.payAlert animated:YES completion:nil];
                       }else {
                           [weakSelf payFailed];
                       }

                   }];

    [KPPayManager aliPayOtherCallBack:^(NSDictionary *resultDic) {

        [weakSelf.payAlert dismissViewControllerAnimated:NO completion:nil];

        NSString *resultStatusStr = resultDic[@"resultStatus"];
        NSInteger resultStatus = resultStatusStr.integerValue;

        switch (resultStatus) {
            case 9000: //订单支付成功
            case 6004: //支付结果未知（有可能已经支付成功）
            case 8000: //订单正在处理，可能成功
                [weakSelf checkPayCompletionStateWithShowAlert:YES];
                break;
            default:   //支付失败
                [weakSelf payFailed];
                break;
        }
    }];

}

- (void)checkJDPayCompletion:(NSNotification *)noti {
    self.willCheckJDPayCompletion = YES;
}

- (void)checkPayCompletionStateWithShowAlert:(BOOL)showAlert {

    __weak typeof(self) weakSelf = self;

    KPOrderPayParam *param = [KPOrderPayParam param];
    param.orderSn = self.orderSn;

    [KPProgressHUD showLoading];

    switch (weakSelf.paymentTag) {
        case WexinPaymentTag:
        {
            [KPNetworkingTool checkWeiPayCompletionStateWithParam:param success:^(id result) {

                [weakSelf presentOrderCommitComletionVCWithResult:result showAlert:showAlert];

                [KPProgressHUD hideLoading];

            } failure:^(NSError *error) {
                WHYNSLog(@"%@", error);
//                [KPProgressHUD showErrorWithStatus:@"网络错误，请稍后刷新界面"];
                [KPProgressHUD hideLoading];
            }];
        }
            break;
        case AliPaymentTag:
        {
            [KPNetworkingTool checkAliPayCompletionStateWithParam:param success:^(id result) {

                [weakSelf presentOrderCommitComletionVCWithResult:result showAlert:showAlert];

                [KPProgressHUD hideLoading];

            } failure:^(NSError *error) {
                WHYNSLog(@"%@", error);
//                [KPProgressHUD showErrorWithStatus:@"网络错误，请稍后刷新界面"];
                [KPProgressHUD hideLoading];
            }];
        }
            break;
        case BankCardPaymentTag:
        {
            [KPNetworkingTool checkUpPayCompletionStateWithParam:param success:^(id result) {

                [weakSelf presentOrderCommitComletionVCWithResult:result showAlert:showAlert];

                [KPProgressHUD hideLoading];

            } failure:^(NSError *error) {
                WHYNSLog(@"%@", error);
//                [KPProgressHUD showErrorWithStatus:@"网络错误，请稍后刷新界面"];
                [KPProgressHUD hideLoading];
            }];
        }
            break;
        case JDPaymentTag:
        {
            [KPNetworkingTool checkJDPayCompletionStateWithParam:param success:^(id result) {

                [weakSelf presentOrderCommitComletionVCWithResult:result showAlert:showAlert];

                [KPProgressHUD hideLoading];

            } failure:^(NSError *error) {
                WHYNSLog(@"%@", error);
//                [KPProgressHUD showErrorWithStatus:@"网络错误，请稍后刷新界面"];
                [KPProgressHUD hideLoading];
            }];
        }
            break;
        default:
            break;
    }

}

- (void)presentOrderCommitComletionVCWithResult:(id)result showAlert:(BOOL)showAlert {

    __weak typeof(self) weakSelf = self;

    NSString *trade_state = result[@"trade_state"];
    NSRange range = [trade_state rangeOfString:@"SUCCESS" options:NSCaseInsensitiveSearch];
    if (!range.length) {
        if (showAlert) [KPProgressHUD showErrorWithStatus:@"支付失败，请重新支付"];
        return;
    }

    KPOrderCommitCompletionViewController *completionVc = [KPOrderCommitCompletionViewController new];
    completionVc.orderDetail = weakSelf.viewModel.orderDetail;
    completionVc.popNav = weakSelf.navigationController;
    completionVc.payTime = result[@"finishTime"];
    [weakSelf.navigationController pushViewController:completionVc animated:YES];

    NSPostNote(Noti_RefreshOrders, nil)
}

- (void)payFailed {
    [KPProgressHUD showErrorWithStatus:@"支付失败，请重新支付"];
}

- (void)popViewController {
    __weak typeof(self) weakSelf = self;

    if ([weakSelf isEqual:weakSelf.navigationController.viewControllers.firstObject]) {
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    }

    if (weakSelf.popToRootVc) {
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }
}

- (void)receiveOrder:(KPOrder *)order {

    __weak typeof(self) weakSelf = self;
    [KPAlertController alertControllerWithTitle:@"请收到货以后再确定收货，确认以后无法更改！" cancelTitle:@"取消" defaultTitle:@"确定" handler:^(UIAlertAction *action) {

        KPconfirmReceiptParam *param = [KPconfirmReceiptParam param];
        param.orderSn = order.orderSn;

        [KPNetworkingTool receiveOrder:param Success:^(id result) {

            if (CODE == 0) {

                WHYNSLog(@"--------确认收货-----");

                [KPProgressHUD showSuccessWithStatus:@"确认收货成功" completion:^{

                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    NSPostNote(Noti_RefreshOrders, nil)

                } ];
            }  else  {
                [KPProgressHUD showErrorWithStatus:@"确认收货失败，请稍后重试"];
            }

        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
            [KPProgressHUD showErrorWithStatus:@"确认收货失败，请稍后重试"];
        }];
    }];
}

//#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return NO;
//}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ViewBgColor;
    }
    return _tableView;
}

- (KPOrderDetailViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [KPOrderDetailViewModel sharedViewModel];
    }
    return _viewModel;
}

- (KPOrderDetaileBottomTool *)bottomTool {
    if (_bottomTool == nil) {
        __weak typeof(self) weakSelf = self;
        _bottomTool = [KPOrderDetaileBottomTool orderDetailBottomToolWithCommitHandler:^(NSNumber *state){
            [weakSelf clickCommitButtonWithState:state];
        }
                                                                         cancelHandler:^{
            [weakSelf clickCancelButton];
        }];

    }
    return _bottomTool;
}

- (KPAlertController *)payAlert {
    if (_payAlert == nil) {
        __weak typeof(self) weakSelf = self;
        _payAlert = [KPAlertController alertControllerWithTitle:@"正在支付"
                                                        message:nil
                                                 preferredStyle:UIAlertControllerStyleAlert];

        [_payAlert addAction:[UIAlertAction actionWithTitle:@"支付遇见问题"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [weakSelf checkPayCompletionStateWithShowAlert:NO];
                                                    }]];

        [_payAlert addAction:[UIAlertAction actionWithTitle:@"支付完成"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [weakSelf checkPayCompletionStateWithShowAlert:YES];
                                                    }]];
    }
    return _payAlert;
}


- (KPPayPwdView *)payPwdView
{
    if (_payPwdView == nil) {
        KPPayPwdView *payPwdView = [KPPayPwdView payPwdView];
        payPwdView.frame = self.view.bounds;
        payPwdView.totalPrice = [NSString stringWithFormat:@"%.2f", self.viewModel.totalPrice.floatValue];
        [[UIApplication sharedApplication].keyWindow addSubview:payPwdView];
        _payPwdView = payPwdView;
    }
    return _payPwdView;
}



@end
