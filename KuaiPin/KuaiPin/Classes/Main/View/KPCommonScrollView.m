//
//  KPCommonScrollView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/8.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCommonScrollView.h"
#import "KPSubImageView.h"
#import "KPProduct.h"
#import "KPBrand.h"


@interface KPCommonScrollView ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end
@implementation KPCommonScrollView

+ (instancetype)scrollView
{
    return [[self alloc] init];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = OrangeColor;
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)setImgs:(NSArray *)imgs
{
    _imgs = imgs;
    NSUInteger count = imgs.count;
    
    self.pageControl.numberOfPages = count == 1 ? 0 : count;
    
    // 设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(SCREEN_W * count, 0);
    
  
    if (self.scrollView.subviews.count == count) { // 如果够用就 直接取子控件
        
        
        for (int i = 0; i < count ; i++) {
            KPSubImageView *imgView = self.scrollView.subviews[i];
            
            if ([imgs[i] isKindOfClass:[KPProduct class]]) {
                KPProduct *product = (KPProduct *)imgs[i];
                imgView.product = product;
            }
            else if ([imgs[i] isKindOfClass:[KPBrand class]])
            {
                KPBrand *brand = (KPBrand *)imgs[i];
                imgView.brand = brand;
            }
        }
    }
    else    // 如果不够用就 删除就旧的子控件 再重新创建
    {
        
        // 删除旧的子控件
        if (self.scrollView.subviews.count != 0) {
            for (UIView *view in self.scrollView.subviews) {
                if (view.frame.size.width == 0) {
                    [view removeFromSuperview];
                }
            }
        }
        // 创建新的子控件
        for (int i = 0; i < count ; i++) {
            
            KPSubImageView *imgView = [[KPSubImageView alloc] init];
            imgView.frame = CGRectMake(SCREEN_W * i, 0, SCREEN_W, self.height);
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewAction:)];
            [imgView addGestureRecognizer:tap];
            [self.scrollView addSubview:imgView];
            
            if ([imgs[i] isKindOfClass:[KPProduct class]]) {
                KPProduct *product = (KPProduct *)imgs[i];
                imgView.product = product;
            }
            else if ([imgs[i] isKindOfClass:[KPBrand class]])
            {
                KPBrand *brand = (KPBrand *)imgs[i];
                imgView.brand = brand;
            }
        }
    }
}

- (void)imgViewAction:(UITapGestureRecognizer *)tap
{
    NSPostNote(Noti_CommonScorllViewDidSelected, tap.view)

}
- (void)layoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_W, self.height);
    
    self.pageControl.frame = CGRectMake(0, self.height - 15, SCREEN_W, 15);
    
}

/**
 *  设置圆点的滚动
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger currentPage = scrollView.contentOffset.x / SCREEN_W;
    self.pageControl.currentPage = currentPage;
}

/**
 *  点击圆点滚动图片跟着改变
 */
- (void)changePage:(UIPageControl * )pageControl
{
    NSInteger index = pageControl.currentPage;
    CGPoint point = CGPointMake(SCREEN_W * index, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

@end
