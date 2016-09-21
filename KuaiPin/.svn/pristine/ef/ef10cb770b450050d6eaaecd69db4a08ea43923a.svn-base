//
//  KPAccountSafeCellContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAccountSafeCellContentView.h"

@interface KPAccountSafeCellContentView ()
@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UILabel *detailLab;
@property (nonatomic, weak) UIImageView *arrowImg;
@property (nonatomic, weak) UIView *line;
@end
@implementation KPAccountSafeCellContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = BlackColor;
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.font = UIFont_16;
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.textColor = OrangeColor;
        detailLab.textAlignment = NSTextAlignmentRight;
        detailLab.font = UIFont_14;
        [self addSubview:detailLab];
        self.detailLab = detailLab;
        
        UIImageView *arrowImg = [[UIImageView alloc] init];
        arrowImg.image = [UIImage imageNamed:@"brand_nexticon"];
        [self addSubview:arrowImg];
        self.arrowImg = arrowImg;
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = SeperatorColor;
        [self addSubview:line];
        self.line = line;
        
    }
    return self;
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = [titleText copy];
    self.titleLab.text = titleText;
}

- (void)setDetailText:(NSString *)detailText
{
    _detailText = [detailText copy];
    self.detailLab.text = detailText;
}

- (void)layoutSubviews
{
    
    __weak typeof (self) weakSelf = self;
    
    CGFloat titleLabH = [self.titleLab.text sizeWithAttributes:@{NSFontAttributeName: self.titleLab.font}].height;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(9);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(titleLabH);
    }];
    
    CGSize arrowSize = self.arrowImg.image.size;
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-9);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(arrowSize);
    }];
    
    CGFloat detailLabH = [self.detailLab.text sizeWithAttributes:@{NSFontAttributeName: self.detailLab.font}].height;
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowImg.mas_left).offset(-9);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(detailLabH);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
}
@end
