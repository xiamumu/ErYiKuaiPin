//
//  KPSubsidizeSectionHeaderView.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPVendorModel.h"
#import "KPBaseTableViewHeaderView.h"

@interface KPSubsidizeSectionHeaderView : KPBaseTableViewHeaderView

@property (nonatomic, strong) KPVendorModel *vendorModel;

@property (nonatomic, assign) NSInteger sectionIndex;

@property (nonatomic, assign) BOOL shouldShowTopSeperator;


@end
