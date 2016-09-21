//
//  KPMySelfCommonView.h
//  KuaiPin
//
//  Created by 21_xm on 16/8/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPMySelfCommonView : UIView


+ (instancetype)commonView;

@property (nonatomic, strong) NSArray *itemNames;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

/**
 *  未付款的按钮数字
 */
@property (nonatomic, copy) NSString *unPayOrderNum;


/**
 *  未收货的按钮数字
 */
@property (nonatomic, copy) NSString *unReceiveOrderNum;



@end
