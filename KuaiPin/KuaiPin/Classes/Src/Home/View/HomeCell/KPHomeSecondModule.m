//
//  KPBottomViewGoods.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeSecondModule.h"
#import "KPCommonMarginView.h"
#import "KPCommonScrollView.h"
#import "KPProduct.h"
#import "KPHomeGoodsView.h"

#define ScrollViewHeight ScaleHeight(121)
#define SubView_Width ScaleWidth(100)
#define SubView_height iPhone5 ? ScaleHeight(159) : (ScaleHeight(159) - 10)


@interface KPHomeSecondModule ()<UIScrollViewDelegate>

@property (nonatomic, weak) KPCommonMarginView *topView;
@property (nonatomic, weak) KPCommonScrollView *topScrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *bottomScrollView;
@property (nonatomic, weak) KPButton *moreBtn;

@end


@implementation KPHomeSecondModule

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加上面的大scrollView
        [self setupTopScrollView];
        
        // 添加下面的小scrollView
        [self setupBottomScrollView];
    }
    return self;
}

// 添加上面的大scrollView
- (void)setupTopScrollView
{
    KPCommonMarginView *topView = [[KPCommonMarginView alloc] init];
    [self addSubview:topView];
    self.topView = topView;
    
    KPCommonScrollView *topScrollView = [KPCommonScrollView scrollView];
    [self addSubview:topScrollView];
    self.topScrollView = topScrollView;
}

// 添加下面的小scrollView
- (void)setupBottomScrollView
{
    UIScrollView *bottomScrollView = [[UIScrollView alloc] init];
    bottomScrollView.backgroundColor = RGBColor(242, 242, 242);
    bottomScrollView.showsVerticalScrollIndicator = NO;
    bottomScrollView.showsHorizontalScrollIndicator = NO;
    bottomScrollView.bounces = YES;
    [self addSubview:bottomScrollView];
    self.bottomScrollView = bottomScrollView;
}

// 设置滚动图片设置
- (void)setScrollImages:(NSArray *)scrollImages
{
    _scrollImages = scrollImages;
    self.topScrollView.imgs = scrollImages;
}

// 设置商品数据
- (void)setProductList:(NSArray *)productList
{
    _productList = productList;
    NSUInteger count = productList.count;
    CGFloat margin = 2;
    CGFloat commonView_X = SubView_Width + margin;
    
    if (self.bottomScrollView.subviews.count != 0) {
        for (KPHomeGoodsView *goodsView in self.bottomScrollView.subviews) {
            [goodsView removeFromSuperview];
        }
    }
    
    for (int i = 0; i < count ; i++) {
        
        KPHomeGoodsView *goodsView = [[KPHomeGoodsView alloc] initWithFrame:CGRectMake(commonView_X * i, margin, SubView_Width, SubView_height)];
        goodsView.product = productList[i];
//        goodsView.backgroundColor = RandomColor;
        [self.bottomScrollView addSubview:goodsView];
    }
    
    UIImage *moreBtnImage = [UIImage imageNamed:@"more_back"];
    CGFloat moreBtn_X = count * commonView_X;
    CGFloat moreBtn_W = ScaleWidth(moreBtnImage.size.width);
    CGFloat moreBtn_H = SubView_height;
    
    KPButton *moreBtn = [[KPButton alloc] init];
    moreBtn.frame = CGRectMake(moreBtn_X, 2, moreBtn_W, moreBtn_H);
    [moreBtn setBackgroundImage:moreBtnImage forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    moreBtn.hidden = count > 4 ? NO : YES;
    [self.bottomScrollView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    // 设置scrollView的contentSize
    self.bottomScrollView.contentSize = CGSizeMake(CGRectGetMaxX(moreBtn.frame), ScrollViewHeight);
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.topView.title = title;
}

// 设置子控件的位置
- (void)layoutSubviews
{
    self.topView.frame = CGRectMake(0, 0, SCREEN_W, 35);
    
    self.topScrollView.frame = CGRectMake(0, 35, SCREEN_W, ScrollViewHeight);
    
    self.bottomScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), SCREEN_W, SubView_height + 2);
}

// 查看更多页面跳转通知
- (void)moreBtnAction:(KPButton *)moreBtn
{
    NSPostNote(Noti_CellMoreBtnAction, self.title)
}

@end
