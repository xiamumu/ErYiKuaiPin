//
//  KPGetExpressInfoViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/7/21.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGetExpressInfoViewController.h"
#import "KPGetExpressInfoParam.h"
#import "KPGetExpressInfoCell.h"
#import "KPExpressInfo.h"
#import "KPExpressInfoCellFrame.h"

@interface KPGetExpressInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <KPExpressInfoCellFrame *> *expressInfoCellFrames;

@end

@implementation KPGetExpressInfoViewController

- (NSMutableArray *)expressInfoCellFrames
{
    if (_expressInfoCellFrames == nil) {
        _expressInfoCellFrames = [NSMutableArray array];
    }
    return _expressInfoCellFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流详情";
    self.view.backgroundColor = WhiteColor;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self GetExpressInfo];
}

- (void)GetExpressInfo
{
    KPGetExpressInfoParam *param = [KPGetExpressInfoParam param];
    param.expresssn = self.expresssn;
    param.expresscode = self.expresscode;
    
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool GetExpressInfoWithParam:param success:^(id result) {
        
        if (CODE == 0) {
            
            NSArray *expressInfos = [KPExpressInfo mj_objectArrayWithKeyValuesArray:result[@"data"][@"expressData"][@"jsonResult"][@"lastResult"][@"data"]];

            for (KPExpressInfo *expressInfo in expressInfos) {
                KPExpressInfoCellFrame *cellFrame = [[KPExpressInfoCellFrame alloc] init];
                cellFrame.expressInfo = expressInfo;
                [weakSelf.expressInfoCellFrames addObject:cellFrame];
            }
            
            [weakSelf.tableView reloadData];
            
        } else {
            
            [KPProgressHUD showErrorWithStatus:@"物流信息获取失败,请稍后重试"];
            return;
        }
        
    } failure:^(NSError *error) { [KPProgressHUD showErrorWithStatus:@"物流信息获取失败,请稍后重试"]; }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.expressInfoCellFrames.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KPGetExpressInfoCell *cell = [KPGetExpressInfoCell cellWithTable:tableView];
    cell.expressInfoCellFrame = self.expressInfoCellFrames[indexPath.row];
    cell.expressInfoCellFrameCount = self.expressInfoCellFrames.count;
    cell.indexPath = indexPath;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPExpressInfoCellFrame *cellFrame = self.expressInfoCellFrames[indexPath.row];
    return cellFrame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CommonMargin;
}

@end
