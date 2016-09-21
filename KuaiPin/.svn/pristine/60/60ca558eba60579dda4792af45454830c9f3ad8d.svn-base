//
//  KPShopViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

// controller
#import "KPShopViewController.h"
#import "KPSubsidizeViewController.h"
#import "KPLoginRegisterViewController.h"
#import "KPGoodsDetailViewController.h"

// view
#import "KPShopHeaderView.h"
#import "KPSortBar.h"
#import "UIBarButtonItem+XM.h"
#import "KPShopTableViewCell.h"
#import "KPCommonItem.h"
#import "XMSearchBar.h"
#import "KPSubsidizeButton.h"

// model
#import "KPShopDetailParam.h"
#import "KPCollectStoreParam.h"
#import "KPShopDataResult.h"
#import "KPBrand.h"
#import "KPProduct.h"
#import "KPUpdateSubsidizeParam.h"
#import "KPGoodsListViewController.h"
#import "KPNavigationController.h"
#import "KPDIYFooterRefresh.h"
#import "KPGoodsListView.h"
#import "KPSharedTool.h"
#import "KPCollectionStoreListParam.h"

typedef enum : NSUInteger {
    KPSortTpyeByTimeDesc,       // 按时间降序
    KPSortTpyeByTimeAsc,        // 按时间升序
    KPSortTpyeByPriceDesc,      // 按价格降序
    KPSortTpyeByPriceAsc,       // 按价格升序
    KPSortTpyeBySalesDesc,      // 按销量降序
    KPSortTpyeByHotDesc,        // 按热度降序
} KPSortTpye;

@interface KPShopViewController ()<KPSortBarDelegate>

@property (nonatomic, weak) UITableView *table;

@property (nonatomic, weak) KPGoodsListView *goodsListView;

@property (nonatomic, strong) KPShopDataResult *shopData;

@property (nonatomic, weak) KPShopHeaderView *headerView;

@property (nonatomic, weak) KPSubsidizeButton *subsidizeBtn;

@property (nonatomic, weak) KPButton *topBtn;

@property (nonatomic, strong) NSMutableArray *products;

@property (nonatomic, weak) KPSortBar *sortBar;


/***  获取默认商品还是获取新上架商品 */
@property (nonatomic, assign) KPSortTpye sortType;

/***  加载商品的页码 */
@property (nonatomic, assign) NSUInteger pageNumber;

@end

@implementation KPShopViewController

+(instancetype)shopViewControllerWithStoreId:(NSNumber *)storeId {
    KPShopViewController *shopVc = [KPShopViewController new];
    shopVc.brand = [KPBrand new];
    shopVc.brand.storeId = storeId;
    return shopVc;
}

- (NSMutableArray *)products
{
    if (_products == nil) {
        _products = [NSMutableArray array];
    }
    return _products;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.brand.storeName;
    self.view.backgroundColor = WhiteColor;
    
    self.pageNumber = 1;
    
    // 添加table
    [self setupUI];
    
}

#pragma mark - setupNotification
- (void)setupNotification
{
    // 查看商品详情
    NSAddObserver(checkShopGoodsDetail:, Noti_CheckShopGoodsDetail)
    
    // 跳转到购物车
    NSAddObserver(jumpToSubsize, Noti_JumpToSubsidize)
}

