//
//  KPBottomViewDefault.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeFirstModule.h"
#import "KPProduct.h"
#import "KPHomeDefaultView.h"
#import "KPCommonMarginView.h"

#define SubView_Width ScaleWidth(100)
#define SubView_height ScaleHeight(152)

@interface KPHomeFirstModule ()

@property (nonatomic, weak) KPCommonMarginView *topView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) KPButton *moreBtn;

@end
@implementation KPHomeFirstModule


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    KPCommonMarginView *topView = [[KPCommonMarginView alloc] init];
    [self addSubview:topView];
    self.topView = topView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
}

- (void)setProductList:(NSArray *)productList
{
    _productList = productList;
    NSUInteger count = productList.count;
    CGFloat margin = 9;
    
    if (self.scrollView.subviews.count == 0) {
        for (UIView *view in self.scrollView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < count ; i++) {
        
        CGFloat bgView_W = SubView_Width;
        if (!(iPhone5)) {
            bgView_W  = bgView_W + 15;
        }
        
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(margin + (SubView_Width + margin) * i, 0, SubView_Width, SubView_height)];
        bgView.userInteractionEnabled = YES;
        bgView.image = [UIImage imageNamed:@"shadow_bg"];
        [self.scrollView addSubview:bgView];
        
        KPHomeDefaultView *commonView = [[KPHomeDefaultView alloc] initWithFrame:CGRectMake(2, 2, bgView.width - 4, bgView.height - 4)];
        commonView.product = productList[i];
        [bgView addSubview:commonView];
    }
    
    
    UIImage *moreBtnImage = [UIImage imageNamed:@"more_back"];
    CGFloat moreBtn_X = count * (SubView_Width + margin) + margin;
    CGFloat moreBtn_W = ScaleWidth(moreBtnImage.size.width);
    CGFloat moreBtn_H = SubView_height;
    
    KPButton *moreBtn = [[KPButton alloc] init];
    moreBtn.frame = CGRectMake(moreBtn_X, 0, moreBtn_W, moreBtn_H);
    [moreBtn setBackgroundImage:moreBtnImage forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    moreBtn.hidden = count > 4 ? NO : YES;
    [self.scrollView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(moreBtn.frame), SubView_height);
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
    
    self.scrollView.frame = CGRectMake(0, 35, SCREEN_W, self.height);
    
}

// 查看更多页面跳转通知
- (void)moreBtnAction:(KPButton *)moreBtn
{
    NSPostNote(Noti_CellMoreBtnAction, self.title)
}
@end
