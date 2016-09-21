//
//  KPAreaListCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAreaListCell.h"

@interface KPAreaListCell ()

@property (nonatomic, strong) UILabel *titleLB;

@end

@implementation KPAreaListCell

- (void)setAreaName:(NSString *)areaName {
    _areaName = areaName;
    
    self.titleLB.text = areaName;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.titleLB.textColor = selected ? HexColor(#ff6d15) : HexColor(#191919);
    
}

- (void)setModel:(__kindof KPBaseModel *)model {
    super.model = model;
    
    self.titleLB.text = @"全部商品";
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPCategoryCell";
    
    KPAreaListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPAreaListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

+ (CGFloat)cellHeight {
    return 45;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
-(void)setupUI {
    
    self.backgroundColor = WhiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:self.titleLB];
    [self addSubview:sep];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat left = 9;
    CGFloat sepH = 1;
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(left);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLB);
        make.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)titleLB {
    if (_titleLB == nil) {
        _titleLB = [UILabel new];
        _titleLB.font = UIFont_13;
        _titleLB.textColor = BlackColor;
    }
    return _titleLB;
}

@end