// 跳到购物车
- (void)jumpToSubsize
{
    if (!IsLogin)
    {
        KPLoginRegisterViewController *logVc = [[KPLoginRegisterViewController alloc] init];
        KPNavigationController *nav = [[KPNavigationController alloc] initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        KPSubsidizeViewController *subSizeVc = [[KPSubsidizeViewController alloc] init];
        subSizeVc.title = @"G库";
        [self.navigationController pushViewController:subSizeVc animated:YES];
    }
}
// 查看商品详情
- (void)checkShopGoodsDetail:(NSNotification *)note
{
    KPProduct *product = (KPProduct *)note.object;
    KPGoodsDetailViewController *goodsDetailVc = [[KPGoodsDetailViewController alloc] init];
    goodsDetailVc.product = product;
    [self.navigationController pushViewController:goodsDetailVc animated:YES];
}
// 搜索商品
- (void)seacrchGoodsAction:(NSNotification *)note {

    if (!note.object) return;

    KPGoodsListViewController *goodsListVc = [KPGoodsListViewController new];
    goodsListVc.keyword = note.object;
//    goodsListVc.storeId = [NSString stringWithFormat:@"%@", self.brand.storeId];
    [self.navigationController pushViewController:goodsListVc animated:YES];
    
}


#pragma mark - 请求数据
/**
 *  默认时间排序
 */
- (void)setupDefaultData
{
    KPShopDetailParam *param = [KPShopDetailParam param];
    param.storeId = self.brand.brandId;
    param.pageNumber = self.pageNumber;
    param.sort = @"productAddtime";
    param.dir = @"desc";
    
    [self setupDataWithParam:param];
}


/**
 *  价格降序
 */
- (void)accordingPriceDesc
{
    self.sortType = KPSortTpyeByPriceDesc;
    KPShopDetailParam *param = [KPShopDetailParam param];
    param.storeId = self.brand.brandId;
    param.pageNumber = self.pageNumber;
    param.sort = @"productPrice";
    param.dir = @"desc";
    
    [self setupDataWithParam:param];
}

/**
 *  价格升序
 */
- (void)accordingPriceAsc
{
    
    self.sortType = KPSortTpyeByPriceAsc;
    KPShopDetailParam *param = [KPShopDetailParam param];
    param.storeId = self.brand.brandId;
    param.pageNumber = self.pageNumber;
    param.sort = @"productPrice";
    
    [self setupDataWithParam:param];
}


/**
 *  销量降序
 */
- (void)accordingSalesDesc
{
    
    self.sortType = KPSortTpyeBySalesDesc;
    KPShopDetailParam *param = [KPShopDetailParam param];
    param.storeId = self.brand.brandId;
    param.pageNumber = self.pageNumber;
    param.sort = @"productSalenum";
    param.dir = @"desc";
    
    [self setupDataWithParam:param];
}


/**
 *  热度降序
 */
- (void)accordingHotDesc
{
    
    self.sortType = KPSortTpyeByHotDesc;
    KPShopDetailParam *param = [KPShopDetailParam param];
    param.storeId = self.brand.brandId;
    param.pageNumber = self.pageNumber;
    param.sort = @"productClick";
    param.dir = @"desc";
    
    [self setupDataWithParam:param];
}

- (void)setupDataWithParam:(KPShopDetailParam *)param
{
    if (self.isRecommend) {
        param.isRecommend = self.isRecommend;
    }
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool shopDataWithParam:param success:^(id result) {
        
//        WHYNSLog(@"-------%@--------", result);
        if (CODE != 0) { WHYNSLog(@"店铺详情请求数据失败 message == %@", result[@"message"]); return; }
        
        weakSelf.shopData = [KPShopDataResult mj_objectWithKeyValues:result[@"data"][@"brand"]];
        weakSelf.headerView.shopData = weakSelf.shopData;
        weakSelf.title = weakSelf.shopData.storeName;
        
        if (weakSelf.pageNumber == 1) {
            
            weakSelf.products = weakSelf.shopData.products;
            if (weakSelf.products.count < 16) {
                weakSelf.goodsListView.showEndRefreshingWithNoMoreData = YES;
            } else {
                weakSelf.goodsListView.showEndRefreshingWithNoMoreData = NO;
            }
        } else {
            
            NSArray *newProducts = weakSelf.shopData.products;
            if (newProducts.count == 0) {
                weakSelf.goodsListView.showEndRefreshingWithNoMoreData = YES;
            } else {
                [weakSelf.products addObjectsFromArray:newProducts];
                weakSelf.goodsListView.showEndRefreshingWithNoMoreData = NO;
            }
        }
        weakSelf.goodsListView.products = weakSelf.products;
        
    } failure:^(NSError *error) {
        WHYNSLog(@"-------%@--------", error);
    }];
}


