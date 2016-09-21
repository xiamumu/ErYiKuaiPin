//
//  KPProfileFooderCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPProfileFooderCell.h"
#import "KPProfileItem.h"
#import "KPProfileItemData.h"

@interface KPProfileFooderCell ()

@property (nonatomic, weak) KPButton *phoneBtn;

@end

@implementation KPProfileFooderCell


+ (instancetype)cellWithTable:(UITableView *)table handler:(PhoneButtonHandler)handler
{
    static NSString *profileFooderCell = @"profileFooderCell";
    KPProfileFooderCell *cell = [table dequeueReusableCellWithIdentifier:profileFooderCell];
    if (cell == nil) {
        cell = [[KPProfileFooderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:profileFooderCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = WhiteColor;
    cell.handler = handler;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPButton *phoneBtn = [[KPButton alloc] init];
        phoneBtn.backgroundColor = HexColor(#7ecef4);
        [phoneBtn setTitle:@"客服电话: 400-9921-365" forState:UIControlStateNormal];
        [phoneBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        phoneBtn.titleLabel.font = UIFont_13;
        [phoneBtn setImage:[UIImage imageNamed:@"my_service"] forState:UIControlStateNormal];
        phoneBtn.adjustsImageWhenHighlighted = NO;
        phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -19, 0, 0);
        phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        [phoneBtn addTarget:self action:@selector(takeCall:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:phoneBtn];
        self.phoneBtn = phoneBtn;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof (self.contentView) weakSelf = self.contentView;
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(228, 49));
    }];
}

- (void)takeCall:(KPButton *)phoneBen
{
    if (self.handler) {
        self.handler();
    }
}


@end
