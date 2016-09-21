//
//  KPLikeBrandCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPLikeBrandCell.h"
#import "KPBrand.h"
#import "KPLikeBrandCellContentView.h"

@interface KPLikeBrandCell ()
@property (nonatomic, weak) KPLikeBrandCellContentView *likeBrandCellContentView;

@end

@implementation KPLikeBrandCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *likeBrandCell = @"likeBrandCell";
    KPLikeBrandCell *cell = [table dequeueReusableCellWithIdentifier:likeBrandCell];
    if (cell == nil) {
        cell = [[KPLikeBrandCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:likeBrandCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPLikeBrandCellContentView *likeBrandCellContentView = [[KPLikeBrandCellContentView alloc] init];
        [self.contentView addSubview:likeBrandCellContentView];
        self.likeBrandCellContentView = likeBrandCellContentView;
        
        __weak typeof (self) weakSelf = self;
        [likeBrandCellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (void)setBrand:(KPBrand *)brand
{
    _brand = brand;
    self.likeBrandCellContentView.brand = brand;
    
}

@end