- (void)setupSubsidizeCount
{    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool getCarItemCountSuccess:^(id result) {
        
        if (CODE != 0) return;
        
        NSString *bageValue = [NSString stringWithFormat:@"%@", result[@"data"][@"cartItemCount"]];
        
        weakSelf.goodsListView.subsidizeCount = bageValue;
        
        UIViewController *tabBarVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *vc = tabBarVc.childViewControllers[3];
        
        if ([bageValue isEqualToString:@"0"]) {
            vc.tabBarItem.badgeValue = nil;
        } else {
            vc.tabBarItem.badgeValue = bageValue;
        }
        
    } failure:^(NSError *error) { }];
}


#pragma mark - setupUI
- (void)setupUI
{
    __weak typeof (self) weakSelf = self;
    CGFloat top = Absolute_Y ? 0 : 64;

    KPShopHeaderView *headerView = [[KPShopHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(top);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(104);
    }];
    self.headerView = headerView;

    [headerView setCollectStore:^(KPButton *collectBtn) {
        // 收藏店铺
        [weakSelf collectStoreWithCollectBtn:collectBtn];
    }];

    [headerView setDeCollectStore:^(KPButton *collectBtn) {
        [weakSelf deCollectStoreWithCollectBtn:collectBtn];
    }];

    [headerView setShareAction:^(KPButton *shareBtn) {
        [weakSelf share];
    }];
    
    
    
    KPSortBar *sortBar = [[KPSortBar alloc] init];
    sortBar.delegate = self;
    [self.view addSubview:sortBar];
    self.sortBar = sortBar;
    [sortBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headerView.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(38);
    }];
    
    // 添加列表
    KPGoodsListView *goodsListView = [[KPGoodsListView alloc] init];
    [self.view addSubview:goodsListView];
    self.goodsListView = goodsListView;
    [goodsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.sortBar.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(SCREEN_H - 104 - 38 - 64);
    }];
    
    [goodsListView setDidSelectedItemIndex:^(KPProduct *product) {
        KPGoodsDetailViewController *goodsDetailVc = [[KPGoodsDetailViewController alloc] init];
        goodsDetailVc.product = product;
        [weakSelf.navigationController pushViewController:goodsDetailVc animated:YES];
    }];
    
    /**
     *  拉下刷新
     */
    [goodsListView setRefreshData:^{
        
        weakSelf.pageNumber = 1;
        
        switch (weakSelf.sortType) {
            case KPSortTpyeByTimeDesc:
            case KPSortTpyeByTimeAsc:
                [weakSelf setupDefaultData];
                break;
            case KPSortTpyeByPriceAsc:
                [weakSelf accordingPriceAsc];
                break;
            case KPSortTpyeByPriceDesc:
                [weakSelf accordingPriceDesc];
                break;
            case KPSortTpyeBySalesDesc:
                [weakSelf accordingSalesDesc];
                break;
            case KPSortTpyeByHotDesc:
                [weakSelf accordingHotDesc];
                break;
                
            default:
                break;
        }
    }];
     

    /**
     *  上拉加载
     */
    [goodsListView setReloadMoreData:^{
        
        weakSelf.pageNumber ++;
        
        switch (weakSelf.sortType) {
            case KPSortTpyeByTimeDesc:
            case KPSortTpyeByTimeAsc:
                [weakSelf setupDefaultData];
                break;
            case KPSortTpyeByPriceAsc:
                [weakSelf accordingPriceAsc];
                break;
            case KPSortTpyeByPriceDesc:
                [weakSelf accordingPriceDesc];
                break;
            case KPSortTpyeBySalesDesc:
                [weakSelf accordingSalesDesc];
                break;
            case KPSortTpyeByHotDesc:
                [weakSelf accordingHotDesc];
                break;
                
            default:
                break;
        }
        
    }];
    
    [goodsListView setScrollViewContent_Y:^(CGFloat scroll_Y) {

        CGFloat offsetY = 0;
        CGFloat height = 0;

        if (scroll_Y > 0) {

            offsetY = 64 - 104;
            height = SCREEN_H - 38 - 64;
            [weakSelf addRightBarButtonItems];
        } else {

            offsetY = top;
            height = SCREEN_H - 38 - 64 - 104;
            
            [weakSelf hiddenRightBarButtonItems];
        }

        if (weakSelf.headerView.y == offsetY) return;

        [weakSelf.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view).offset(offsetY);
        }];
        [weakSelf.goodsListView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];

        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf.view layoutIfNeeded];
        }];

    }];

}

