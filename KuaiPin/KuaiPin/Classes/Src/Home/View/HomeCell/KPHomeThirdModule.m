//
//  KPBottomViewBrand.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeThirdModule.h"
#import "KPCommonScrollView.h"
#import "KPCommonMarginView.h"
#import "KPBrand.h"
#import "KPHomeBrandView.h"

#define ScrollViewHeight ScaleHeight(121)
#define SubView_Width ScaleWidth(100)
#define SubView_height ScaleHeight(159)

//#define BottomScrollViewWidth ScaleWidth(83)
//#define BottomScrollViewHeight ScaleWidth(66)

@interface KPHomeThirdModule ()<UIScrollViewDelegate>

@property (nonatomic, weak) KPCommonMarginView *topView;
@property (nonatomic, weak) KPCommonScrollView *topScrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *bottomScrollView;
@property (nonatomic, weak) KPButton *moreBtn;

@end
@implementation KPHomeThirdModule

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
- (void)setBrandList:(NSArray *)brandList
{
    _brandList = brandList;
    NSUInteger count = brandList.count;
    CGFloat margin = 1;
    CGFloat commonView_X = SubView_Width + margin;
    
    // 避免重复添加
    if (self.bottomScrollView.subviews.count != 0) {
        for (KPHomeBrandView *view in self.bottomScrollView.subviews) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i < count ; i++) {

        KPHomeBrandView *brandView = [[KPHomeBrandView alloc] initWithFrame:CGRectMake(commonView_X * i, 1, SubView_Width, SubView_height)];
        brandView.brand = brandList[i];
        [self.bottomScrollView addSubview:brandView];
    }
    
    UIImage *moreBtnImage = [UIImage imageNamed:@"more_back"];
    CGFloat moreBtn_X = count * commonView_X;
    CGFloat moreBtn_W = ScaleWidth(moreBtnImage.size.width);
    CGFloat moreBtn_H = SubView_height;
    
    KPButton *moreBtn = [[KPButton alloc] init];
    moreBtn.frame = CGRectMake(moreBtn_X, 0, moreBtn_W, moreBtn_H);
    [moreBtn setBackgroundImage:moreBtnImage forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.hidden = count > 3 ? NO : YES;
    
    [self.bottomScrollView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    // 设置scrollView的contentSize
    self.bottomScrollView.contentSize = CGSizeMake(CGRectGetMaxX(moreBtn.frame), SubView_height);
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
    
    self.bottomScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame) + 2, SCREEN_W, self.height - ScrollViewHeight);
}
// 查看更多页面跳转通知
- (void)moreBtnAction:(KPButton *)moreBtn
{
    NSPostNote(Noti_CellMoreBtnAction, self.title)
}

@end
