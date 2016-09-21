//
//  KPBasePayBackView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBasePayBackView.h"
#import "KPPayBackCell.h"

@interface KPBasePayBackView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *table;

@end
@implementation KPBasePayBackView

- (NSMutableArray *)rowDatas
{
    if (_rowDatas == nil) {
        _rowDatas = [NSMutableArray array];
    }
    return _rowDatas;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsHorizontalScrollIndicator = NO;
    table.showsVerticalScrollIndicator = NO;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.rowHeight = 89;
    table.backgroundColor = ClearColor;
    [self addSubview:table];
    self.table = table;
    
    
    __weak typeof (self) weakSelf = self;
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rowDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPPayBackCell *cell = [KPPayBackCell cellWithTable:tableView];
    cell.rowData = self.rowDatas[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CommonMargin;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSPostNote(Noti_PayBackOrderDetail, nil)
    
}
@end
