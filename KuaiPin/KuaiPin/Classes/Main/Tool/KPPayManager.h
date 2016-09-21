//
//  KPPayManager.h
//  KuaiPin
//
//  Created by 王洪运 on 16/7/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "UPPaymentControl.h"

@interface KPPayManager : NSObject
/// 单例
+ (instancetype)sharedManager;

/// 设置支付回调url
///
/// @param url 回调url
+ (BOOL)handleOpenURL:(NSURL *)url;

#pragma mark - 微信支付
/// 获取微信安装url
///
/// @return 微信安装url
+ (NSURL *)weixinInstallURL;

/// 微信支付完成回调
///
/// @param handler 支付完成回调
+ (void)weiPayCompletionHandler:(void(^)(int errCode))handler;

/// 发起微信支付
///
/// @param orderSn    订单号
/// @param totalPrice 订单金额
/// @param handler    完成block
+ (void)weiPayWithOrderSn:(NSString *)orderSn
               totalPrice:(NSNumber *)totalPrice
        completionHandler:(void(^)(NSString *resultStr))handler;

#pragma mark - 支付宝支付
/// 发起支付宝支付
///
/// @param order           订单号
/// @param order           订单金额
+ (void)aliPayOrder:(NSString *)order
           totalFee:(NSNumber *)totalFee
         completion:(void(^)(BOOL success))completion;

///【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，
/// 请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
///
/// @param otherCallBack 另一个回调block
+ (void)aliPayOtherCallBack:(void (^)(NSDictionary *resultDic))otherCallBack;

#pragma mark - 银联支付
/// 发起银联支付
///
/// @param orderSn 订单号
/// @param vc      发起银联支付的控制器
+ (void)upPayWithOrderSn:(NSString *)orderSn
                totalFee:(NSNumber *)totalFee
          bankCardNumber:(NSNumber *)bankCardNumber
          viewController:(__kindof UIViewController  *)vc;

/// 银联支付完成block
///
/// @param completionBlock block
+ (void)upPayCompleteBlock:(void(^)(NSString *resultStr))completionBlock;

#pragma mark - 零钱支付
/// 发起零钱支付
///
/// @param orderSn    订单号
/// @param totalPrice 订单金额
/// @param handler    完成block
+ (void)balancePayWithOrderSn:(NSString *)orderSn
                   totalPrice:(NSNumber *)totalPrice
                  payPassword:(NSString *)payPassword
            completionHandler:(void(^)(NSInteger code, NSString *paymentTime))handler;

#pragma mark - 京东支付
/// 发起京东支付
///
/// @param orderSn    订单号
/// @param totalPrice 订单金额
/// @param handler    完成block
+ (void)jdPayWithOrderSn:(NSString *)orderSn
              totalPrice:(NSNumber *)totalPrice
       completionHandler:(void(^)(NSString *resultStr))handler;

@end
