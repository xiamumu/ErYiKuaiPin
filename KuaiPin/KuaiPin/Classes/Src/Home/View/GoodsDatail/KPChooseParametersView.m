//
//  KPChooseParametersView.m
//  KuaiPin
//
//  Created by 21_xm on 16/8/31.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPChooseParametersView.h"
#import "KPSingParamView.h"
#import "KPSingleParameModel.h"
#import "KPProductSpec.h"
#import "KPChooseProductNumView.h"
#import "KPChooseProductPriceView.h"
#import "KPUpdateSubsidizeParam.h"

@interface KPChooseParametersView ()<UIScrollViewDelegate>

@property (nonatomic, weak) KPSingParamView *singParamView;

@property (nonatomic, weak) KPChooseProductNumView *chooseNumView;

@property (nonatomic, weak) UIView *topLine;

@property (nonatomic, weak) UIView *bottomLine;


@property (nonatomic, strong) NSMutableArray *singParamViewArr;

@end


@implementation KPChooseParametersView

- (KPProductSpec *)productSpec
{
    if (_productSpec == nil) {
        _productSpec = [[KPProductSpec alloc] init];
    }
    return _productSpec;
}

- (NSMutableArray *)singParamViewArr
{
    if (_singParamViewArr == nil) {
        _singParamViewArr = [NSMutableArray array];
    }
    return _singParamViewArr;
}
#pragma mark - 初始化选择参数的View
+ (instancetype)parametersView
{
    KPChooseParametersView *paramView = [[[NSBundle mainBundle] loadNibNamed:@"KPChooseParametersView" owner:nil options:nil] objectAtIndex:0];

    return paramView;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        // 添加选择商品购买价格的View
        KPChooseProductPriceView *choosePriceView = [[KPChooseProductPriceView alloc] init];
        [self addSubview:choosePriceView];
        self.choosePriceView = choosePriceView;
        
        // 添加承载规格的scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
//        scrollView.backgroundColor = OrangeColor;
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = YES;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 添加选择商品购买数量View
        KPChooseProductNumView *chooseNumView = [[KPChooseProductNumView alloc] init];
        [scrollView addSubview:chooseNumView];
        self.chooseNumView = chooseNumView;
        
        __weak typeof (self) weakSelf = self;
        [choosePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf).offset(50);
            make.left.right.mas_equalTo(weakSelf);
            make.height.mas_equalTo(50);
        }];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf);
            make.bottom.mas_equalTo(weakSelf).offset(-49);
            make.height.mas_equalTo(255);
        
        }];
        
        // 监听单个选择参数的通知
        NSAddObserver(chooseProductParam:, Noti_ChooseProductParam)
        
        UIView *topLine = [UIView line];
        [self addSubview:topLine];
        self.topLine = topLine;
        
        UIView *bottomLine = [UIView line];
        [self addSubview:bottomLine];
        self.bottomLine = bottomLine;
        
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(choosePriceView.mas_bottom);
            make.left.mas_equalTo(weakSelf).offset(CommonMargin);
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.height.mas_equalTo(1);
        }];
        
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(chooseNumView.mas_top);
            make.left.mas_equalTo(weakSelf).offset(CommonMargin);
            make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

#pragma mark - 数据处理
// 传递数据模型   并根据数据模型创建选择项
- (void)setSingleParameModels:(NSArray<KPSingleParameModel *> *)singleParameModels
{
    _singleParameModels = singleParameModels;
    
    
    CGFloat scrollView_contentHeight = 0;
    CGFloat singleParamView_Y = 0;
    
    for (int i = 0; i < singleParameModels.count ; i++) {
        
        KPSingleParameModel *paramModel = singleParameModels[i];
        
        KPSingParamView *singleParamView = [KPSingParamView singParamView];
        singleParamView.specSign = i + 1;
        singleParamView.productSpecList = self.productSpecList;
        singleParamView.title = paramModel.title;
        singleParamView.subTitlesId = paramModel.subTitlesId;
        singleParamView.subTitles = paramModel.subTitles;
        
        // 计算位置
        singleParamView.frame = CGRectMake(0, singleParamView_Y, SCREEN_H, singleParamView.height);
        singleParamView_Y += singleParamView.height;
        scrollView_contentHeight = CGRectGetMaxY(singleParamView.frame);
        
        [self.scrollView addSubview:singleParamView];
        [self.singParamViewArr addObject:singleParamView];
    }
    
    self.chooseNumView.frame = CGRectMake(0, scrollView_contentHeight + 15, SCREEN_W, 50);
    self.chooseNumView.maxNum = self.productStorage;
    self.chooseNumView.hidden = self.hideProductAddNum;
    
    scrollView_contentHeight = CGRectGetMaxY(self.chooseNumView.frame);
    self.scrollView.contentSize = CGSizeMake(0, scrollView_contentHeight + 30);
    
}

