//
//  KPChangeAuthCodeViewController.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/7.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KPCommitAuthCodeType) {
    KPCommitAuthCodeTypeNormal,
    KPCommitAuthCodeTypeChangePhoneNext,
    KPCommitAuthCodeTypeChangePhoneDone,
    KPCommitAuthCodeTypeChangePayPwdNext,
    KPCommitAuthCodeTypeAddBankCard,
};

@interface KPCommitAuthCodeViewController : UIViewController

@property (nonatomic, assign) KPCommitAuthCodeType commitType;

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, strong) NSNumber *bankCardPreId;

@property (nonatomic, strong) __kindof UIViewController *willPopToVc;

@end
