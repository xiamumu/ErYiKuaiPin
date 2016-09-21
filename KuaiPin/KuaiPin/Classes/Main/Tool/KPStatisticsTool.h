//
//  KPStatisticsTool.h
//  KuaiPin
//
//  Created by 王洪运 on 16/7/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KPStatisticsBeginWithViewName(viewName) [KPStatisticsTool beginWithViewName:viewName];
#define KPStatisticsEndWithViewName(viewName) [KPStatisticsTool endWithViewName:viewName];

@interface KPStatisticsTool : NSObject

/// 注册友盟统计
+ (void)registUMAnalyticsConfig;

/// 查看需要测试的设备Id，
+ (void)lookupDeviceId;

/// 开始统计页面
///
/// @param viewName 页面名称
+ (void)beginWithViewName:(NSString *)viewName;

/// 结束统计页面
///
/// @param viewName 页面名称
+ (void)endWithViewName:(NSString *)viewName;



/// 自定义统计时间---计数事件
///
/// @param viewName 计数事件id名称
+ (void)event:(NSString *)eventId;

/// 自定义统计时间---计数事件
///
/// @param viewName 计数事件id名称
+ (void)event:(NSString *)eventId label:(NSString *)label;

@end

UIKIT_EXTERN NSString * const HomeStatistics;
UIKIT_EXTERN NSString * const CategoryStatistics;
UIKIT_EXTERN NSString * const DiscoverStatistics;
UIKIT_EXTERN NSString * const SubsidizeStatistics;
UIKIT_EXTERN NSString * const ProfileStatistics;
UIKIT_EXTERN NSString * const GoodDetailStatistics;
UIKIT_EXTERN NSString * const GoodListStatistics;
UIKIT_EXTERN NSString * const BrandStatistics;
UIKIT_EXTERN NSString * const ShopStatistics;
UIKIT_EXTERN NSString * const WebStatistics;
UIKIT_EXTERN NSString * const IntroduceStatistics;
UIKIT_EXTERN NSString * const AccountSafeStatistics;
UIKIT_EXTERN NSString * const AccountManageStatistics;
UIKIT_EXTERN NSString * const ChangeUserNickNameStatistics;
UIKIT_EXTERN NSString * const BeLeftMoneyStatistics;
UIKIT_EXTERN NSString * const TakeBackMoneyStatistics;
UIKIT_EXTERN NSString * const PlusBankCardStatistics;
UIKIT_EXTERN NSString * const FootTraceStatistics;
UIKIT_EXTERN NSString * const GoodsCollectionStatistics;
UIKIT_EXTERN NSString * const PayBackDetailStatistics;
UIKIT_EXTERN NSString * const LikeBrandStatistics;
UIKIT_EXTERN NSString * const FeedBackStatistics;
UIKIT_EXTERN NSString * const UnPayBackStatistics;
UIKIT_EXTERN NSString * const CanPayBackStatistics;
UIKIT_EXTERN NSString * const FinishPayBackStatistics;
UIKIT_EXTERN NSString * const AllOrderStatistics;
UIKIT_EXTERN NSString * const CancelOrderStatistics;
UIKIT_EXTERN NSString * const FinishOrderStatistics;
UIKIT_EXTERN NSString * const UnPayOrderStatistics;
UIKIT_EXTERN NSString * const UnReceiveStatistics;
UIKIT_EXTERN NSString * const BankCardManageStatistics;
UIKIT_EXTERN NSString * const AuthenticationStatistics;
UIKIT_EXTERN NSString * const CertificationStatistics;
UIKIT_EXTERN NSString * const BankCardInputStatistics;
UIKIT_EXTERN NSString * const ChangePwdStatistics;
UIKIT_EXTERN NSString * const ChangePhoneStatistics;
UIKIT_EXTERN NSString * const NewPhoneStatistics;
UIKIT_EXTERN NSString * const ChangePayPwdStatistics;
UIKIT_EXTERN NSString * const PayPwdStatistics;
UIKIT_EXTERN NSString * const NewPayPwdStatistics;
UIKIT_EXTERN NSString * const OrderCommitStatistics;
UIKIT_EXTERN NSString * const OrderDetailStatistics;
UIKIT_EXTERN NSString * const OrderCommitCompletionStatistics;
UIKIT_EXTERN NSString * const AddressListStatistics;
UIKIT_EXTERN NSString * const AddressManageStatistics;
UIKIT_EXTERN NSString * const MessageStatistics;
UIKIT_EXTERN NSString * const CommitAuthCodeStatistics;
UIKIT_EXTERN NSString * const SearchStatistics;