- (void)setSpecTitles:(NSArray<KPSpecTitle *> *)specTitles
{
    _specTitles = specTitles;
    
    BOOL hidden = self.specTitles.count == 0;
    [self hiddenLines:hidden];
}
//**************************************************************//
// 设置存储的旧参数
- (void)setOldChooseProductSpec:(KPProductSpec *)oldChooseProductSpec
{
    _oldChooseProductSpec = oldChooseProductSpec;
    WHYNSLog(@"--------%ld--------", self.singParamViewArr.count);
    
    switch (self.singParamViewArr.count) {
        case 1:
        {
            NSString *spec1 = oldChooseProductSpec.spec1;
            NSString *strSpec1 = oldChooseProductSpec.strSpec1;
            KPSingParamView *singleParamView = self.singParamViewArr[0];
            singleParamView.selectedTagSpec = spec1;
            
            self.productSpec.spec1 = spec1;
            self.productSpec.strSpec1 = strSpec1;
            [self check];
            
        }
            break;
        case 2:
        {
            NSString *spec1 = oldChooseProductSpec.spec1;
            NSString *strSpec1 = oldChooseProductSpec.strSpec1;
            KPSingParamView *singleParamView1 = self.singParamViewArr[0];
            singleParamView1.selectedTagSpec = spec1;
            
            NSString *spec2 = oldChooseProductSpec.spec2;
            NSString *strSpec2 = oldChooseProductSpec.strSpec2;
            KPSingParamView *singleParamView2 = self.singParamViewArr[1];
            singleParamView2.selectedTagSpec = spec2;
            
            self.productSpec.spec1 = spec1;
            self.productSpec.strSpec1 = strSpec1;
            self.productSpec.spec2 = spec2;
            self.productSpec.strSpec2 = strSpec2;
            [self check];
        }
            break;
        case 3:
        {
            NSString *spec1 = oldChooseProductSpec.spec1;
            NSString *strSpec1 = oldChooseProductSpec.strSpec1;
            KPSingParamView *singleParamView1 = self.singParamViewArr[0];
            singleParamView1.selectedTagSpec = spec1;
            
            NSString *spec2 = oldChooseProductSpec.spec2;
            NSString *strSpec2 = oldChooseProductSpec.strSpec2;
            KPSingParamView *singleParamView2 = self.singParamViewArr[1];
            singleParamView2.selectedTagSpec = spec2;
            
            NSString *spec3 = oldChooseProductSpec.spec3;
            NSString *strSpec3 = oldChooseProductSpec.strSpec3;
            KPSingParamView *singleParamView3 = self.singParamViewArr[2];
            singleParamView3.selectedTagSpec = spec3;
            
            
            self.productSpec.spec1 = spec1;
            self.productSpec.strSpec1 = strSpec1;
            self.productSpec.spec2 = spec2;
            self.productSpec.strSpec2 = strSpec2;
            self.productSpec.spec3 = spec3;
            self.productSpec.strSpec3 = strSpec3;
            [self check];
            
        }
            break;
    }
}

//**************************************************************//

/**
 *  每选择一次参数调一次这个方法
 */
- (void)chooseProductParam:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
//    WHYNSLog(@"-----------userInfo： %@----------", userInfo);
    
    int specSign = [userInfo[@"specSign"] intValue];
    NSString *spec = userInfo[@"specId"];
    NSString *strSpec = userInfo[@"spec"];
    
    
    switch (specSign) {
        case 1:
        {
            self.productSpec.spec1 = spec;
            self.productSpec.strSpec1 = strSpec;
            [self check];
        }
            break;
        case 2:
        {
            self.productSpec.spec2 = spec;
            self.productSpec.strSpec2 = strSpec;
            [self check];
        }
            break;
        case 3:
        {
            self.productSpec.spec3 = spec;
            self.productSpec.strSpec3 = strSpec;
            [self check];
        }
            break;
            
        default:
            break;
    }
}

/**
 *  检索规格所对应的商品
 */
