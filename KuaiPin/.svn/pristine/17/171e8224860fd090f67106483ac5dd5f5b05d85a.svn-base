//
//  KPBeLeftMoneyCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/12.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBeLeftMoneyCell.h"
#import "KPBeLeftMoneyContentViwe.h"

@interface KPBeLeftMoneyCell ()

@property (nonatomic, weak) KPBeLeftMoneyContentViwe *beLeftMoneyContentViwe;

@end

@implementation KPBeLeftMoneyCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *beLeftMoneyCell = @"beLeftMoneyCell";
    KPBeLeftMoneyCell *cell = [table dequeueReusableCellWithIdentifier:beLeftMoneyCell];
    if (cell == nil) {
        cell = [[KPBeLeftMoneyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:beLeftMoneyCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPBeLeftMoneyContentViwe *beLeftMoneyContentViwe = [[KPBeLeftMoneyContentViwe alloc] init];
        [self.contentView addSubview:beLeftMoneyContentViwe];
        self.beLeftMoneyContentViwe = beLeftMoneyContentViwe;
        
        __weak typeof (self) weakSelf = self;
        [self.beLeftMoneyContentViwe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (void)setRowData:(KPBeLeftMoneyRowData *)rowData
{
    _rowData = rowData;
    self.beLeftMoneyContentViwe.rowData = rowData;
}

@end
