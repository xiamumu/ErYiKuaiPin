//
//  KPAreaListViewController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPAreaModel.h"

@class KPAreaListViewController;

@protocol KPAreaListViewControllerDelegate <NSObject>

- (void)listViewController:(KPAreaListViewController *)listViewController
           didSelectedArea:(KPAreaItemModel *)area;

@end

@interface KPAreaListViewController : UITableViewController

@property (nonatomic, weak) id<KPAreaListViewControllerDelegate> delegate;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, assign) NSInteger deep;

@property (nonatomic, strong) NSNumber *itemId;

@property (nonatomic, strong) KPAreaModel *areaModel;

- (void)reloadDataWithParentId:(NSInteger)parentId;

@end
