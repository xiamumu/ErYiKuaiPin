//
//  KPDIYRefresh.m
//  KuaiPin
//
//  Created by 21_xm on 16/9/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPDIYFooterRefresh.h"

@interface KPDIYFooterRefresh ()

@property (nonatomic, weak) UIImageView *footRefresh;
@end

@implementation KPDIYFooterRefresh

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    self.backgroundColor = ClearColor;
    UIImageView *footRefresh = [[UIImageView alloc] init];
    footRefresh.layer.masksToBounds = YES;
    footRefresh.contentMode = UIViewContentModeScaleAspectFill;
    footRefresh.backgroundColor = ClearColor;
    [self addSubview:footRefresh];
    self.footRefresh = footRefresh;
    
    self.height = 44;
    self.width = SCREEN_W;
}


#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
//    CGSize size = self.footRefresh.image.size;
//    self.footRefresh.centerX = self.centerX;
//    self.footRefresh.centerY = self.centerY;
//    self.footRefresh.width = size.width;
//    self.footRefresh.height = size.height;
    
    __weak typeof (self) weakSelf = self;
    [self.footRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(weakSelf.footRefresh.image.size);
    }];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.footRefresh.image = [UIImage imageNamed:@"loading_begin"];
            break;
        case MJRefreshStateRefreshing:
            self.footRefresh.image = [UIImage imageNamed:@"loading_refreshing"];
            break;
        case MJRefreshStateNoMoreData:
            self.footRefresh.image = [UIImage imageNamed:@"loading_nodata"];
            break;
        default:
            break;
    }
}

@end