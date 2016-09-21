//
//  KPStatisticsTool.m
//  KuaiPin
//
//  Created by 王洪运 on 16/7/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPStatisticsTool.h"
#import <UMMobClick/MobClick.h>

NSString * const UMAppKey = @"578467b367e58e0d96001678";

@implementation KPStatisticsTool

+ (void)beginWithViewName:(NSString *)viewName {
    [MobClick beginLogPageView:viewName];
}

+ (void)endWithViewName:(NSString *)viewName {
    [MobClick endLogPageView:viewName];
}

+ (void)registUMAnalyticsConfig {
    
    UMConfigInstance.channelId = @"App Store";NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    UMConfigInstance.appKey = UMAppKey;
    UMConfigInstance.channelId = @"App Store";
//    [MobClick setLogEnabled:YES];
    [MobClick startWithConfigure:UMConfigInstance];

}

/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 
 @param  eventId 网站上注册的事件Id.
 @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为nil或空字符串时后台会生成和eventId同名的标签.
 @param  accumulation 累加值。为减少网络交互，可以自行对某一事件ID的某一分类标签进行累加，再传入次数作为参数。
 @return void.
 */
+ (void)event:(NSString *)eventId
{
    [MobClick event:eventId];
}

+ (void)event:(NSString *)eventId label:(NSString *)label
{
    [MobClick event:eventId label:label];
}


+ (void)lookupDeviceId {

//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//
//    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);

}

@end

//NSString * const HomeStatistics = @"首页";
//NSString * const CategoryStatistics = @"分类";
//NSString * const DiscoverStatistics = @"发现";
//NSString * const SubsidizeStatistics = @"G库";
//NSString * const ProfileStatistics = @"我的";
//NSString * const GoodDetailStatistics = @"商品详情";
//NSString * const GoodListStatistics = @"商品列表";
//NSString * const BrandStatistics = @"品牌商列表";
//NSString * const ShopStatistics = @"店铺";
//NSString * const WebStatistics = @"H5页面";
//NSString * const IntroduceStatistics = @"二一快品简介";
//NSString * const AccountSafeStatistics = @"账户安全";
//NSString * const AccountManageStatistics = @"账户管理";
//NSString * const ChangeUserNickNameStatistics = @"更改用户昵称";
//NSString * const BeLeftMoneyStatistics = @"余额";
//NSString * const TakeBackMoneyStatistics = @"余额提现/充值";
//NSString * const PlusBankCardStatistics = @"添加银行卡";
//NSString * const FootTraceStatistics = @"足迹";
//NSString * const GoodsCollectionStatistics = @"商品收藏";
//NSString * const PayBackDetailStatistics = @"补贴详情";
//NSString * const LikeBrandStatistics = @"店铺收藏";
//NSString * const FeedBackStatistics = @"意见反馈";
//NSString * const UnPayBackStatistics = @"未贴现列表";
//NSString * const CanPayBackStatistics = @"可贴现列表";
//NSString * const FinishPayBackStatistics = @"贴现完成列表";
//NSString * const AllOrderStatistics = @"所有订单";
//NSString * const CancelOrderStatistics = @"已取消订单";
//NSString * const FinishOrderStatistics = @"完成订单";
//NSString * const UnPayOrderStatistics = @"未支付订单";
//NSString * const UnReceiveStatistics = @"未收货订单";
//NSString * const BankCardManageStatistics = @"银行卡管理";
//NSString * const AuthenticationStatistics = @"输入支付密码";
//NSString * const CertificationStatistics = @"姓名及身份证";
//NSString * const BankCardInputStatistics = @"输入银行卡信息";
//NSString * const ChangePwdStatistics = @"改变登录密码";
//NSString * const ChangePhoneStatistics = @"改变手机号";
//NSString * const NewPhoneStatistics = @"新手机号";
//NSString * const ChangePayPwdStatistics = @"改变支付密码";
//NSString * const PayPwdStatistics = @"支付密码";
//NSString * const NewPayPwdStatistics = @"新支付密码";
//NSString * const OrderCommitStatistics = @"订单提交";
//NSString * const OrderDetailStatistics = @"订单详情";
//NSString * const OrderCommitCompletionStatistics = @"订单支付完成";
//NSString * const AddressListStatistics = @"收货地址列表";
//NSString * const AddressManageStatistics = @"收货地址管理";
//NSString * const MessageStatistics = @"消息";
//NSString * const CommitAuthCodeStatistics = @"验证短信";
//NSString * const SearchStatistics = @"搜索";