// 添加关注和分享按钮
- (void)addRightBarButtonItems
{
    if (self.navigationItem.rightBarButtonItems) {

        for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
            item.customView.hidden = NO;
        }

        return;
    }

    UIBarButtonItem *rightItem1 = [UIBarButtonItem itemWithImageName:@"follow-off" highImageName:nil selectedImageName:@"follow-on" targe:self action:@selector(collectStoreWithCollectBtn:)];
    UIButton *btn = rightItem1.customView;
    btn.selected = self.shopData.isCollection.integerValue;
    
    UIBarButtonItem *rightItem2 = [UIBarButtonItem itemWithImageName:@"list_share" highImageName:nil selectedImageName:nil targe:self action:@selector(share)];
    
    self.navigationItem.rightBarButtonItems = @[rightItem2, rightItem1];
}

- (void)hiddenRightBarButtonItems
{
    if (self.navigationItem.rightBarButtonItems) {

        for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
            item.customView.hidden = YES;
        }

    }

}

// 分享
- (void)share
{
    NSString *key = self.shopData.storeAvatar;
    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:key];

    [KPSharedTool sharedWithMessage:self.shopData.remark
                              title:self.shopData.storeName
                             urlStr:self.shopData.shareUrl
                              image:image
                           imageSrc:key
                 fromViewController:self];
    
}

