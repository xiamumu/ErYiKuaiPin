//
//  KPShopSectionHeader.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPSortBar;

@protocol KPSortBarDelegate <NSObject>

- (void)SortBar:(KPSortBar *)sortBar didSelectedPriceBtn:(KPButton *)priceBtn otherBtnSalesBtn:(KPButton *)salesBtn andHotBtn:(KPButton *)hotBtn;
- (void)SortBar:(KPSortBar *)sortBar didSelectedSalesBtn:(KPButton *)salesBtn otherBtnPriceBtn:(KPButton *)priceBtn andHotBtn:(KPButton *)hotBtn;
- (void)SortBar:(KPSortBar *)sortBar didSelectedHotBtn:(KPButton *)hotBtn otherBtnPriceBtn:(KPButton *)priceBtn andSalesBtn:(KPButton *)salesBtn;;

@end

@interface KPSortBar : UIView

@property (nonatomic, assign) id <KPSortBarDelegate> delegate;

@end
