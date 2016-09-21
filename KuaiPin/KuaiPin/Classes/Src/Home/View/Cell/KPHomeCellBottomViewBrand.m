//
//  KPBottomViewBrand.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeCellBottomViewBrand.h"
#import "KPCommonView.h"
#define ScrollViewHeight ScaleHeight(121)
#define BottomScrollViewWidth ScaleWidth(83)
#define BottomScrollViewHeight ScaleWidth(66)

@interface KPHomeCellBottomViewBrand ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *topScrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *bottomScrollView;
@property (nonatomic, weak) UIButton *moreBtn;

@end
@implementation KPHomeCellBottomViewBrand

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
    UIScrollView *topScrollView = [[UIScrollView alloc] init];
    topScrollView.delegate = self;
    topScrollView.showsVerticalScrollIndicator = NO;
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.bounces = YES;
    topScrollView.pagingEnabled = YES;
    [self addSubview:topScrollView];
    self.topScrollView = topScrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = HexColor(#ff6d15);
    pageControl.pageIndicatorTintColor = HexColor(#191919);
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
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
    NSUInteger count = scrollImages.count;
    self.pageControl.numberOfPages = count;
    for (int i = 0; i < count ; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W * i, 0, SCREEN_W, ScrollViewHeight)];
        //        imgView.image = scrollImages[i];
        imgView.backgroundColor = RandomColor;
        [self.topScrollView addSubview:imgView];
    }
    // 设置scrollView的contentSize
    self.topScrollView.contentSize = CGSizeMake(SCREEN_W * count, ScrollViewHeight);
}

// 设置商品数据
- (void)setBrand:(NSArray *)brand
{
    _brand = brand;
    NSUInteger count = brand.count;
    CGFloat margin = 1;
    CGFloat commonView_X = BottomScrollViewWidth + margin;
    for (int i = 0; i < count ; i++) {
        KPCommonView *commonView = [[KPCommonView alloc] initWithFrame:CGRectMake(commonView_X * i, 1, BottomScrollViewWidth, BottomScrollViewHeight)];
        commonView.commonViewType = KPCommonViewTypeTopImage;
        [commonView.imgView sd_setImageWithURL:[NSURL URLWithString:brand[i]] placeholderImage:PlaceholderImage];
//        commonView.backgroundColor = RandomColor;
        [self.bottomScrollView addSubview:commonView];
    }
    
    UIImage *moreBtnImage = [UIImage imageNamed:@"more_small"];
    CGFloat moreBtn_X = count * commonView_X;
    CGFloat moreBtn_W = ScaleWidth(moreBtnImage.size.width);
    CGFloat moreBtn_H = BottomScrollViewHeight;
    
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setBackgroundImage:moreBtnImage forState:UIControlStateNormal];
    moreBtn.frame = CGRectMake(moreBtn_X, 0, moreBtn_W, moreBtn_H);
    [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomScrollView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    // 设置scrollView的contentSize
    self.bottomScrollView.contentSize = CGSizeMake(CGRectGetMaxX(moreBtn.frame), BottomScrollViewHeight);
}

// 设置子控件的位置
- (void)layoutSubviews
{
    self.topScrollView.frame = CGRectMake(0, 0, SCREEN_W, ScrollViewHeight);
    self.pageControl.frame = CGRectMake(0, ScrollViewHeight - 15, SCREEN_W, 15);
    self.bottomScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame) + 2, SCREEN_W, BottomScrollViewHeight + 2);
}
// 查看更多页面跳转通知
- (void)moreBtnAction:(UIButton *)moreBtn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Noti_CellMoreBtnAction object:self.fromRowTitle];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger currentPage = scrollView.contentOffset.x / SCREEN_W;
    self.pageControl.currentPage = currentPage;
}
- (void)changePage:(UIPageControl * )pageControl
{
    NSInteger index = pageControl.currentPage;
    CGPoint point = CGPointMake(SCREEN_W * index, 0);
    [self.topScrollView setContentOffset:point animated:YES];
}
@end
