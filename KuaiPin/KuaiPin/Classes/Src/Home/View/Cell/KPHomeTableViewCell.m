//
//  KPHomeCommonCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//  首页自定义cell

#import "KPHomeTableViewCell.h"
#import "KPHomeCellView.h"
#import "KPHomeCellTopView.h"



@interface KPHomeTableViewCell ()
@property (nonatomic, weak) KPHomeCellView *homeCellView;

@end

@implementation KPHomeTableViewCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *homeTableViewCell = @"homeTableViewCell";
    KPHomeTableViewCell *cell = [table dequeueReusableCellWithIdentifier:homeTableViewCell];
    if (cell == nil) {
        cell = [[KPHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeTableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加headerView
        KPHomeCellView *homeCellView = [[KPHomeCellView alloc] init];
        [self addSubview:homeCellView];
        self.homeCellView = homeCellView;
        __weak typeof (self) weakSelf = self;
        [homeCellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (void)setRowData:(KPHomeRowData *)rowData
{
    _rowData = rowData;
    self.homeCellView.rowData = rowData;
}
- (CGFloat)cellHeight
{
    return self.homeCellView.height;
}
@end
