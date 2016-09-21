//
//  KPPayManager.m
//  KuaiPin
//
//  Created by 王洪运 on 16/7/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPPayManager.h"
#import "KPOrderPayParam.h"
#import "KPBalancePayParam.h"

@interface KPPayManager ()<WXApiDelegate>

@property (nonatomic, copy) void (^aliPayCompletionHandler)(NSDictionary *resultDic);
@property (nonatomic, copy) void (^weiPayCompletionHandler)(int errCode);
@property (nonatomic, copy) void (^upPayCompletionHandler)(NSString *resultStr);

@end

@implementation KPPayManager

/// 设置支付回调url
///
/// @param url 回调url
+ (BOOL)handleOpenURL:(NSURL *)url {
    if (!url) return NO;
    [self aliPayHandleOpenURL:url];
    [self upPayHandleOpenURL:url];
    return [self weiPayHandleOpenURL:url];
}

#pragma mark - 微信支付
+ (BOOL)weiPayHandleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[KPPayManager sharedManager]];
}

/// 获取微信安装url
///
/// @return 微信安装url
+ (NSURL *)weixinInstallURL {
    return [NSURL URLWithString:[WXApi getWXAppInstallUrl]];
}

/// 微信支付完成回调
///
/// @param handler 支付完成回调
+ (void)weiPayCompletionHandler:(void(^)(int errCode))handler {
    if (!handler) return;
    [KPPayManager sharedManager].weiPayCompletionHandler = handler;
}

// 支付跳转
/// 发起微信支付
///
/// @param orderSn    订单号
/// @param totalPrice 订单金额
/// @param handler    完成block
+ (void)weiPayWithOrderSn:(NSString *)orderSn
               totalPrice:(NSNumber *)totalPrice
        completionHandler:(void(^)(NSString *resultStr))handler {
    if (!orderSn || !totalPrice || !handler) return;

//#warning 
//    totalPrice = @0.01;

    KPOrderPayParam *param = [KPOrderPayParam param];
    param.orderSn = orderSn;
    param.totalFee = [NSString stringWithFormat:@"%zd", (int)(totalPrice.floatValue * 100)];
    __block NSString *resultStr = [NSString string];

    [KPProgressHUD showLoading];

    [KPNetworkingTool weixinPayWithParam:param success:^(id result) {

        if (result == nil) {
            resultStr = @"服务器返回错误，未获取到json对象";
        }else {

            NSString *retcode = result[@"trade_state"];

            if (retcode.length != 0) {
                resultStr = @"失败";
            }else {

                if ([WXApi isWXAppInstalled]) {
                    NSMutableString *stamp  = [result objectForKey:@"timestamp"];
                    //调起微信支付
                    PayReq* req             = [PayReq new];
                    req.partnerId           = [result objectForKey:@"partnerid"];
                    req.prepayId            = [result objectForKey:@"prepayid"];
                    req.nonceStr            = [result objectForKey:@"noncestr"];
                    req.timeStamp           = stamp.intValue;
                    req.package             = [result objectForKey:@"package"];
                    req.sign                = [result objectForKey:@"sign"];
                    [WXApi sendReq:req];
                    //日志输出
                    //                    WHYNSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[result objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                    resultStr = @"";
                } else { // 用户未安装微信
                    resultStr = @"未安装微信";
                }
            }
        }

        [KPProgressHUD hideLoading];

        handler(resultStr);

    } failure:^(NSError *error) {
        WHYNSLog(@"微信支付网络请求失败=%@", error);
        resultStr = @"网络请求失败";
        [KPProgressHUD hideLoading];
        handler(resultStr);
    }];

}

- (void)onResp:(BaseResp *)resp {

    if(![resp isKindOfClass:[PayResp class]] || !self.weiPayCompletionHandler) return;

    self.weiPayCompletionHandler(resp.errCode);
}

#pragma mark - 支付宝支付
+ (void)aliPayHandleOpenURL:(NSURL *)url {

    if (![KPPayManager sharedManager].aliPayCompletionHandler) return;

    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:[KPPayManager sharedManager].aliPayCompletionHandler];
    }

    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode

        [[AlipaySDK defaultService] processAuthResult:url
                                      standbyCallback:[KPPayManager sharedManager].aliPayCompletionHandler];
    }
}

