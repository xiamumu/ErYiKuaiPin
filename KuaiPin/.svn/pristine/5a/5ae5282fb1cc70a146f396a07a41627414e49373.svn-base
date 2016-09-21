//
//  KPCommonNavigationBar.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/20.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCommonNavigationBar.h"

@interface KPCommonNavigationBar ()

@property (nonatomic, weak) UIImageView *bgImageView;

@end
@implementation KPCommonNavigationBar


+ (instancetype)navigationBar
{
    return [[self alloc] init];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        bgImageView.layer.shadowOffset = CGSizeMake(0, 2);
        bgImageView.layer.shadowOpacity = 0.3;
        [self addSubview:bgImageView];
        self.bgImageView = bgImageView;
        
        KPButton *leftBtn = [[KPButton alloc] init];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_icon_click"] forState:UIControlStateHighlighted];
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        self.leftBtn = leftBtn;
        
        KPButton *rightBtn = [[KPButton alloc] init];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"shared"] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"shared"] forState:UIControlStateHighlighted];
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        self.rightBtn = rightBtn;

        XMSearchBar *searchBar = [[XMSearchBar alloc] init];
        searchBar.searchBarType = XMSearchBarTypeHome;
        [self addSubview:searchBar];
        self.searchBar = searchBar;
        
        UILabel *titleView = [UILabel addLabelWithTitle:@"" textColor:BlackColor font:UIFont_17];
        titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleView];
        self.titleView = titleView;
        
        KPMessageButton *messageBtn = [KPMessageButton messageButton];
        [messageBtn addTarget:self action:@selector(messageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:messageBtn];
        self.messageBtn = messageBtn;

    }
    return self;
}

- (void)setNavigationBarType:(KPCommonNavigationBarType)navigationBarType
{
    _navigationBarType = navigationBarType;
    __weak typeof (self) weakSelf = self;
    
    if (navigationBarType == KPCommonNavigationBarTypeHome) {
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
        
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).offset(CommonMargin);
            make.bottom.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.right.mas_equalTo(weakSelf).offset(-40);
            make.height.mas_equalTo(28);
        }];
        
        CGSize messageBtnSize = CGSizeMake(35, 35);
        [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.centerY.mas_equalTo(weakSelf.searchBar);
            make.size.mas_equalTo(messageBtnSize);
        }];
        
        [self.leftBtn removeFromSuperview];
        [self.rightBtn removeFromSuperview];
        [self.titleView removeFromSuperview];

    }
    else if (navigationBarType == KPCommonNavigationBarTypeGoodsDetail)
    {
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
        
        CGFloat bottom = (44 - self.leftBtn.currentBackgroundImage.size.height) * 0.5;
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).offset(CommonMargin);
            make.bottom.mas_equalTo(-bottom);
            make.size.mas_equalTo(weakSelf.leftBtn.currentBackgroundImage.size);
        }];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.bottom.mas_equalTo(-bottom);
            make.size.mas_equalTo(weakSelf.rightBtn.currentBackgroundImage.size);
        }];
        
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.leftBtn);
            make.centerX.mas_equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(150, 28));
        }];
        
        [self.searchBar removeFromSuperview];
        [self.messageBtn removeFromSuperview];
    }
    
}

- (void)setBarBackgroundColorWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, SCREEN_W, 64);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.bgImageView.image = image;
}

- (void)leftBtnAction:(KPButton *)btn
{
    if (self.leftBtnAction) {
    self.leftBtnAction();
    }
    
}

- (void)rightBtnAction:(UIButton *)rightBtn
{
    if (self.rightBtnAction) {
        self.rightBtnAction();
    }
}

- (void)messageBtnAction:(KPButton *)btn
{
    if (self.messageBtnAction) {
        self.messageBtnAction();
    }
}

@end