- (void)check
{
#warning ----------------------------------------需要细调
    switch (self.specTitles.count) {
        case 1:
        {
            for (KPProductSpec *product in self.productSpecList) {
                if (self.productSpec.spec1.integerValue == product.spec1.integerValue) {
                    self.choosePriceView.price = product.specPrice;
                    //传递已选则的参数模型
                    NSPostNote(Noti_SaveSpecModel, product)
                }
//                else {
//                    if (product.specStorage.integerValue == 0) {
//                        WHYNSLog(@"%@", [product mj_keyValues]);
//                        KPSingParamView *singleParamView1 = self.singParamViewArr[0];
//                        singleParamView1.noStorageSpec = product.spec1;
//                    }
//                }
            }
        }
            break;
        case 2:
        {
            for (KPProductSpec *product in self.productSpecList) {
                if (self.productSpec.spec1.integerValue == product.spec1.integerValue && self.productSpec.spec2.integerValue == product.spec2.integerValue) {
                    self.choosePriceView.price = product.specPrice;
                    //传递已选则的参数模型
                    NSPostNote(Noti_SaveSpecModel, product)
                }
//                else {
//                    if (product.specStorage.integerValue == 0) {
//                        WHYNSLog(@"%@", [product mj_keyValues]);
//                        KPSingParamView *singleParamView1 = self.singParamViewArr[0];
//                        singleParamView1.noStorageSpec = product.spec1;
//                        KPSingParamView *singleParamView2 = self.singParamViewArr[1];
//                        singleParamView2.noStorageSpec = product.spec2;
//                    }
//                }

            }
            
        }
            break;
        case 3:
        {
            for (KPProductSpec *product in self.productSpecList) {
                if (self.productSpec.spec1.integerValue == product.spec1.integerValue && self.productSpec.spec2.integerValue == product.spec2.integerValue && self.productSpec.spec3.integerValue == product.spec3.integerValue) {
                    self.choosePriceView.price = product.specPrice;
                    //传递已选则的参数模型
                    NSPostNote(Noti_SaveSpecModel, product)
                }
//                else {
//                    if (product.specStorage.integerValue == 0) {
//                        WHYNSLog(@"%@", [product mj_keyValues]);
//                        KPSingParamView *singleParamView1 = self.singParamViewArr[0];
//                        singleParamView1.noStorageSpec = product.spec1;
//                        KPSingParamView *singleParamView2 = self.singParamViewArr[1];
//                        singleParamView2.noStorageSpec = product.spec2;
//                        KPSingParamView *singleParamView3 = self.singParamViewArr[2];
//                        singleParamView3.noStorageSpec = product.spec3;
//                    }
//                }
            }
        }
            break;
    }
}

- (void)setCurrentPrice:(NSString *)currentPrice
{
    _currentPrice = currentPrice;
    self.choosePriceView.price = currentPrice;
}

#pragma mark - 关闭参数View和加入购物车事件
- (IBAction)close:(UIButton *)sender
{
    if (self.closeAction) {
        self.closeAction();
    }
}

- (IBAction)addToSubsize:(KPButton *)sender
{
    
    NSArray *specIdsArr = [NSArray arrayWithObjects:self.productSpec.spec1, self.productSpec.spec2, self.productSpec.spec3, nil];
    NSString *specIds = [specIdsArr componentsJoinedByString:@","];
    
    KPUpdateSubsidizeParam *parm = [KPUpdateSubsidizeParam param];
    parm.addAmount = [NSString stringWithFormat:@"%zd", self.chooseNumView.num];
    switch (self.specTitles.count) {
        case 0:
        {
            NSPostNote(Noti_AddToSubsidizeParam, parm)
        }
            break;
        case 1:
        {
            if (self.productSpec.spec1 == nil) {
                [KPProgressHUD showErrorWithStatus:@"请选择商品规格" timeInterval:2.0];
            } else {
                parm.specIds = specIds;
                NSPostNote(Noti_AddToSubsidizeParam, parm)
            }
        }
            break;
        case 2:
        {
            if (self.productSpec.spec1 == nil || self.productSpec.spec2 ==nil) {
                [KPProgressHUD showErrorWithStatus:@"请选择商品规格" timeInterval:2.0];
            } else {
                
                parm.specIds = specIds;
                NSPostNote(Noti_AddToSubsidizeParam, parm)
            }
            
        }
            break;
        case 3:
        {
            if (self.productSpec.spec1 == nil || self.productSpec.spec2 ==nil || self.productSpec.spec3 == nil) {
                [KPProgressHUD showErrorWithStatus:@"请选择商品规格" timeInterval:2.0];
            } else {
                
                parm.specIds = specIds;
                NSPostNote(Noti_AddToSubsidizeParam, parm)
            }
            
        }
            break;
    }
    
}

- (void)hiddenLines:(BOOL)hidden
{
    self.topLine.hidden = hidden;
    self.bottomLine.hidden = hidden;
}

- (void)dealloc
{
    NSRemoveObserver
}

@end