// 取消收藏店铺
- (void)deCollectStoreWithCollectBtn:(KPButton *)collectBtn {
    if (!IsLogin) {
        KPLoginRegisterViewController *logVc = [[KPLoginRegisterViewController alloc] init];
        KPNavigationController *nav = [[KPNavigationController alloc] initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        __weak typeof(self) weakSelf = self;

        KPCollectionStoreListParam *param = [[KPCollectionStoreListParam alloc] init];
        param.ids = [NSString stringWithFormat:@"%@", self.brand.brandId];
        [KPNetworkingTool CancelAllStoreCollectionList:param Success:^(id result) {

            if (CODE != 0) return;

            UIButton *btn = weakSelf.navigationItem.rightBarButtonItems[1].customView;

            if ([result[@"data"][@"msg"] isEqualToString:@"true"]) {

                [KPProgressHUD showSuccessWithStatus:@"取消关注成功"];
                weakSelf.headerView.collectedBrand = NO;
                weakSelf.shopData.isCollection = @"0";
                btn.selected = NO;
            }
            else
            {
                [KPProgressHUD showSuccessWithStatus:@"取消关注失败"];
                weakSelf.headerView.collectedBrand = YES;
                weakSelf.shopData.isCollection = @"1";
                btn.selected = YES;
            }

        } failure:^(NSError *error) {
            WHYNSLog(@"-------取消关注失败%@", error);
        }];
    }
}

// 收藏店铺
- (void)collectStoreWithCollectBtn:(KPButton *)collectBtn
{
    if (!IsLogin) {
        KPLoginRegisterViewController *logVc = [[KPLoginRegisterViewController alloc] init];
        KPNavigationController *nav = [[KPNavigationController alloc] initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {

        if (collectBtn.selected) {
            [self deCollectStoreWithCollectBtn:collectBtn];
            return;
        }

        __weak typeof(self) weakSelf = self;
        KPCollectStoreParam *param = [[KPCollectStoreParam alloc] init];
        param.storeId = self.brand.brandId;
        [KPNetworkingTool CollectStore:param Success:^(id result) {
            
            if (CODE != 0) return;

            UIButton *btn = weakSelf.navigationItem.rightBarButtonItems[1].customView;

            if ([result[@"data"][@"collect"] integerValue] == 1) {
                
                [KPProgressHUD showSuccessWithStatus:@"关注成功"];
                weakSelf.headerView.collectedBrand = YES;
                weakSelf.shopData.isCollection = @"1";
                btn.selected = YES;
            }
            else
            {
                [KPProgressHUD showSuccessWithStatus:@"取消关注"];
                weakSelf.headerView.collectedBrand = NO;
                weakSelf.shopData.isCollection = @"0";
                btn.selected = NO;
            }
            
        } failure:^(NSError *error) { WHYNSLog(@"-------商店关注失败%@", error); }];
    }
    
}

- (void)goToSubSize:(KPButton *)buyBtn
{
    if (!IsLogin) {
        KPLoginRegisterViewController *logVc = [[KPLoginRegisterViewController alloc] init];
        KPNavigationController *nav = [[KPNavigationController alloc] initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        KPSubsidizeViewController *subSizeVc = [[KPSubsidizeViewController alloc] init];
        [self.navigationController pushViewController:subSizeVc animated:YES];
    }
}
#pragma mark - KPSortBarDelegate
// 按价格排序
- (void)SortBar:(KPSortBar *)sortBar didSelectedPriceBtn:(KPButton *)priceBtn otherBtnSalesBtn:(KPButton *)salesBtn andHotBtn:(KPButton *)hotBtn
{
    
    self.pageNumber = 1;
    if (priceBtn.selected == NO) {
        [self accordingPriceDesc];
        [priceBtn setImage:[UIImage imageNamed:@"home_sort_down"] forState:UIControlStateNormal];
        priceBtn.selected = YES;
    } else {
        [self accordingPriceAsc];
        [priceBtn setImage:[UIImage imageNamed:@"home_sort_up"] forState:UIControlStateNormal];
        priceBtn.selected = NO;
    }
    
    [priceBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
    [salesBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [hotBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    salesBtn.selected = NO;
    hotBtn.selected = NO;
    
    // 滚到顶部
    [self.goodsListView scrollToTop];
    // 消除没有更多数据的状态
    [self.goodsListView resetNoMoreData];
}

// 按照销量排序
- (void)SortBar:(KPSortBar *)sortBar didSelectedSalesBtn:(KPButton *)salesBtn otherBtnPriceBtn:(KPButton *)priceBtn andHotBtn:(KPButton *)hotBtn
{
    if(salesBtn.selected == NO) {
        self.pageNumber = 1;
        [self accordingSalesDesc];
        [salesBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
        [priceBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        [hotBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        [priceBtn setImage:[UIImage imageNamed:@"home_sort_normal"] forState:UIControlStateNormal];
        
        // 滚到顶部
        [self.goodsListView scrollToTop];
        // 消除没有更多数据的状态
        [self.goodsListView resetNoMoreData];
        salesBtn.selected = YES;
        hotBtn.selected = NO;
    } else {
        return;
    }
}
// 按照热度排序
- (void)SortBar:(KPSortBar *)sortBar didSelectedHotBtn:(KPButton *)hotBtn otherBtnPriceBtn:(KPButton *)priceBtn andSalesBtn:(KPButton *)salesBtn
{
    
    if(hotBtn.selected == NO) {
        self.pageNumber = 1;
        [self accordingHotDesc];
        [hotBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
        [priceBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        [salesBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        [priceBtn setImage:[UIImage imageNamed:@"home_sort_normal"] forState:UIControlStateNormal];
        
        // 滚到顶部
        [self.goodsListView scrollToTop];
        // 消除没有更多数据的状态
        [self.goodsListView resetNoMoreData];
        hotBtn.selected = YES;
        salesBtn.selected = NO;
    } else {
        return;
    }
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    KPStatisticsBeginWithViewName(SelfClassStr)
    
    // 获取购物车商品数量
    [self setupSubsidizeCount];
    
    // 重新获取数据一次数据  为了刷新商品是否被加入购物车
    [self setupDefaultData];
    
    // 监听通知
    [self setupNotification];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 搜索商品
    NSAddObserver(seacrchGoodsAction:, Noti_SearchGoods)
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSRemoveObserverWithName(Noti_SearchGoods)
    
    NSRemoveObserver
}


@end
