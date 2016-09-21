//
//  KPTakeBackMoneyCellContentView.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPBankCardModel;
@interface KPTakeBackMoneyCellContentView : UIView

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) KPBankCardModel *card;

@end
