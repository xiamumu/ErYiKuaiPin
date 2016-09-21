//
//  KPAdvancedPayBackDetailViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/9/1.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAdvancedPayBackDetailViewController.h"
#import "KPAdvancedPayBackDetailHeadView.h"
#import "KPPayBackDetailOrder.h"
#import "KPCommonMarginView.h"
#import "KPAssetsOrderDetailParam.h"
#import "KPSharedTool.h"


@interface KPAdvancedPayBackDetailViewController ()

@property (nonatomic, strong) KPPayBackOrder *orderDetail;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) KPAdvancedPayBackDetailHeadView *headView;

@property (nonatomic, strong) KPCommonMarginView *marginView;

@property (nonatomic, strong) KPPayBackDetailOrder *detailOrderView;

@property (nonatomic, strong) KPButton *doneBtn;

@end

@implementation KPAdvancedPayBackDetailViewController

#pragma mark - 点击事件
- (void)clickDoneButton {


    UIImage *shareImg = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:self.orderDetail.productImage];
    NSString *shareUrl = [NSString stringWithFormat:@"%@?username=%@&assetsSn=%@", self.orderDetail.shareUrl,
                                                                                  [KPUserManager sharedUserManager].userModel.username,
                                                                                  self.assetsSn];

    [KPSharedTool sharedWithMessage:self.orderDetail.productName
                              title:@""
                             urlStr:shareUrl
                              image:shareImg
                           imageSrc:nil
                 fromViewController:self];

}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"提前支配详情";

    [self setupUI];

    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
- (void)loadData {

    __weak typeof (self) weakSelf = self;
    KPAssetsOrderDetailParam *param = [KPAssetsOrderDetailParam param];
    param.assetsSn = self.assetsSn;

    [KPNetworkingTool AssetsDetailWithParam:param success:^(id result) {

//        NSLog(@"%@", result);

        if (CODE != 0) return;

        weakSelf.orderDetail = [KPPayBackOrder mj_objectWithKeyValues:result[@"data"][@"assets"]];

        weakSelf.detailOrderView.payBackOrder = weakSelf.orderDetail;
        weakSelf.detailOrderView.orderNumStr = weakSelf.orderSn;
        weakSelf.headView.price = weakSelf.orderDetail.productPrice;
        weakSelf.headView.advancedDay = weakSelf.orderDetail.day;
        weakSelf.headView.advancedHour = weakSelf.orderDetail.hour;

    } failure:^(NSError *error) {
        
    }];

}

- (void)setupUI {

    self.view.backgroundColor = ViewBgColor;

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headView];
    [self.scrollView addSubview:self.marginView];
    [self.scrollView addSubview:self.detailOrderView];
    [self.view addSubview:self.doneBtn];

    __weak typeof(self) weakSelf = self;

    CGFloat headTop = 10;
    CGFloat headW = SCREEN_W;
    CGFloat headH = SCREEN_H / 4;
    CGFloat marginH = 35;
    CGFloat orderH = 100;
    CGFloat doneH = 49;

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];

    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.scrollView).offset(headTop);
        make.left.mas_equalTo(weakSelf.scrollView);
        make.width.mas_equalTo(headW);
        make.height.mas_equalTo(headH);
    }];

    [self.marginView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headView.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.scrollView);
        make.height.mas_equalTo(marginH);
    }];

    [self.detailOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.marginView.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.scrollView);
        make.height.mas_equalTo(orderH);
    }];

    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(doneH);
    }];

}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}

- (KPAdvancedPayBackDetailHeadView *)headView {
    if (_headView == nil) {
        _headView = [KPAdvancedPayBackDetailHeadView new];
    }
    return _headView;
}

- (KPCommonMarginView *)marginView {
    if (_marginView == nil) {
        _marginView = [KPCommonMarginView new];
        _marginView.backgroundColor = ClearColor;
        _marginView.title = @"对应订单";
        _marginView.headerImageName = @"title_bg";
    }
    return _marginView;
}

- (KPPayBackDetailOrder *)detailOrderView {
    if (_detailOrderView == nil) {
        _detailOrderView = [KPPayBackDetailOrder new];
    }
    return _detailOrderView;
}

- (KPButton *)doneBtn {
    if (_doneBtn == nil) {
        _doneBtn = [KPButton new];
        _doneBtn.backgroundColor = OrangeColor;
        [_doneBtn setTitle:@"确认选择本资产" forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = UIFont_18;
        [_doneBtn addTarget:self action:@selector(clickDoneButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}




@end
