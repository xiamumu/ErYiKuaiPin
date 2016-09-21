//
//  KPOrderCommitViewModel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderCommitViewModel.h"
#import "KPVendorModel.h"
#import "KPAddressModel.h"

// cell
#import "KPOrderCommitAddressInfoCell.h"
#import "KPOrderCommitGoodInfoCell.h"
#import "KPPaymentCell.h"
#import "KPPriceCell.h"
#import "KPOrderMessageCell.h"

// headerView
#import "KPSeparatorSectionFooterView.h"
#import "KPSeparatorSectionHeaderView.h"
#import "KPVendorSectionHeaderView.h"

const NSInteger extraCellCount = 3;

@interface KPOrderCommitViewModel ()

@property (nonatomic, assign) NSInteger orderMessageIndex;

@property (nonatomic, assign) NSInteger priceIndex;



@end

@implementation KPOrderCommitViewModel

- (NSNumber *)receiverId {
    KPAddressModel *address = self.defaultReceiver;
    return address.receiverId;
}

- (void)setTotalPrice:(CGFloat)totalPrice {
    _totalPrice = totalPrice;
    self.actualPrice = totalPrice;
}
    
- (NSString *)cartItemIds {
    
    NSMutableSet<NSNumber *> *orderItemIds = [NSMutableSet set];
    
    [self.vendors enumerateObjectsUsingBlock:^(KPVendorModel * _Nonnull vendor, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [vendor.items enumerateObjectsUsingBlock:^(KPGoodModel * _Nonnull good, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [orderItemIds addObject:good.cartItemId];
            
        }];
        
    }];
    
    return [orderItemIds.allObjects componentsJoinedByString:@","];
}

- (void)setDefaultReceiver:(id)defaultReceiver {
    
    if ([defaultReceiver isKindOfClass:[NSDictionary class]]) {
        _defaultReceiver = [KPAddressModel mj_objectWithKeyValues:defaultReceiver];
    }else {
        _defaultReceiver = defaultReceiver;
    }
    
}

#pragma mark - 公共方法
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    KPBaseTableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        cell = [KPOrderCommitAddressInfoCell cellWithTableView:tableView];
        cell.model = self.defaultReceiver;
        
    }
    else if (indexPath.section == self.priceIndex) {
        
        KPPriceCell *priceCell = [KPPriceCell cellWithTableView:tableView];
        cell = priceCell;
        priceCell.totalPrice = self.totalPrice;
        priceCell.freight = 0;

    }
    else if (indexPath.section == self.orderMessageIndex) {
        KPOrderMessageCell *messageCell = [KPOrderMessageCell cellWithTableView:tableView];
        cell = messageCell;
        __weak typeof(self) weakSelf = self;
        [messageCell setChangedOrderMessage:^(NSString *orderMessage) {
            weakSelf.orderMessage = orderMessage;
        }];
    }
    else {
        
        KPOrderCommitGoodInfoCell *goodCell = [KPOrderCommitGoodInfoCell cellWithTableView:tableView];
        goodCell.model = self.vendors[indexPath.section-1].items[indexPath.row];
        cell = goodCell;
        
        if (indexPath.row < [self numberOfRowsInSection:indexPath.section] - 1) {
            goodCell.showBottomSep = YES;
        }else {
            goodCell.showBottomSep = NO;
        }
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (NSInteger)numberOfSections {
    
    if (self.vendors.count == 0) {
        return 0;
    }
    
    return self.vendors.count + extraCellCount;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == self.priceIndex || section == self.orderMessageIndex) {
        return 1;
    }
    
    return self.vendors[section-1].items.count;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [KPOrderCommitAddressInfoCell cellHeight];
    }

    if (indexPath.section == self.priceIndex) {
        return [KPPriceCell cellHeight];
    }

    if (indexPath.section == self.orderMessageIndex) {
        return [KPOrderMessageCell cellHeight];
    }
    
    return [KPOrderCommitGoodInfoCell cellHeight];
}

- (UIView *)viewForHeaderInSection:(NSInteger)section tableView:(UITableView *)tableView {
    
    if (section == 0 || section == self.priceIndex || section == self.orderMessageIndex) {
        return [KPSeparatorSectionHeaderView headerViewWithTableView:tableView];
    }
    
    KPVendorSectionHeaderView *vendorHeaderView = [KPVendorSectionHeaderView headerViewWithTableView:tableView];
    vendorHeaderView.vendorModel = self.vendors[section-1];
    
    return vendorHeaderView;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0 || section == self.priceIndex || section == self.orderMessageIndex) {
        return [KPSeparatorSectionHeaderView headerViewHeight];
    }
    
    return [KPVendorSectionHeaderView headerViewHeight];
}

- (UIView *)viewForFooterInSection:(NSInteger)section tableView:(UITableView *)tableView {
    
    if (section == [self numberOfSections] - 1) {
        return [KPSeparatorSectionFooterView footerViewWithTableView:tableView];
    }
    
    return [KPSeparatorView new];
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    
    if (section == [self numberOfSections] - 1) {
        return 14;
    }
    
    return 1;
}

#pragma mark - 懒加载
- (NSInteger)priceIndex {
    return [self numberOfSections] - 1;
}

- (NSInteger)orderMessageIndex {
    return [self numberOfSections] - 2;
}

singleton_implementation(ViewModel)


@end
