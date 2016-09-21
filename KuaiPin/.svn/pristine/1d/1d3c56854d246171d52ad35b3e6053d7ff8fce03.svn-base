//
//  KPAccountSafeTableViewCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAccountSafeTableViewCell.h"
#import "KPAccountRowData.h"
#import "KPAccountSafeCellContentView.h"

@interface KPAccountSafeTableViewCell ()

@property (nonatomic, weak) KPAccountSafeCellContentView *accountContentView;

@end
@implementation KPAccountSafeTableViewCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *accountSafeTableViewCell = @"accountSafeTableViewCell";
    KPAccountSafeTableViewCell *cell = [table dequeueReusableCellWithIdentifier:accountSafeTableViewCell];
    if (cell == nil) {
        cell = [[KPAccountSafeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:accountSafeTableViewCell];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPAccountSafeCellContentView *accountContentView = [[KPAccountSafeCellContentView alloc] init];
        [self.contentView addSubview:accountContentView];
        self.accountContentView = accountContentView;
    }
    
    return self;
}

- (void)setRowData:(KPAccountRowData *)rowData
{
    _rowData = rowData;
    self.accountContentView.titleText = rowData.titleText;
    self.accountContentView.detailText = rowData.detailText;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    [self.accountContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}
@end
