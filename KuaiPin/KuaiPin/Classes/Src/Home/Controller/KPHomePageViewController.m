//
//  KPHomePageViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/9/1.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "KPHomePageViewController.h"
#import "KPHomePageHeaderView.h"
#import "KPHomePageTableViewCell.h"
#import "KPCommonNavigationBar.h"
#import "KPNavigationController.h"
#import "KPLoginRegisterViewController.h"
#import "KPMessageViewController.h"
#import "KPGoodsListViewController.h"
#import "KPGoodsDetailViewController.h"
#import "KPBrandViewController.h"
#import "KPHomeData.h"
#import "KPBanner.h"
#import "KPActivityWebViewController.h"
#import "KPInviteViewController.h"
#import "KPBrand.h"
#import "KPActivityBanner.h"

@interface KPHomePageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) KPHomePageHeaderView *headerView;

@property (nonatomic, strong) KPHomeData *homeData;

@property (nonatomic, weak) KPButton *topBtn;

@property (nonatomic, weak) KPCommonNavigationBar *commonNavigationBar;


@end

@implementation KPHomePageViewController

- (KPHomeData *)homeData
{
    if (_homeData == nil) {
        _homeData = [[KPHomeData alloc] init];
    }
    return _homeData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTable];

    // 添加NavigationBar
    [self setupNavigationBar];
    
    // 添加额外按钮
    [self setupTopBtn];
    
    // 数据请求
    [self setupHomeData];
    
    
}

- (void)setupHomeData
{
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool homeData:^(id result) {
        
        if (CODE == 0) {
            weakSelf.homeData = [KPHomeData mj_objectWithKeyValues:result[@"data"]];
            weakSelf.headerView.bannerImages = weakSelf.homeData.bannerList;
            weakSelf.headerView.activityBannerList = weakSelf.homeData.activityBannerList;
            
            [self.tableView reloadData];
            
        }
        else { WHYNSLog(@"请求数据失败%@",result[@"message"]);  }
        
    } failure:^(NSError *error) { WHYNSLog(@"请求数据失败%@",error); }];
    
}

- (void)setupTable
{
    self.fd_prefersNavigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = BaseColor;
//    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = ScaleHeight(210);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refeshHeaderAction)];
    
    KPHomePageHeaderView *headerView = [KPHomePageHeaderView new];
    headerView.frame = CGRectMake(0, 0, SCREEN_W, ScaleHeight(379));
    tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    __weak typeof (self) weakSelf = self;
    // 顶部滚动图点击事件
    [headerView setDidSelectCycleScrollViewItem:^(NSInteger index) {
        
        KPBanner *banner = weakSelf.homeData.bannerList[index];
        
        // 如果是活动就跳到活动页面
        if (banner.url.length > 0) {
            KPActivityWebViewController *webView = [[KPActivityWebViewController alloc] init];
            webView.urlStr = banner.url;
            webView.title = banner.top;
            webView.sharedTitle = banner.top;
            webView.sharedMessage = banner.content;
            webView.sharedImgSrc = banner.shareSrc;
            webView.shareUrl = banner.shareUrl;
            webView.sharedImg = banner.icon;
            [weakSelf.navigationController pushViewController:webView animated:YES];
            
            // 统计banner上每个活动被点击的次数
            [KPStatisticsTool event:@"banner_activity_id" label:banner.top];
            
        }else if (banner.goodsId){
            
            KPGoodsDetailViewController *goodsDetail = [[KPGoodsDetailViewController alloc] init];
            KPProduct *product = [[KPProduct alloc] init];
            product.productId = banner.goodsId;
            goodsDetail.product = product;
            [weakSelf.navigationController pushViewController:goodsDetail animated:YES];
            
            // 统计每个banner上的商品被点击的次数
            NSString *label = [NSString stringWithFormat:@"banner上面商品id_%@", banner.goodsId];
            [KPStatisticsTool event:@"banner_product_id" label:label];
        }
        
    }];
    
    // 左边的二一时间点击事件
    [headerView setLeftItemAciton:^(UIButton *erYiTimeItem) {
        KPActivityBanner *activity;
        for (KPActivityBanner *activityBanner in self.homeData.activityBannerList) {
            if (activityBanner.sort.integerValue == 1) {
                activity = activityBanner;
            }
        }
        KPActivityWebViewController *webView = [[KPActivityWebViewController alloc] init];
        webView.urlStr = activity.activityUrl;
        webView.shareUrl = activity.shareUrl;
        webView.sharedImg = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:activity.activitySrc];
        webView.title = activity.activityName;
        [weakSelf.navigationController pushViewController:webView animated:YES];
        
        // 统计二一时间被点击次数
        [KPStatisticsTool event:@"erYiTime_id"];

    }];
    
    // 右边上面的邀请有奖点击事件
    [headerView setRightTopItemAciton:^(UIButton *invitationItem){
        
        KPInviteViewController *invite = [KPInviteViewController new];
        [weakSelf.navigationController pushViewController:invite animated:YES];
        
    }];
    
    // 右边下面的新手特权点击事件
    [headerView setRightBottomItemAciton:^(UIButton *noviceItem){
        KPActivityBanner *activity;
        for (KPActivityBanner *activityBanner in weakSelf.homeData.activityBannerList) {
            if (activityBanner.sort.integerValue == 3) {
                activity = activityBanner;
            }
        }
        KPActivityWebViewController *webView = [[KPActivityWebViewController alloc] init];
        webView.urlStr = activity.activityUrl;
        webView.title = activity.activityName;
        webView.shareUrl = activity.shareUrl;
        webView.sharedImg = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:activity.activitySrc];
        [weakSelf.navigationController pushViewController:webView animated:YES];
        
        // 统计新手特权被点击次数
        [KPStatisticsTool event:@"novice_id"];
        
    }];
}

