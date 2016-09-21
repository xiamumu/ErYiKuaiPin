//
//  KPLocalPickerController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/8/30.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPLocalPickerController.h"
#import "KPAreaListViewController.h"
#import "KPAreaSelectedButton.h"

NSInteger const maxCount = 3;
NSTimeInterval const animateDuration = 0.3;

@interface KPLocalPickerController ()<UIScrollViewDelegate, KPAreaListViewControllerDelegate>

@property (nonatomic, strong) KPButton *maskBtn;

@property (nonatomic, strong) UIView *whiteBgView;

@property (nonatomic, strong) KPButton *cancelBtn;

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *lastView;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) NSArray<KPAreaSelectedButton *> *selectedBtns;

@property (nonatomic, strong) NSArray<KPAreaListViewController *> *listViewControllers;

@end

@implementation KPLocalPickerController

#pragma mark - 对外接口
- (void)showView {

    [self.listViewControllers[0] reloadDataWithParentId:0];

    __weak typeof(self) weakSelf = self;

    if (!self.view.superview) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self.view];
    }else {
        self.view.y = 0;
    }

    [UIView animateWithDuration:animateDuration animations:^{
        weakSelf.maskBtn.alpha = 0.7;
        weakSelf.whiteBgView.y = SCREEN_H - weakSelf.whiteBgView.height;
    } completion:^(BOOL finished) {

        if (weakSelf.addressModel) {
            weakSelf.listViewControllers[0].itemId = weakSelf.addressModel.provinceId;
            weakSelf.listViewControllers[1].itemId = weakSelf.addressModel.cityId;
            weakSelf.listViewControllers[2].itemId = weakSelf.addressModel.countryId;
        }else {
            weakSelf.listViewControllers[0].itemId = weakSelf.provinceId;
            weakSelf.listViewControllers[1].itemId = weakSelf.cityId;
            weakSelf.listViewControllers[2].itemId = weakSelf.countryId;
        }

    }];
}

+ (instancetype)localPickerControllerWithFinishedHandler:(FinishedHandler)finishedHandler {

    KPLocalPickerController *controller = [self new];
    controller.finishedHandler = finishedHandler;

    return controller;
}

- (void)setAddressModel:(KPAddressModel *)addressModel {
    _addressModel = addressModel;

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.view];
    self.view.y = SCREEN_H;

    KPAreaListViewController *provinceListVc = self.listViewControllers[0];
    [provinceListVc reloadDataWithParentId:0];

    KPAreaListViewController *cityListVc = self.listViewControllers[1];
    cityListVc.parentId = addressModel.provinceId.integerValue;
    cityListVc.view.hidden = NO;
    [cityListVc reloadDataWithParentId:addressModel.provinceId.integerValue];

    KPAreaListViewController *countryListVc = self.listViewControllers[2];
    countryListVc.parentId = addressModel.cityId.integerValue;
    countryListVc.view.hidden = NO;
    [countryListVc reloadDataWithParentId:addressModel.cityId.integerValue];

    KPAreaSelectedButton *provinceBtn = self.selectedBtns[0];
    provinceBtn.hidden = NO;
    provinceBtn.selected = YES;
    provinceBtn.areaName = addressModel.provinceName;

    KPAreaSelectedButton *cityBtn = self.selectedBtns[1];
    cityBtn.hidden = NO;
    cityBtn.selected = YES;
    cityBtn.areaName = addressModel.cityName;

    KPAreaSelectedButton *countryBtn = self.selectedBtns[2];
    countryBtn.hidden = NO;
    countryBtn.selected = YES;
    countryBtn.areaName = addressModel.countryName;

    [self.whiteBgView layoutIfNeeded];
    [self scrollIndicatorToIndex:2];
    [self scrollToPage:2];

}

#pragma mark - 点击事件
- (void)clickCancelButton {

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animateDuration animations:^{
        weakSelf.maskBtn.alpha = 0;
        weakSelf.whiteBgView.y = SCREEN_H;
    } completion:^(BOOL finished) {
        if (weakSelf.view.superview) {
            [weakSelf.view removeFromSuperview];
        }
    }];
    
}

- (void)clickSelectedButton:(KPAreaSelectedButton *)btn {

    __weak typeof(self) weakSelf = self;
    [self.selectedBtns enumerateObjectsUsingBlock:^(KPAreaSelectedButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if ([btn isEqual:obj]) {
            [weakSelf scrollIndicatorToIndex:idx];
            [weakSelf scrollToPage:idx];
        }

    }];
    
}


