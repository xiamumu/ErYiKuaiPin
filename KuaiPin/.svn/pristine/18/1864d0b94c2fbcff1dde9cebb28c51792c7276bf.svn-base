//
//  KPHomeViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/25.
//  Copyright © 2016年 21_xm. All rights reserved.
//

// controller
#import "KPHomeViewController.h"
#import "KPGoodsListViewController.h"
#import "KPBrandViewController.h"
#import "KPMessageViewController.h"
#import "KPShopViewController.h"
#import "KPGoodsDetailViewController.h"
#import "KPActivityWebViewController.h"
#import "KPLoginRegisterViewController.h"
#import "KPNavigationController.h"

// other
#import "UIBarButtonItem+XM.h"
#import "UINavigationBar+XM.h"
#import <SDCycleScrollView.h>
#import "KPNewVersionTool.h"

// view
#import "XMSearchBar.h"
#import "KPMessageButton.h"
#import "KPCommonNavigationBar.h"
#import "KPSubImageView.h"
#import "KPHomeFirstModule.h"
#import "KPHomeSecondModule.h"
#import "KPHomeThirdModule.h"


// model
#import "KPHomeData.h"
#import "KPBanner.h"
#import "KPProduct.h"
#import "KPBrand.h"
#import "KPHomeDefaultView.h"
#import "KPHomeBrandView.h"
#import "KPHomeGoodsView.h"
#import "KPHomeModuleChannelData.h"






@interface KPHomeViewController ()<UIScrollViewDelegate, SDCycleScrollViewDelegate>

// 里面装着KPHomeRowFrame模型
@property (nonatomic, strong) KPHomeData *homeData;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) KPHomeFirstModule  *boutiqueView;         // 精品甄选
@property (nonatomic, weak) KPHomeSecondModule *homeLivingView;       // 家居生活
@property (nonatomic, weak) KPHomeSecondModule *foodieView;           // 吃货福利
@property (nonatomic, weak) KPHomeSecondModule *skinCareView;         // 个人护肤
@property (nonatomic, weak) KPHomeSecondModule *numeralsView;         // 数码配件

@property (nonatomic, weak) KPCommonNavigationBar *commonNavigationBar;
@property (nonatomic, weak) SDCycleScrollView *bannerView;
@property (nonatomic, weak) KPButton *topBtn;

@end

@implementation KPHomeViewController
- (KPHomeData *)homeData
{
    if (_homeData == nil) {
        _homeData = [[KPHomeData alloc] init];
    }
    return _homeData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加TableView
    [self setupUI];
    
    // 添加额外按钮
    [self setupTopBtn];
    
    // 添加NavigationBar
    [self setupNavigationBar];
    
    // 添加监听
    [self setupNotification];
    
    // 添加数据
    [self setupData];
    
    // 获取新版本提示
    [KPNewVersionTool getNewVersion];
}

#pragma mark - 添加数据
- (void)setupData
{
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool homeData:^(id result) {
        
        if (CODE == 0) {
            
            weakSelf.homeData = [KPHomeData mj_objectWithKeyValues:result[@"data"]];
            
            // 设置banner数据
            [weakSelf setupBannerData];
            
            // 设置精选数据
            [weakSelf setupBoutiqueData];
            
            // 设置家居生活数据
            [weakSelf setupHomeLivingData];
            
            // 设置吃货福利数据
            [weakSelf setupFoodieData];
            
            // 设置个护化妆数据
            [weakSelf setupSkinCareData];
            
            // 设置数码配件数据
            [weakSelf setupNumeralsData];
            
        }
        else { WHYNSLog(@"请求数据失败%@",result[@"message"]);  }
        
    } failure:^(NSError *error) { WHYNSLog(@"请求数据失败%@",error); }];

}
// 设置banner数据
- (void)setupBannerData
{
    // 设置banner滚动图片
    NSMutableArray *bannerImages = [NSMutableArray array];

    for (KPBanner *banner in self.homeData.bannerList) {
        [bannerImages addObject:banner.image];
    }
    
    self.bannerView.imageURLStringsGroup = bannerImages;
}
// 设置精选数据
- (void)setupBoutiqueData
{
    self.boutiqueView.title = self.homeData.selection.type;
    self.boutiqueView.productList = self.homeData.selection.dataList;
}
// 设置家居生活数据
- (void)setupHomeLivingData
{
    self.homeLivingView.title = self.homeData.firstChannel.type;
    self.homeLivingView.productList = self.homeData.firstList;
    self.homeLivingView.scrollImages = self.homeData.firstChannel.dataList;
}
// 设置吃货福利数据
- (void)setupFoodieData
{
    self.foodieView.title = self.homeData.secondChannel.type;
    self.foodieView.productList = self.homeData.secondList;
    self.foodieView.scrollImages = self.homeData.secondChannel.dataList;
}
// 设置个人护肤数据
- (void)setupSkinCareData
{
    self.skinCareView.title = self.homeData.thirdChannel.type;
    self.skinCareView.productList = self.homeData.thirdList;
    self.skinCareView.scrollImages = self.homeData.thirdChannel.dataList;
}

