//
//  KPGoodsListView.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/29.
//  Copyright © 2016年 21_xm. All rights reserved.
//  查看更多页面中中间的商品展示区的View


#import "KPGoodsListView.h"
#import "KPGoodsCollectionViewCell.h"

#define CollectionViewIden @"collectionViewIden"

@interface KPGoodsListView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *goodsListView;
@end

@implementation KPGoodsListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *goodsListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    goodsListView.bounces = YES;
    goodsListView.delegate = self;
    goodsListView.dataSource = self;
    goodsListView.showsHorizontalScrollIndicator = NO;
    goodsListView.showsVerticalScrollIndicator = NO;
    goodsListView.backgroundColor = [UIColor whiteColor];
    
    [goodsListView registerClass:[KPGoodsCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewIden];
    [self addSubview:goodsListView];
    self.goodsListView = goodsListView;
    
    
}

#pragma mark - UICollectionViewDataSource  -  UICollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsListDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KPGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewIden forIndexPath:indexPath];
    cell.goodsListData = self.goodsListDatas[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (SCREEN_W - 27) * 0.5;
    CGFloat height = ScaleHeight(184);
    return CGSizeMake(width, height);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(9, 9, 9, 9);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak __typeof(self) weakSelf = self;
    [self.goodsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(weakSelf);
    }];
    
}
@end
