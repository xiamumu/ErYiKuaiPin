//
//  KPBaseViewModelCommonProtocol.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KPBaseViewModelCommonProtocol <NSObject>

@optional

- (id)getDataModel;

- (id)getCellModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

- (UIView *)viewForHeaderInSection:(NSInteger)section tableView:(UITableView *)tableView;

- (UIView *)viewForFooterInSection:(NSInteger)section tableView:(UITableView *)tableView;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;


@end
