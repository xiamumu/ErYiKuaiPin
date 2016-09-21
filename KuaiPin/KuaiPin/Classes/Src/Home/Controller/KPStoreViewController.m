//
//  KPStoreViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/9/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPStoreViewController.h"
#import "KPGoodsCollectionViewCell.h"
#import "KPSubsidizeButton.h"
#import "KPWithoutAnythingView.h"
#import "KPDIYFooterRefresh.h"


#define CollectionViewIden @"collectionViewIden"

@interface KPStoreViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) KPButton *topBtn;

@property (nonatomic, weak) UICollectionView *goodsListView;

@property (nonatomic, weak) KPSubsidizeButton *subsidizeButton;

@property (nonatomic, weak) KPWithoutAnythingView *withoutAnythingView;

@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation KPStoreViewController

- (KPWithoutAnythingView *)withoutAnythingView
{
    if (_withoutAnythingView == nil) {
        KPWithoutAnythingView *withoutView = [[KPWithoutAnythingView alloc] init];
        withoutView.frame = CGRectMake(0, 0, SCREEN_W, 300);
        withoutView.message = @"对不起，没有可显示的商品";
        withoutView.hidden = YES;
        [self.view addSubview:withoutView];
        _withoutAnythingView = withoutView;
    }
    return _withoutAnythingView;
}

- (NSMutableArray *)products
{
    if (_products == nil) {
        _products = [NSMutableArray array];
    }
    return _products;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // setupUI
    [self setupUI];
    
    
}

- (void)setupUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(SCREEN_W, 100);
    
    UICollectionView *goodsListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    goodsListView.bounces = YES;
    goodsListView.delegate = self;
    goodsListView.dataSource = self;
    goodsListView.backgroundColor = BaseColor;
    goodsListView.showsHorizontalScrollIndicator = NO;
    goodsListView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:goodsListView];
    self.goodsListView = goodsListView;
    
    
    [goodsListView registerClass:[KPGoodsCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewIden];
    
    [goodsListView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    
//    goodsListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refeshHeaderAction)];
//    
//    // 设置footer
//    goodsListView.mj_footer = [KPDIYFooterRefresh footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooderAction)];
//    
//    goodsListView.mj_footer.automaticallyHidden = YES;
    
    
    
    
    // 添加滚回按钮和购物车按钮
    KPButton *topBtn = [[KPButton alloc] init];
    [topBtn setBackgroundImage:[UIImage imageNamed:@"backtotop"] forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(scrolToTop) forControlEvents:UIControlEventTouchDown];
    topBtn.hidden = YES;
    [self.view addSubview:topBtn];
    self.topBtn = topBtn;
    
    KPSubsidizeButton *subsidizeButton = [KPSubsidizeButton subsidizeButton];
//    [subsidizeButton addTarget:self action:@selector(goToGoodsCart:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:subsidizeButton];
    self.subsidizeButton = subsidizeButton;
    
    
    __weak __typeof(self) weakSelf = self;
    CGFloat top = Absolute_Y ? 0 : 64;
    [self.goodsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.right.bottom.mas_equalTo(weakSelf.view);
    }];
    [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.view).offset(-CommonMargin);
        make.bottom.mas_equalTo(weakSelf.view).offset(-6);
        make.size.mas_equalTo(weakSelf.topBtn.currentBackgroundImage.size);
    }];
    [self.subsidizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(CommonMargin);
        make.bottom.mas_equalTo(weakSelf.topBtn);
        make.size.mas_equalTo(weakSelf.topBtn.currentBackgroundImage.size);
    }];

}

// 点击排序时滚到顶部
- (void)scrolToTop
{
    [self.goodsListView setContentOffset:CGPointZero animated:YES];
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        headerView.backgroundColor = RedColor;
    }
    return headerView;
}

#pragma mark - UICollectionViewDataSource  -  UICollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.products.count;
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KPGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewIden forIndexPath:indexPath];
//    cell.product = self.products[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (SCREEN_W - CommonMargin * 3) * 0.5;
    CGFloat height = ScaleHeight(275);
    if (iPhone5) {
        height = ScaleHeight(300);
    } else if (iPhone6) {
        height = ScaleHeight(285);
    }
    
    return CGSizeMake(width, height);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CommonMargin, CommonMargin, CommonMargin, CommonMargin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.didSelectedItemIndex) {
//        KPProduct *product = self.products[indexPath.row];
//        self.didSelectedItemIndex(product);
//    }
}

@end