// 设置数码配件数据
- (void)setupNumeralsData
{
    self.numeralsView.title = self.homeData.fourthChannel.type;
    self.numeralsView.productList = self.homeData.fourthList;
    self.numeralsView.scrollImages = self.homeData.fourthChannel.dataList;
    
}

#pragma mark - 添加监听事件
- (void)setupNotification
{
    // 查看更多的点击事件
    NSAddObserver(checkMoreGoodsAction:, Noti_CellMoreBtnAction)
    // 查看商品详情跳转
    NSAddObserver(checkGoodsDetailAction:, Noti_CheckGoodsDetailAction)
    // 查看商品详情跳转
    NSAddObserver(commonScorllViewDidSelected:, Noti_CommonScorllViewDidSelected)

}

// 查看商品详情跳转
- (void)commonScorllViewDidSelected:(NSNotification *)note
{
    
    KPSubImageView * subImageView = note.object;
    if ([subImageView.iden isEqualToString:@"product"]) {
        KPGoodsDetailViewController *goodsDetail = [[KPGoodsDetailViewController alloc] init];
        goodsDetail.product = subImageView.product;
        [self.navigationController pushViewController:goodsDetail animated:YES];

    }
    else if ([subImageView.iden isEqualToString:@"brand"])
    {
        KPShopViewController *shopVc = [[KPShopViewController alloc] init];
        shopVc.brand = subImageView.brand;
        [self.navigationController pushViewController:shopVc animated:YES];
    }
}
// 商品详情跳转
- (void)checkGoodsDetailAction:(NSNotification *)note
{
    UIView *commonView = note.object;
    
    if ([commonView isKindOfClass:[KPHomeDefaultView class]])
    {
        KPHomeDefaultView *defaultView = (KPHomeDefaultView *)commonView;
        KPGoodsDetailViewController *goodsDetail = [[KPGoodsDetailViewController alloc] init];
        goodsDetail.product = defaultView.product;
        [self.navigationController pushViewController:goodsDetail animated:YES];
    }
    else if ([commonView isKindOfClass:[KPHomeGoodsView class]])
    {
        KPHomeGoodsView *goodsView = (KPHomeGoodsView *)commonView;
        KPGoodsDetailViewController *goodsDetail = [[KPGoodsDetailViewController alloc] init];
        goodsDetail.product = goodsView.product;
        [self.navigationController pushViewController:goodsDetail animated:YES];
        
    }
    else if ([commonView isKindOfClass:[KPHomeBrandView class]])
    {
        KPHomeBrandView *brandView = (KPHomeBrandView *)commonView;
        KPShopViewController *shopVc = [[KPShopViewController alloc] init];
        shopVc.brand = brandView.brand;
        [self.navigationController pushViewController:shopVc animated:YES];
    }
}
// 查看更多的点击事件
- (void)checkMoreGoodsAction:(NSNotification *)note
{
    if ([note.object isEqualToString:@"股东特权"]) {
        KPBrandViewController *brandVc = [[KPBrandViewController alloc] init];
        brandVc.title = note.object;
        [self.navigationController pushViewController:brandVc animated:YES];
        return;
    }
    else
    {
        KPGoodsListViewController *goodsListVc = [[KPGoodsListViewController alloc] init];
        goodsListVc.title = note.object;
        [self.navigationController pushViewController:goodsListVc animated:YES];
    }
}
// 搜索商品
- (void)seacrchGoodsAction:(NSNotification *)note {

    if (!note.object) return;

    KPGoodsListViewController *goodsListVc = [KPGoodsListViewController new];
    goodsListVc.keyword = note.object;
    [self.navigationController pushViewController:goodsListVc animated:YES];

}
#pragma mark - 添加NavigationBar
- (void)setupNavigationBar
{
    
    __weak typeof (self) weakSelf = self;
    KPCommonNavigationBar *commonNavigationBar = [KPCommonNavigationBar navigationBar];
    commonNavigationBar.navigationBarType = KPCommonNavigationBarTypeHome;
    commonNavigationBar.searchBar.placeholder = @"搜索商品名";
    commonNavigationBar.messageBtnAction = ^{
        
        if (!IsLogin) {
            KPLoginRegisterViewController *loginVc = [[KPLoginRegisterViewController alloc] init];
            KPNavigationController *nav = [[KPNavigationController alloc] initWithRootViewController:loginVc];
            [weakSelf presentViewController:nav animated:YES completion:nil];
        }
        else
        {
            KPMessageViewController *messageVc = [KPMessageViewController sharedMessageViewController];
            [weakSelf.navigationController pushViewController:messageVc animated:YES];
        }
    };
    [self.view addSubview:commonNavigationBar];
    self.commonNavigationBar = commonNavigationBar;
    [commonNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(64);
    }];
    [commonNavigationBar setBarBackgroundColorWithColor:ClearColor];
}