#pragma mark - 生命周期
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self setupUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - KPAreaListViewControllerDelegate
- (void)listViewController:(KPAreaListViewController *)listViewController didSelectedArea:(KPAreaItemModel *)area {

//    WHYNSLog(@"%@++++++%@", area.name, area.itemId);

    KPAreaListViewController *currentListVc = nil;
    KPAreaListViewController *nextListVc = nil;

    KPAreaSelectedButton *currentBtn = nil;
    KPAreaSelectedButton *nextBtn = nil;

    NSInteger currentIndex = -1;
    NSInteger nextIndex = -1;

    for (int i = 0; i < self.listViewControllers.count; i++) {

        currentListVc = self.listViewControllers[i];

        if ([listViewController isEqual:currentListVc]) {

            currentBtn = self.selectedBtns[i];
            currentIndex = i;

            if (i < self.selectedBtns.count - 1) {
                nextIndex = i + 1;
                nextBtn = self.selectedBtns[nextIndex];
                nextListVc = self.listViewControllers[nextIndex];
            }
            
            break;
        }
    }

    if (![currentBtn.currentTitle isEqualToString:area.name]) {

        currentBtn.selected = YES;
        currentBtn.areaName = area.name;

        [self initializeDefaultFromIndex:nextIndex];

        nextListVc.view.hidden = NO;
        nextBtn.hidden = NO;

        self.scrollView.contentSize = CGSizeMake(SCREEN_W * (currentIndex + 2), 0);

        [self.whiteBgView layoutIfNeeded];

        [self setListViewControllerParentId:area.itemId withIndex:currentIndex];

        [nextListVc reloadDataWithParentId:area.itemId.integerValue];
        
    }

    if (currentIndex == self.selectedBtns.count - 1) {
        [self savedAddressLocation];
        [self updateIndecatorFrameWithX:currentBtn.x width:currentBtn.width];
        return;
    }

    [self scrollIndicatorToIndex:nextIndex];
    [self scrollToPage:nextIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollIndicatorToIndex:self.scrollView.contentOffset.x / SCREEN_W];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self scrollIndicatorToIndex:self.scrollView.contentOffset.x / SCREEN_W];
}

#pragma mark - 私有方法
- (void)savedAddressLocation {

    if (self.finishedHandler) {

        [self clickCancelButton];

        self.addressLocation = [NSString stringWithFormat:@"%@%@%@", self.selectedBtns[0].currentTitle,
                                                                     self.selectedBtns[1].currentTitle,
                                                                     self.selectedBtns[2].currentTitle];

        self.finishedHandler(self.addressLocation);



        self.addressModel.provinceId = self.provinceId;
        self.addressModel.provinceName = self.selectedBtns[0].currentTitle;
        self.addressModel.cityId = self.cityId;
        self.addressModel.cityName = self.selectedBtns[1].currentTitle;
        self.addressModel.countryId = self.countryId;
        self.addressModel.countryName = self.selectedBtns[2].currentTitle;

    }

}

- (void)setListViewControllerParentId:(NSNumber *)parentId withIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            self.provinceId = parentId;
            break;
        case 1:
            self.cityId = parentId;
            break;
        case 2:
            self.countryId = parentId;
            break;
        case 3:
            self.townId = parentId;
            break;
        default:
            break;
    }

}

- (void)scrollToPage:(NSInteger)page {
    if (page < 0) return;

    self.currentPage = page;
    [self.scrollView setContentOffset:CGPointMake(SCREEN_W * page, 0) animated:YES];
}

- (void)scrollIndicatorToIndex:(NSInteger)index {
    if (index < 0) return;
    KPAreaSelectedButton *btn = self.selectedBtns[index];
    [self updateIndecatorFrameWithX:btn.x width:btn.width];
}

- (void)updateIndecatorFrameWithX:(CGFloat)x width:(CGFloat)width {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animateDuration animations:^{
        weakSelf.indicatorView.x = x;
        weakSelf.indicatorView.width = width;
    }];
}

- (void)initializeDefaultFromIndex:(NSInteger)index {

    if (index < 0) return;

    for (NSInteger i = index; i < self.listViewControllers.count; i++) {
        KPAreaListViewController *listVc = self.listViewControllers[i];
        KPAreaSelectedButton *btn = self.selectedBtns[i];

        listVc.view.hidden = YES;
        listVc.areaModel = nil;
        btn.areaName = @"请选择";
        btn.hidden = YES;
        btn.selected = NO;
    }

}

