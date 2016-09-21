//
//  KPHomeCellTopView.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPCommonMarginView.h"

@interface KPCommonMarginView ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *headerImage;
@end

@implementation KPCommonMarginView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *headerImage = [[UIImageView alloc] init];
        headerImage.image = [UIImage imageNamed:@"title_bg"];
        [self addSubview:headerImage];
        self.headerImage = headerImage;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = BlackColor;
        titleLabel.font = UIFont_14;
        [headerImage addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        __weak typeof (self) weakSelf = self;
        
        [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf);
            make.top.mas_equalTo(weakSelf.mas_top).offset(9);
            make.height.mas_equalTo(20);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(headerImage);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.titleLabel.text = title;
}
- (void)setHeaderImageName:(NSString *)headerImageName
{
    _headerImageName = [headerImageName copy];
    self.headerImage.image = [UIImage imageNamed:headerImageName];
}
@end
