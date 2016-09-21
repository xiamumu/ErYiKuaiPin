//
//  KPSingParamView.m
//  KuaiPin
//
//  Created by 21_xm on 16/8/31.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSingParamView.h"
#import "KPProductSpec.h"

@interface KPSingParamView ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, strong) NSMutableArray *tagBtnArr;

@end


@implementation KPSingParamView

//*********************************************************//
- (NSMutableArray *)tagBtnArr
{
    if (_tagBtnArr == nil) {
        _tagBtnArr = [NSMutableArray array];
    }
    return _tagBtnArr;
}
//*********************************************************//

+ (instancetype)singParamView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.width = SCREEN_W;
        
        UILabel *titleLab = [UILabel addLabelWithTitle:nil textColor:HexColor(8a8a8a) font:UIFont_15];
        titleLab.frame = CGRectMake(12, 16, SCREEN_W - 24, 16);
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.titleLab.text = title;
}

- (void)setSubTitles:(NSArray *)subTitles
{
    _subTitles = subTitles;
    
    CGFloat left_right_margin = 12;
    CGFloat mid_margin = 15;
    CGFloat tagBtn_X = left_right_margin;
    CGFloat tagBtn_Y = 50;
    CGFloat tagBtnMax_Y = 0;
    
    for (int i = 0; i < self.subTitles.count ; i++) {
        KPTagButton *tagBtn = [KPTagButton new];
        tagBtn.name = self.subTitles[i];
        tagBtn.nameId = self.subTitlesId[i];
        
        
        [tagBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tagBtn];
        [self.tagBtnArr addObject:tagBtn];
    
        CGFloat tagBtn_W = tagBtn.width;
        if ((tagBtn_X + tagBtn_W  + left_right_margin) > SCREEN_W) {
            tagBtn_Y = tagBtnMax_Y + mid_margin;
            tagBtn_X = left_right_margin;
        }
        
        tagBtn.x = tagBtn_X;
        tagBtn.y = tagBtn_Y;
        
        tagBtnMax_Y = CGRectGetMaxY(tagBtn.frame);
        tagBtn_X = CGRectGetMaxX(tagBtn.frame) + mid_margin;
        
        self.height = CGRectGetMaxY(tagBtn.frame);
        
    }
}

//**************************************************************//
// 设置存储的参数
- (void)setSelectedTagSpec:(NSString *)selectedTagSpec
{
    _selectedTagSpec = [selectedTagSpec copy];
    if ([self.subTitlesId containsObject:selectedTagSpec]) {
        KPTagButton *tagBtn = self.tagBtnArr[[self.subTitlesId indexOfObject:selectedTagSpec]];
        tagBtn.selected = YES;
    }
//    for (int i = 0; i < self.subTitlesId.count ; i++) {
//    }
}
//**************************************************************//
// 设置无库存状态显示
- (void)setNoStorageSpec:(NSString *)noStorageSpec
{
    _noStorageSpec = [noStorageSpec copy];
    
    if ([self.subTitlesId containsObject:noStorageSpec]) {
        KPTagButton *tagBtn = self.tagBtnArr[[self.subTitlesId indexOfObject:noStorageSpec]];
        tagBtn.enabled = NO;
    }
}

//**************************************************************//

- (void)chooseAction:(KPTagButton *)btn
{
    for (KPTagButton *tagBtn in self.tagBtnArr) {
        tagBtn.selected = NO;
    }
    self.selectedSpec.selected = NO;
    btn.selected = YES;
    self.selectedSpec = btn;
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[@"spec"] = btn.name;
    info[@"specId"] = btn.nameId;
    info[@"specSign"] = @(self.specSign);
    
    // 发出点击单个参数的通知
    NSPostNoteWithUserInfo(Noti_ChooseProductParam, nil, info)
    
//    WHYNSLog(@"------tabBtnId :%@", btn.nameId);
    
}
@end