/// 发起支付宝支付
///
/// @param order           订单号
/// @param order           订单金额
+ (void)aliPayOrder:(NSString *)order totalFee:(NSNumber *)totalFee completion:(void(^)(BOOL success))completion {
    
    if (!order || !totalFee) return;

//#warning test ali pay
//    totalFee = @(0.01);

    KPOrderPayParam *param = [KPOrderPayParam param];
    param.orderSn = order;
    param.totalFee = [NSString stringWithFormat:@"%@", totalFee];

    [KPNetworkingTool aliPayWithParam:param success:^(id result) {

        WHYNSLog(@"%@", result);

        if ([result rangeOfString:@"fail" options:NSCaseInsensitiveSearch].length) {
            completion(NO);
            return;
        }

        [[AlipaySDK defaultService] payOrder:result
                                  fromScheme:APPScheme
                                    callback:[KPPayManager sharedManager].aliPayCompletionHandler];

        completion(YES);

    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
        completion(NO);
    }];
}

///【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，
/// 请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
///
/// @param otherCallBack 另一个回调block
+ (void)aliPayOtherCallBack:(void (^)(NSDictionary *resultDic))otherCallBack {
    if (!otherCallBack) return;
    [KPPayManager sharedManager].aliPayCompletionHandler = otherCallBack;
}

#pragma mark - 银联支付
+ (void)upPayHandleOpenURL:(NSURL *)url {

    if (![KPPayManager sharedManager].upPayCompletionHandler) return;

    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        [KPPayManager sharedManager].upPayCompletionHandler(code);
    }]; 
}

/// 发起银联支付
///
/// @param orderSn 订单号
/// @param vc      发起银联支付的控制器
///
/// @return 成功与否
+ (void)upPayWithOrderSn:(NSString *)orderSn
                totalFee:(NSNumber *)totalFee
          bankCardNumber:(NSNumber *)bankCardNumber
          viewController:(__kindof UIViewController  *)vc {

    if (!orderSn.length || !vc) return;

//#warning up pay test
//    totalFee = @(0.01);

    KPOrderPayParam *param = [KPOrderPayParam param];
    param.orderSn = orderSn;
    param.totalFee = [NSString stringWithFormat:@"%@", totalFee];
    param.accNo = bankCardNumber;
    [KPNetworkingTool upPayWithParam:param success:^(id result) {

        WHYNSLog(@"-----%@------", result);

        NSString *resultStr = result[@"trade_state"];
        if (resultStr.length) {
            [KPPayManager sharedManager].upPayCompletionHandler(@"fail");
            return;
        }

        [[UPPaymentControl defaultControl] startPay:[NSString stringWithFormat:@"%@", result[@"tn"]]
                                         fromScheme:APPScheme
                                               mode:UpPaymentMode
                                     viewController:vc];

    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
        [KPPayManager sharedManager].upPayCompletionHandler(@"fail");
    }];

}

/// 银联支付完成block
///
/// @param completionBlock block
+ (void)upPayCompleteBlock:(void(^)(NSString *resultStr))completionBlock {
    if (!completionBlock) return;
    [KPPayManager sharedManager].upPayCompletionHandler = completionBlock;
}

#pragma mark - 零钱支付
/// 发起零钱支付
///
/// @param orderSn    订单号
/// @param totalPrice 订单金额
/// @param handler    完成block
+ (void)balancePayWithOrderSn:(NSString *)orderSn
                   totalPrice:(NSNumber *)totalPrice
                  payPassword:(NSString *)payPassword
            completionHandler:(void(^)(NSInteger code, NSString *paymentTime))handler {

    KPBalancePayParam *param = [KPBalancePayParam param];
    param.orderSn = orderSn;
    param.totalFee = [NSString stringWithFormat:@"%@", totalPrice];
    param.password = payPassword;

    [KPNetworkingTool BalancePayParam:param success:^(id result) {

        NSString *trade_state = result[@"data"][@"trade_state"];
        NSString *message = result[@"message"];
        NSInteger resultCode = message.integerValue;
        if ([trade_state isEqualToString:@"00"]) resultCode = 0;
        WHYNSLog(@"resultCode: %d", resultCode);
        handler(resultCode, result[@"data"][@"finishTime"]);

    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
        handler(100, nil);
    }];

}

#pragma mark - 京东支付
/// 发起京东支付
///
/// @param orderSn    订单号
/// @param totalPrice 订单金额
/// @param handler    完成block
+ (void)jdPayWithOrderSn:(NSString *)orderSn
              totalPrice:(NSNumber *)totalPrice
       completionHandler:(void(^)(NSString *resultStr))handler {

//#warning jd pay test
//    totalPrice = @(1);

    KPOrderPayParam *param = [KPOrderPayParam param];
    param.orderSn = orderSn;
    param.totalFee = [NSString stringWithFormat:@"%@", totalPrice];

    [KPNetworkingTool jdPayWithParam:param success:^(id result) {

        if ([result hasSuffix:@"</html>"]) {
            handler(result);
        }else {
            handler(@"fail");
        }

    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
        handler(@"fail");
    }];

}

#pragma mark - 单例
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static KPPayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[KPPayManager alloc] init];
    });
    return instance;
}

@end
