//
//  KPMessageTableViewCellContentView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPMessageTableViewCellContentView.h"
#import "KPMessage.h"

@interface KPMessageTableViewCellContentView()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *detailLab;
@property (nonatomic, weak) UILabel *time;
@property (nonatomic, weak) UIView *line;

@end

@implementation KPMessageTableViewCellContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        UILabel *title = [[UILabel alloc] init];
        title.textColor = BlackColor;
        title.textAlignment = NSTextAlignmentLeft;
        title.font = UIFont_16;
        [self addSubview:title];
        self.title = title;
        
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.textColor = GrayColor;
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.font = UIFont_14;
        [self addSubview:detailLab];
        self.detailLab = detailLab;
        
        UILabel *time = [[UILabel alloc] init];
        time.textColor = GrayColor;
        time.textAlignment = NSTextAlignmentRight;
        time.font = UIFont_15;
        [self addSubview:time];
        self.time = time;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = SeperatorColor;
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

- (void)setMessage:(KPMessage *)message
{
    _message = message;
    self.imgView.image = [UIImage imageNamed:message.imgStr];
    self.title.text = message.titleText;
    self.detailLab.text = message.content;
    self.time.text = [NSString dateStrFromTimestamp:message.titleText withFormatter:@"MM月dd日"];
}

- (void)layoutSubviews
{
    __weak typeof (self) weakSelf = self;
    CGSize imgViewSize = self.imgView.image.size;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(CommonMargin);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(imgViewSize);
    }];
    
    CGFloat titleH = [self.title.text sizeWithAttributes:@{NSFontAttributeName: self.title.font}].height;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imgView.mas_right).offset(CommonMargin);
        make.top.mas_equalTo(weakSelf).offset(12);
        make.right.mas_equalTo(weakSelf).offset(-50);
        make.height.mas_equalTo(titleH);
    }];

    CGFloat detailLabH = [self.detailLab.text sizeWithAttributes:@{NSFontAttributeName: self.detailLab.font}].height;
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.title);
        make.bottom.mas_equalTo(weakSelf).offset(-12);
        make.right.mas_equalTo(weakSelf.title);
        make.height.mas_equalTo(detailLabH);
    }];
    
    CGFloat timeH = [self.detailLab.text sizeWithAttributes:@{NSFontAttributeName: self.time.font}].height;
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-CommonMargin);
        make.top.mas_equalTo(weakSelf).offset(12);
        make.height.mas_equalTo(timeH);
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
    
}
@end