#pragma mark - 刷新和上拉加载
- (void)refeshHeaderAction
{
    [self setupHomeData];
    [self.tableView.mj_header endRefreshing];
}
#pragma mark - 添加NavigationBar
- (void)setupNavigationBar
{
    __weak typeof (self) weakSelf = self;
    KPCommonNavigationBar *commonNavigationBar = [KPCommonNavigationBar navigationBar];
    commonNavigationBar.navigationBarType = KPCommonNavigationBarTypeHome;
    commonNavigationBar.searchBar.placeholder = @"搜索商品名";
    commonNavigationBar.messageBtnAction = ^{
        
        [weakSelf jumpToMessageController];
    };
    [self.view addSubview:commonNavigationBar];
    self.commonNavigationBar = commonNavigationBar;
    [commonNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(64);
    }];
    [commonNavigationBar setBarBackgroundColorWithColor:ClearColor];
}

- (void)jumpToMessageController
{
    if (!IsLogin) {
        KPLoginRegisterViewController *loginVc = [[KPLoginRegisterViewController alloc] init];
        KPNavigationController *nav = [[KPNavigationController alloc] initWithRootViewController:loginVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        KPMessageViewController *messageVc = [KPMessageViewController sharedMessageViewController];
        [self.navigationController pushViewController:messageVc animated:YES];
    }
}
// 添加回滚按钮
- (void)setupTopBtn
{
    // 添加滚回按钮
    KPButton *topBtn = [[KPButton alloc] init];
    [topBtn setBackgroundImage:[UIImage imageNamed:@"backtotop"] forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(scrolToTop:) forControlEvents:UIControlEventTouchDown];
    topBtn.hidden = YES;
    [self.view addSubview:topBtn];
    self.topBtn = topBtn;
    
    __weak typeof (self.view) weakSelf = self.view;
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.bottom.mas_equalTo(weakSelf).offset(- CommonMargin - 49);
        make.size.mas_equalTo(topBtn.currentBackgroundImage.size);
    }];
}
// 点击回滚
- (void)scrolToTop:(KPButton *)topBtn
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

