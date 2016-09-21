//
//  KPAreaListViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAreaListViewController.h"
#import "KPAreaListCell.h"
#import "KPGetAreaParam.h"

@interface KPAreaListViewController ()



@end

@implementation KPAreaListViewController

- (void)setItemId:(NSNumber *)itemId {

    if (itemId == nil) return;

    _itemId = itemId;
    
//    WHYNSLog(@"itemId = %@", itemId);
    
    __block NSUInteger cellIndex = 0;
    
    [self.areaModel.area enumerateObjectsUsingBlock:^(KPAreaItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj.itemId isEqual:itemId]) {
            cellIndex = idx;
        }
        
//        WHYNSLog(@"obj.itemId = %@", obj.itemId);
        
    }];

//    WHYNSLog(@"cellIndex = %zd", cellIndex);
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    
}

- (void)reloadWithCurrentData {
    [self.tableView reloadData];
}

- (void)reloadDataWithParentId:(NSInteger)parentId {
    
    if (self.areaModel) return;
    
    KPGetAreaParam *param = [KPGetAreaParam param];
    param.parentId = @(parentId);
    param.deep = @(self.deep);
    
//    WHYNSLog(@"parentId = %@   deep = %@", param.parentId, param.deep);
    
    __weak typeof(self) weakSelf = self;
    [KPNetworkingTool getAreaWithParam:param success:^(id result) {
        
        NSInteger code = [result[@"code"] integerValue];
        
        if (code != 0) {
            WHYNSLog(@"%zd -- %@", code, result[@"message"]);
            return;
        }
        
        weakSelf.areaModel = [KPAreaModel mj_objectWithKeyValues:result[@"data"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.areaModel.area.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KPAreaListCell *cell = [KPAreaListCell cellWithTableView:tableView];
    cell.areaName = self.areaModel.area[indexPath.row].name;
    cell.itemId = self.areaModel.area[indexPath.row].itemId;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [KPAreaListCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.delegate respondsToSelector:@selector(listViewController:didSelectedArea:)]) {
        KPAreaItemModel *areaItem = self.areaModel.area[indexPath.row];
        [self.delegate listViewController:self didSelectedArea:areaItem];
        _itemId = areaItem.itemId;
    }
    
}

#pragma mark - 私有方法
- (void)setupTableView {
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    
}



@end