- (void)setupUI {

    __weak typeof(self) weakSelf = self;

    CGFloat left = 9;
    CGFloat cancelMargin = 15;
    CGFloat titleTop = 16;
    CGFloat titleH = 17;
    CGFloat sepTop = 75;
    CGFloat sepH = 2;
    CGFloat btnTop = 56;
    CGFloat btnH = 13;
    CGFloat btnMargin = 18;
    CGFloat listVcH = 323;
    CGFloat indicatorH = 2;
    CGFloat indicatorTop = 75;
    CGFloat indicatorW = [self.selectedBtns[0].currentTitle sizeWithAttributes:@{
                                                                                 NSFontAttributeName : self.selectedBtns[0].currentTitleFont
                                                                                 }].width;

    self.view.backgroundColor = [UIColor clearColor];

    [self.view addSubview:self.maskBtn];
    [self.view addSubview:self.whiteBgView];

    [self.whiteBgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.whiteBgView).offset(-cancelMargin);
        make.top.mas_equalTo(weakSelf.whiteBgView).offset(cancelMargin);
    }];

    [self.whiteBgView addSubview:self.titleLB];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.whiteBgView);
        make.top.mas_equalTo(titleTop);
        make.height.mas_equalTo(titleH);
    }];

    [self.selectedBtns enumerateObjectsUsingBlock:^(KPAreaSelectedButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {

        [weakSelf.whiteBgView addSubview:btn];

        [btn mas_makeConstraints:^(MASConstraintMaker *make) {

            if (idx == 0) {
                make.left.mas_equalTo(weakSelf.whiteBgView).offset(left);
                make.top.mas_equalTo(weakSelf.whiteBgView).offset(btnTop);
                make.height.mas_equalTo(btnH);
            }else {
                make.left.mas_equalTo(weakSelf.selectedBtns[idx - 1].mas_right).offset(btnMargin);
                make.bottom.height.mas_equalTo(weakSelf.selectedBtns[idx - 1]);
            }
            
        }];

        if (idx != 0) {
            btn.hidden = YES;
        }

    }];

    KPSeparatorView *sep = [KPSeparatorView new];
    [self.whiteBgView addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.whiteBgView).offset(sepTop);
        make.left.right.mas_equalTo(weakSelf.whiteBgView);
        make.height.mas_equalTo(sepH);
    }];

    [self.whiteBgView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.whiteBgView);
        make.top.mas_equalTo(sep.mas_bottom);
    }];

    [self.listViewControllers enumerateObjectsUsingBlock:^(KPAreaListViewController * _Nonnull listViewController, NSUInteger idx, BOOL * _Nonnull stop) {

        [weakSelf.scrollView addSubview:listViewController.view];

        [listViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(weakSelf.scrollView);
            if (idx == 0) {
                make.left.mas_equalTo(weakSelf.scrollView);
            }else {
                make.left.mas_equalTo(weakSelf.listViewControllers[idx - 1].view.mas_right);
            }

            if (idx == (maxCount - 1)) {
                make.right.mas_equalTo(weakSelf.scrollView);
            }

            make.width.mas_equalTo(SCREEN_W);
            make.height.mas_equalTo(listVcH);
        }];

        if (idx != 0) {
            listViewController.view.hidden = YES;
        }

    }];

    [self.whiteBgView addSubview:self.indicatorView];
    self.indicatorView.frame = CGRectMake(left, indicatorTop, indicatorW, indicatorH);

    self.scrollView.contentSize = CGSizeMake(SCREEN_W, 0);

}

#pragma mark - 懒加载
-(KPButton *)maskBtn {
    if (_maskBtn == nil) {
        _maskBtn = [[KPButton alloc] initWithFrame:self.view.bounds];
        [_maskBtn setBackgroundColor:[UIColor blackColor]];
        _maskBtn.alpha = 0;
        [_maskBtn addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskBtn;
}

- (UIView *)whiteBgView {
    if (_whiteBgView == nil) {
        CGFloat h = 400;
        CGFloat w = SCREEN_W;
        CGFloat x = 0;
        CGFloat y = SCREEN_H;
        _whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _whiteBgView.backgroundColor = WhiteColor;
    }
    return _whiteBgView;
}

- (KPButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [KPButton new];
        [_cancelBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.text = @"所在地区";
        _titleLB.font = UIFont_17;
        _titleLB.textColor = BlackColor;
    }
    return _titleLB;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = HexColor(#555555);
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [UIView new];
        _indicatorView.backgroundColor = LightRedColor;
    }
    return _indicatorView;
}

- (NSArray<KPAreaSelectedButton *> *)selectedBtns {
    if (_selectedBtns == nil) {
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:maxCount];
        for (int i = 0; i < maxCount; i++) {
            KPAreaSelectedButton *btn = [KPAreaSelectedButton areaSelectedButtonAreaName:@"请选择"];
            [btn addTarget:self action:@selector(clickSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
            [arrM addObject:btn];
        }
        _selectedBtns = [arrM copy];
    }
    return _selectedBtns;
}

- (NSArray<KPAreaListViewController *> *)listViewControllers {
    if (_listViewControllers == nil) {
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:maxCount];
        for (int i = 0; i < maxCount; i++) {
            KPAreaListViewController *viewController = [KPAreaListViewController new];
            if (i == 0) viewController.parentId = i;
            viewController.deep = i + 1;
            viewController.delegate = self;
            [arrM addObject:viewController];
        }
        _listViewControllers = [arrM copy];
    }
    return _listViewControllers;
}


@end