// 设置导航栏显示与否
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![self.navigationController.topViewController isEqual:self]) return;
    
    CGFloat y = scrollView.contentOffset.y;
    CGFloat alpha = y/200;
    CGFloat max = 0.95;
    alpha = (alpha >= max)?max:alpha;
    // 改变视图控制器的背景颜色
    [self.commonNavigationBar setBarBackgroundColorWithColor:[HexColor(#f8f8f8) colorWithAlphaComponent:alpha]];
    
    BOOL isHidden = (y < 0);
    self.commonNavigationBar.searchBar.hidden = isHidden;
    self.commonNavigationBar.leftBtn.hidden = isHidden;
    self.commonNavigationBar.messageBtn.hidden = isHidden;
    // 修改messageBtn的背景图片
    if (y > 100) {
        [self.commonNavigationBar.messageBtn setImage:[UIImage imageNamed:@"message-dark"] forState:UIControlStateNormal];
    }
    else
    {
        [self.commonNavigationBar.messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    }
    
    // 设置回滚按钮的显示与否
    if (y > SCREEN_H * 0.5) {
        self.topBtn.hidden = NO;
    }
    else
    {
        self.topBtn.hidden = YES;
    }
}

- (void)setupMessageCount
{
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool GetProfileData:^(id result) {
        
        if (CODE != 0) return;
        NSNumber *message = result[@"data"][@"messageNum"];
        if (message.integerValue == 0) {
            weakSelf.commonNavigationBar.messageBtn.badgeValue = @"0";
        }
        else
        {
            weakSelf.commonNavigationBar.messageBtn.badgeValue = @"1";
        }
    } failure:^(NSError *error) {
        weakSelf.commonNavigationBar.messageBtn.badgeValue = @"0";
    }];
}

#pragma mark - View生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 搜索商品
    NSAddObserver(seacrchGoodsAction:, Noti_SearchGoods)
    
//    NSAddObserver(JPUSHAction:, Noti_JPUSHService)
    
    
    [self setupMessageCount];
    
    [self setupSubsidizeCount];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSRemoveObserverWithName(Noti_SearchGoods)
}
// 移除监听
- (void)dealloc
{
    NSRemoveObserver
}

// 搜索商品
- (void)seacrchGoodsAction:(NSNotification *)note {
    
    if (!note.object) return;
    
    KPGoodsListViewController *goodsListVc = [KPGoodsListViewController new];
    goodsListVc.keyword = note.object;
    [self.navigationController pushViewController:goodsListVc animated:YES];
    
}

// 极光推送事件
//- (void)JPUSHAction:(NSNotification *)noti
//{
//    NSDictionary *alert = noti.object;
//    WHYNSLog(@"---------JPUSHAction alert:%@-----", alert);
//    [self jumpToMessageController];
//}
#pragma mark - 获取购物车商品数量
- (void)setupSubsidizeCount
{
    [KPNetworkingTool getCarItemCountSuccess:^(id result) {
        
        if (CODE != 0) return;
        
        UIViewController *tabBarVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *vc = tabBarVc.childViewControllers[3];
        NSString *bageValue = [NSString stringWithFormat:@"%@", result[@"data"][@"cartItemCount"]];
        
        if ([bageValue isEqualToString:@"0"]) {
            vc.tabBarItem.badgeValue = nil;
        } else {
            vc.tabBarItem.badgeValue = bageValue;
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.homeData.brandList.count == 0 ? 10 : self.homeData.brandList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPHomePageTableViewCell *cell = [KPHomePageTableViewCell cellWithTable:tableView];
    cell.brand = self.homeData.brandList[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CommonMargin;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [UIView new];
    sectionHeaderView.backgroundColor = BaseColor;
    return sectionHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPBrand *brand = self.homeData.brandList[indexPath.section];
    
    KPBrandViewController *shopVc = [[KPBrandViewController alloc] init];
    shopVc.brand = brand;
    shopVc.isRecommend = 1;
    [self.navigationController pushViewController:shopVc animated:YES];
}
@end
