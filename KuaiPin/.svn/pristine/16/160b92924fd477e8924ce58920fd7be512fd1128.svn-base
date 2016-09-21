//
//  KPGetExptessInfoCellContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/7/21.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGetExptessInfoCellContentView.h"
#import "KPExpressInfo.h"

@interface KPGetExptessInfoCellContentView ()

@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UILabel *timeLab;
@property (nonatomic, weak) UIImageView *circleImgView;
@property (nonatomic, weak) UIImageView *lineImgView;

@end

@implementation KPGetExptessInfoCellContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *lineImgView = [[UIImageView alloc] init];
        lineImgView.image = [UIImage imageNamed:@"expressLine"];
        [self addSubview:lineImgView];
        self.lineImgView = lineImgView;
        
        UIImageView *circleImgView = [[UIImageView alloc] init];
        circleImgView.image = [UIImage imageNamed:@"expressCircle_normal"];
        [self addSubview:circleImgView];
        self.circleImgView = circleImgView;
        
        UILabel *titleLab = [UILabel addLabelWithTitle:nil textColor:BlackColor font:UIFont_15];
        titleLab.numberOfLines = 0;
        titleLab.contentMode = UIViewContentModeTopLeft;
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        UILabel *timeLab = [UILabel addLabelWithTitle:nil textColor:GrayColor font:UIFont_12];
        [self addSubview:timeLab];
        self.timeLab = timeLab;

        __weak typeof (self) weakSelf = self;
        CGSize circleImgSize = self.circleImgView.image.size;
        [self.circleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).offset(20);
            make.top.mas_equalTo(weakSelf).offset(CommonMargin + 2);
            make.size.mas_equalTo(circleImgSize);
        }];
    }
    return self;
}


- (void)setExpressInfoCellFrame:(KPExpressInfoCellFrame *)expressInfoCellFrame
{
    _expressInfoCellFrame = expressInfoCellFrame;
    
    KPExpressInfo *expressInfo = expressInfoCellFrame.expressInfo;
    
    self.timeLab.text = expressInfo.time;
    
    self.titleLab.text = expressInfo.context;
    
    self.titleLab.frame = expressInfoCellFrame.titleLabFrame;
    
    self.timeLab.frame = expressInfoCellFrame.timeFrame;
}

- (void)setExpressInfoCellFrameCount:(NSUInteger)expressInfoCellFrameCount
{
    _expressInfoCellFrameCount = expressInfoCellFrameCount;
    
    if (expressInfoCellFrameCount == 1) {
        
        self.circleImgView.image = [UIImage imageNamed:@"expressCircle_selected"];
        self.lineImgView.hidden = YES;
        
    } else  {
        
        self.circleImgView.image = [UIImage imageNamed:@"expressCircle_normal"];
        self.lineImgView.hidden = NO;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (self.expressInfoCellFrameCount != 0) {
        
        __weak typeof (self) weakSelf = self;
        CGSize lineImgViewSize = self.lineImgView.image.size;
        
        if (indexPath.row == 0) {
            
            self.circleImgView.image = [UIImage imageNamed:@"expressCircle_selected"];
            
            [self.lineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.circleImgView.mas_bottom);
                make.bottom.mas_equalTo(weakSelf);
                make.centerX.mas_equalTo(weakSelf.circleImgView.mas_centerX);
                make.width.mas_equalTo(lineImgViewSize.width);
            }];
        } else if (indexPath.row == self.expressInfoCellFrameCount - 1) {
            [self.lineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(weakSelf.circleImgView.mas_bottom);
                make.top.mas_equalTo(weakSelf);
                make.centerX.mas_equalTo(weakSelf.circleImgView.mas_centerX);
                make.width.mas_equalTo(lineImgViewSize.width);
            }];
        } else {
            
            [self.lineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(weakSelf);
                make.centerX.mas_equalTo(weakSelf.circleImgView.mas_centerX);
                make.width.mas_equalTo(lineImgViewSize.width);
            }];
        }
        
    }
}
@end
