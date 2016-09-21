//
//  KPBrandTableViewCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBrandTableViewCell.h"
#import "KPBrandTableViewCellContentView.h"
#import "KPBrand.h"

@interface KPBrandTableViewCell ()

@property (nonatomic, weak) KPBrandTableViewCellContentView *brnadContentView;

@end

@implementation KPBrandTableViewCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *brandTableViewCell = @"brandTableViewCell";
    KPBrandTableViewCell *cell = [table dequeueReusableCellWithIdentifier:brandTableViewCell];
    if (cell == nil) {
        cell = [[KPBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:brandTableViewCell];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPBrandTableViewCellContentView *brnadContentView = [[KPBrandTableViewCellContentView alloc] init];
        [self.contentView addSubview:brnadContentView];
        self.brnadContentView = brnadContentView;
    }
    
    return self;
}

- (void)setBrand:(KPBrand *)brand
{
    _brand = brand;
    self.brnadContentView.brand = brand;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    [self.brnadContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}

@end
