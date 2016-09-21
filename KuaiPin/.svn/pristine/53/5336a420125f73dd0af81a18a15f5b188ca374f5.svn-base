//
//  KPGoodsDetailToolBar.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGoodsDetailToolBar.h"
#import "KPBageView.h"

@interface KPSubsidizeBtn : KPButton

/** 提醒数字 */
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, weak) KPBageView *bageView;

+ (instancetype)subsidizeBtn;

@end

@implementation KPSubsidizeBtn

+ (instancetype)subsidizeBtn
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setImage:[UIImage imageNamed:@"goods_cart"] forState:UIControlStateNormal];
        KPBageView *bageView = [KPBageView bageView];
        bageView.hidden = YES;
        bageView.selected = YES;
        [self addSubview:bageView];
        self.bageView = bageView;
        
        
        __weak typeof (self) weakSelf = self;
        [self.bageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf).offset(10);
            make.centerY.mas_equalTo(weakSelf).offset(-15);
        }];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if ([badgeValue integerValue] > 0) {
        self.bageView.hidden = NO;
        self.bageView.badgeValue = badgeValue;
    }
    else
    {
        self.bageView.hidden = YES;
    }
}


@end



@interface KPGoodsDetailToolBar ()

@property (nonatomic, weak) KPButton *collectBtn;
@property (nonatomic, strong) NSArray *btns;
@property (nonatomic, weak) KPButton *addSubsidizeBtn;
@property (nonatomic, weak) UIView *line;

@end

@implementation KPGoodsDetailToolBar
- (NSArray *)btns
{
    if (_btns == nil) {
        _btns = [NSArray array];
    }
    return _btns;
}
+ (instancetype)toolBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        
        
        UIView *line = [UIView line];
        [self addSubview:line];
        self.line = line;
        
        KPButton *serviceBtn = [self addBtnWithImage:@"service" action:@selector(btnAction:)];
        serviceBtn.tag = 1000;
        [self addSubview:serviceBtn];
        
        KPButton *brandBtn = [self addBtnWithImage:@"brand" action:@selector(btnAction:)];
        brandBtn.tag = 1001;
        [self addSubview:brandBtn];
        
        KPButton *collectBtn = [self addBtnWithImage:@"collect_normal" action:@selector(btnAction:)];
        [collectBtn setImage:[UIImage imageNamed:@"collect_select"] forState:UIControlStateSelected];
        collectBtn.tag = 1002;
        [self addSubview:collectBtn];
        self.collectBtn = collectBtn;
        
        KPSubsidizeBtn *subsidizeBtn = [KPSubsidizeBtn subsidizeBtn];
        [subsidizeBtn setImage:[UIImage imageNamed:@"gouwu"] forState:UIControlStateNormal];
        [subsidizeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        subsidizeBtn.tag = 1003;
        [self addSubview:subsidizeBtn];
        
        
        self.btns = @[serviceBtn, brandBtn, collectBtn, subsidizeBtn];
        
        KPButton *addSubsidizeBtn = [[KPButton alloc] init];
        addSubsidizeBtn.backgroundColor = OrangeColor;
        [addSubsidizeBtn setTitle:@"加入G库" forState:UIControlStateNormal];
        [addSubsidizeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        addSubsidizeBtn.titleLabel.font = UIFont_16;
        [addSubsidizeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        addSubsidizeBtn.tag = 1004;
        [self addSubview:addSubsidizeBtn];
        self.addSubsidizeBtn = addSubsidizeBtn;
    }
    return self;
}

- (void)setIsCollection:(NSString *)isCollection
{
    _isCollection = [isCollection copy];

    self.collectBtn.selected = isCollection.boolValue;
}

- (void)setSubsidizeBadgeValue:(NSString *)subsidizeBadgeValue
{
    _subsidizeBadgeValue = [subsidizeBadgeValue copy];
    KPSubsidizeBtn *subsidizeBtn = (KPSubsidizeBtn *)[self viewWithTag:1003];
    subsidizeBtn.badgeValue = subsidizeBadgeValue;
}

- (void)setProductStorage:(NSNumber *)productStorage
{
    _productStorage = productStorage;
//    productStorage = 0;
    if (productStorage.integerValue == 0) {
        self.addSubsidizeBtn.backgroundColor = [UIColor lightGrayColor];
        self.addSubsidizeBtn.enabled = NO;
    }
}

- (void)btnAction:(KPButton *)btn
{
    if (btn.tag == 1000) {      // 客服
        if ([self.delegate respondsToSelector:@selector(goodsDetailToolBar:didSelectedServiceBtn:)]) {
            [self.delegate goodsDetailToolBar:self didSelectedServiceBtn:btn];
        }
    }
    else if (btn.tag == 1001)   // 进入品牌
    {
        if ([self.delegate respondsToSelector:@selector(goodsDetailToolBar:didSelectedBrandBtn:)]) {
            [self.delegate goodsDetailToolBar:self didSelectedBrandBtn:btn];
        }
    }
    else if (btn.tag == 1002)   // 收藏
    {
        if ([self.delegate respondsToSelector:@selector(goodsDetailToolBar:didSelectedCollectBtn:)]) {
            [self.delegate goodsDetailToolBar:self didSelectedCollectBtn:btn];
        }
    }
    else if (btn.tag == 1003)   // 进入G库
    {
        if ([self.delegate respondsToSelector:@selector(goodsDetailToolBar:didSelectedGoodsCarBtn:)]) {

            [self.delegate goodsDetailToolBar:self didSelectedGoodsCarBtn:btn];
        }
        
    }
    else if (btn.tag == 1004) // 加入G库
    {
        NSPostNote(Noti_ChooseProductSpec, nil)
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    
    CGFloat addBtn_W = 122;
    CGFloat addBtn_H = 49;
    [self.addSubsidizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(addBtn_W, addBtn_H));
    }];
    
    CGFloat btn_W = (SCREEN_W - addBtn_W) / 4;
    
    NSUInteger count = self.btns.count;
    for (int i = 0; i < count ; i++) {
        KPButton *btn = self.btns[i];
        btn.frame = CGRectMake(btn_W * i, 0, btn_W, addBtn_H);
    }
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
}

- (KPButton *)addBtnWithImage:(NSString *)image action:(SEL)action
{
    KPButton *btn = [[KPButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentMode = UIViewContentModeCenter;
    return btn;
}
@end