#pragma mark - TableView
- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refeshHeaderAction)];
    
    // 1、创建bannerView
    SDCycleScrollView *bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, ScaleHeight(194)) delegate:self placeholderImage:nil];
    bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    bannerView.currentPageDotColor = OrangeColor;
    [scrollView addSubview:bannerView];
    self.bannerView = bannerView;
    
    // 精品甄选
    KPHomeFirstModule *boutiqueView = [[KPHomeFirstModule alloc] init];
    boutiqueView.frame = CGRectMake(0, CGRectGetMaxY(bannerView.frame), SCREEN_W, 35 + ScaleHeight(152));
    [scrollView addSubview:boutiqueView];
    self.boutiqueView = boutiqueView;
    
    CGFloat secondModule_H = iPhone5 ? ScaleHeight(280) : ScaleHeight(280) - 10;
    // 家居生活
    KPHomeSecondModule *homeLivingView = [[KPHomeSecondModule alloc] init];
    homeLivingView.frame = CGRectMake(0, CGRectGetMaxY(boutiqueView.frame), SCREEN_W, 35 + secondModule_H);
    [scrollView addSubview:homeLivingView];
    self.homeLivingView = homeLivingView;
    
    // 吃货福利
    KPHomeSecondModule *foodieView = [[KPHomeSecondModule alloc] init];
    foodieView.frame = CGRectMake(0, CGRectGetMaxY(homeLivingView.frame), SCREEN_W, 35 + secondModule_H);
    [scrollView addSubview:foodieView];
    self.foodieView = foodieView;
    
    // 个护化妆
    KPHomeSecondModule *skinCareView = [[KPHomeSecondModule alloc] init];
    skinCareView.frame = CGRectMake(0, CGRectGetMaxY(foodieView.frame), SCREEN_W, 35 + secondModule_H);
    [scrollView addSubview:skinCareView];
    self.skinCareView = skinCareView;
    
    // 数码配件
    KPHomeSecondModule *numeralsView = [[KPHomeSecondModule alloc] init];
    numeralsView.frame = CGRectMake(0, CGRectGetMaxY(skinCareView.frame), SCREEN_W, 35 + secondModule_H);
    [scrollView addSubview:numeralsView];
    self.numeralsView = numeralsView;
    
    
    // 股东特权
//    KPHomeThirdModule *thirdModule = [[KPHomeThirdModule alloc] init];
//    thirdModule.frame = CGRectMake(0, CGRectGetMaxY(secondModule.frame), SCREEN_W, 35 + ScaleHeight(125));
//    [scrollView addSubview:thirdModule];
//    self.thirdModule = thirdModule;

    scrollView.contentSize = CGSizeMake(SCREEN_W, CGRectGetMaxY(numeralsView.frame) + 2);
}

// 下拉刷新
- (void)refeshHeaderAction
{
    [self setupData];
    [self.scrollView.mj_header endRefreshing];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    KPBanner *banner = self.homeData.bannerList[index];
    
    if (banner.url.length > 0) {
        KPActivityWebViewController *webView = [[KPActivityWebViewController alloc] init];
        webView.urlStr = banner.url;
        webView.title = banner.top;
        webView.sharedTitle = banner.top;
        webView.sharedMessage = banner.content; 
        webView.sharedImgSrc = banner.shareSrc;
        webView.shareUrl = banner.shareUrl;
        webView.sharedImg = banner.icon;
        [self.navigationController pushViewController:webView animated:YES];
        
    }else if (banner.goodsId){
        
        KPGoodsDetailViewController *goodsDetail = [[KPGoodsDetailViewController alloc] init];
        KPProduct *product = [[KPProduct alloc] init];
        product.productId = banner.goodsId;
        goodsDetail.product = product;
        [self.navigationController pushViewController:goodsDetail animated:YES];
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
    [self.scrollView setContentOffset:CGPointZero animated:YES];
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
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self setupMessageCount];
    
    [self setupSubsidizeCount];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSRemoveObserverWithName(Noti_SearchGoods)
    // 不可以在这里添加显示navigationBar的代码 会影响商品详情的显示效果
//    self.navigationController.navigationBar.hidden = NO;
    
}
// 移除监听
- (void)dealloc
{
    NSRemoveObserver
}

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

@end
