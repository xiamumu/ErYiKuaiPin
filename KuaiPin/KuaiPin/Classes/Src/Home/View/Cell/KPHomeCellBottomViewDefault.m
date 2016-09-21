//
//  KPBottomViewDefault.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPHomeCellBottomViewDefault.h"
#import "KPCommonView.h"
#define SubView_Width ScaleWidth(144)
#define SubView_height ScaleHeight(119)
@interface KPHomeCellBottomViewDefault ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *moreBtn;

@end
@implementation KPHomeCellBottomViewDefault


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self setupScrollView];
    }
    return self;
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
}

- (void)setGoods:(NSArray *)goods
{
    _goods = goods;
    NSUInteger count = goods.count;
    CGFloat margin = 9;
    for (int i = 0; i < count ; i++) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(margin + (SubView_Width + margin) * i, 0, SubView_Width, SubView_height)];
        bgView.userInteractionEnabled = YES;
        bgView.image = [UIImage imageNamed:@"shadow_bg"];
        [self.scrollView addSubview:bgView];
        
        KPCommonView *commonView = [[KPCommonView alloc] initWithFrame:CGRectMake(2, 2, bgView.width - 4, bgView.height - 4)];
        commonView.commonViewType = KPCommonViewTypeTopImageWithBrandPriceAndPromote;
        [commonView.imgView sd_setImageWithURL:[NSURL URLWithString:goods[i]] placeholderImage:PlaceholderImage];
#warning 缺少数据
        [bgView addSubview:commonView];
    }
    
    UIImage *moreBtnImage = [UIImage imageNamed:@"more_big"];
    CGFloat moreBtn_X = count * (SubView_Width + margin) + margin;
    CGFloat moreBtn_W = ScaleWidth(moreBtnImage.size.width);
    CGFloat moreBtn_H = SubView_height;
    
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setBackgroundImage:moreBtnImage forState:UIControlStateNormal];
    moreBtn.frame = CGRectMake(moreBtn_X, 0, moreBtn_W, moreBtn_H);
    [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(moreBtn.frame), SubView_height);
}
// 设置子控件的位置
- (void)layoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_W, SubView_height);
}

// 查看更多页面跳转通知
- (void)moreBtnAction:(UIButton *)moreBtn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Noti_CellMoreBtnAction object:self.fromRowTitle];
}
@end
