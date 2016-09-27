//
//  KPNetworkingTool.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/29.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPNetworkingTool.h"
#import <MJExtension.h>
#import "KPEncrypt.h"

// param model
#import "KPBaseParam.h"
#import "KPLoginRegistParam.h"
#import "KPUploadParam.h"
#import "KPGoodsDetailParam.h"
#import "KPShopDetailParam.h"
#import "KPUpdateSubsidizeParam.h"
#import "KPDeleteSubsidizeParam.h"
#import "KPChangePayPwdParam.h"
#import "KPChangePwdParam.h"
#import "KPUserUpdateParam.h"
#import "KPUserUpdateMobileParam.h"
#import "KPCollectGoodsParam.h"
#import "KPCollectStoreParam.h"
#import "KPSetDefaultReceiverParam.h"
#import "KPGetReceiversParam.h"
#import "KPNewReceiverParam.h"
#import "KPGetAreaParam.h"
#import "KPUpdateRecevierParam.h"
#import "KPDeleteReceiverParam.h"
#import "KPOrderCreateParam.h"
#import "KPMessageParam.h"
#import "KPOrderParam.h"
#import "KPProductCategoryIdParam.h"
#import "KPOrderDetailParam.h"
#import "KPAddBankCardParam.h"
#import "RealReachability.h"
#import "KPCollectionProductsListParam.h"
#import "KPCollectionStoreListParam.h"
#import "KPFeedbackParam.h"
#import "KPMoreProductsParam.h"
#import "KPSearchParam.h"
#import "KPconfirmReceiptParam.h"
#import "KPOrderPayParam.h"
#import "KPGetExpressInfoParam.h"
#import "KPPayBackOrderParam.h"
#import "KPApplyForPayBackParam.h"
#import "KPBalancePayParam.h"
#import "KPAssetsOrderDetailParam.h"

//result model
@class KPUserModel;

#if defined(DEBUG)||defined(_DEBUG)
const char * BaseURL = "http://60.205.125.191:8080";
#else
const char * BaseURL = "http://www.extou.com:8090";
#endif


#pragma mark - 首页接口
const char * HomeURL = "/home";                  // 首页接口
const char * GoodsDetailURL = "/product";        // 商品详情
const char * StoreDetailURL = "/brand";          // 店铺详情


#pragma mark - 购物车相关接口
/**
   获取购物车列表 username  token
 */
const char * SubsidizeURL = "/cart/get/";
/**
  更新购物车列表 username  token productId amount(商品数量)
 */
const char * SubsidizeUpdateURL = "/cart/update/";
/**
  删除购物车中商品 username  token productId
 */
const char * SubsidizeDeleteURL = "/cart/delete/";
/**
 取消订单 username  token orderSn
 */
const char * OrderCancelURL = "/order/cancelReceipt";
/**
 生成订单 username  token ids（字符串类型，传入cartItemId，以逗号隔开，如："32，798"）
 */
const char * OrderCreateURL = "/order/create";
/**
 订单详情 username  token orderSn（字符串类型，订单号）
 */
const char * OrderDetailURL = "/order/";


#pragma mark - 发现模块相关接口

/**
 获取发现列表
 */
const char * DiscoveryURL = "/discovery";

/**
 获取地区
 查询 省  parentId = 0      deep = 1
 查询 市  parentId = 省ID   deep = 2
 查询 区  parentId = 市ID   deep = 3
 */
const char * GetAreaURL = "/area/";

/**
 新增收货地址
 username token provinceId cityId countryId receiverName receiverMobile details isDefault(非必传)
 */
const char * NewAddressURL = "/user/addReceiver/";

/**
 *  加载更多商家列表 GET
 */
const char * LoadMoreBrandsURL = "/brands";
/**
 获取收货地址
 username token getDefault(非必传，不传返回列表，传 0 则返回一条默认的地址)
 */
const char * ReceiversURL = "/user/receivers/";
/**
 设置默认收货地址
 username token receiverId
 */
const char * SetDefaultReceiverURL = "/user/setDefaultReceiver/";
/**
 *  加载更多精选商品列表 GET
 */
//const char * LoadMoreSelectionGoodsURL = "/selectionList";
/**
 删除收货地址d
 username token receiverId
 */
const char * DeleteAddressURL = "/user/removeReceiver/";
/**
 *  收藏店铺 POST  参数：username token storeId
 */
const char * CollectStoreURL = "/brand/addCollection";

/**
 *  收藏商品 POST  参数：username token productId
 */
const char * CollectProductURL = "/product/addCollection";

/**
 *  接收全部消息 POST  参数：username token
 */
const char * MessageURL = "/message";

/**
 更新收货地址
 username token receiverId 
 provinceId cityId countryId receiverName receiverMobile details (全部非必传)
 */
const char * UpdateAddressURL = "/user/updateReceiver/";

/**
 添加银行卡 username token realName  idCardNo  cardNo  mobile
 */
const char * AddBankCardURL = "/union/authentication/";

/**
 银行卡列表 username token
 */
const char * BankCardListURL = "/card/";

/**
 解绑银行卡 username token cardNo
 */
const char * BankCardDeleteURL = "/card/delete";

/**
 *  获取收藏商品列表 POST  参数： 必传：username token
 */
const char * GetProductCollectionListURL = "/product/productCollection";

/**
 *  取消所有收藏商品 POST  参数： 必传：username token  ids 数组
 */
const char * cancelAllProductCollectionURL = "/product/cancelCollection";

/**
 *  获取收藏店铺列表 POST  参数： 必传：username token
 */
const char * GetStoreCollectionListURL = "/brand/brandCollection";

/**
 *  取消所有收藏店铺 POST  参数： 必传：username token  ids 数组
 */
const char * cancelAllStoreCollectionURL = "/brand/cancelCollection";


/**
 *  获取我的页面接口 POST  参数： 必传：username token
 */
const char * profileURL = "/order/userActStateCount";

/**
 *  获取广告图
 */
const char * advertisementsURL = "/advertisement";

/**
 *  意见反馈    POST  参数： 必传：username token content
 */
const char * FeedbackURL = "/feedback/add";

/**
 *  搜索    POST  参数： 必传：keyword    可选参数 storeId
 */
const char * searchURL = "/product/search";

/**
 *  确认收货    POST  参数：username，token，orderSn
 */
const char * confirmReceiptURL = "/order/confirmReceipt";

/**
 *  获取购物车商品数量    POST  参数：username，token
 */
const char * cartItemCountURL = "/cart/cartItemCount";

#pragma mark - 商品相关接口

/**
 获取一级分类
 */
const char * ProductCategoryURL = "/product/pc";

/**
 *  订单接口 POST  参数： 必传：username token  可选 0:已取消; 10:未付款; 25:已付款; 25:已发货; 40:已收货 （不传返回所有订单）
 */
const char * OrderURL = "/order";

/**
 获取一级分类的商品
 */
const char * ProductCategoryIdURL = "/product/pcId/";

/**
 *  获取全部商品 参数：username  token
 */
const char * ProductsURL = "/products";

#pragma mark - 版本更新相关接口

/**
 *  获取最新版本Url
 */
const char * NewVersionURL = "http://itunes.apple.com/cn/lookup?id=1124803519";


/**
 *  获取版本更新状态
 */
const char * NewVersionTypeURL = "/android/getIsForciblyUpdate";

/**
 *  检测是否注册 参数：mobilephone
 */
const char * CheckPhoneURL = "/user/checkMobilePhone";

#pragma mark - 支付相关

/**
 *  检查京东订单支付完成实际状态 参数：username，token，orderSn payId
 */
const char * CheckJDPayCompletionStateURL = "/pay/query";

/**
 *  京东支付 参数：username，token，orderSn totalFee（总价）
 */
const char * JDPayURL = "/pay/jd";

/**
 *  检查微信订单支付完成实际状态 参数：username，token，orderSn payId
 */
const char * CheckWeiPayCompletionStateURL = "/pay/query";

/**
 *  微信支付 参数：username，token，orderSn totalFee（总价）
 */
const char * WeixinPayURL = "/pay/weixin";

/**
 *  检查支付宝订单支付完成实际状态 username，token，orderSn payId
 */
const char * CheckAliPayCompletionStateURL = "/pay/query";

/**
 *  支付宝支付 username，token，orderSn totalFee（总价）
 */
const char * AliPayURL = "/pay/ali";

/**
 *  检查银联订单支付完成实际状态 username，token，orderSn payId
 */
const char * CheckUpPayCompletionStateURL = "/pay/query";

/**
 *  银联支付 username，token，orderSn totalFee（总价）
 */
const char * UpPayURL = "/pay/yl";

/**
 *  获取用户零钱  参数：username  token
 */
const char * BalanceQueryURL = "/balance/query";

/**
 *  用零钱支付  参数：username  token  orderSn  totalFee  password
 */
const char * BalancePayURL = "/balance/pay";
/**
 更改支付密码  username token nPayPassoword
 payPassword (非必传，支付密码已存在则视为修改，此时必传原支付密码。支付密码为空则视为首次设置，此时不需要原支付密码）
 mobileVerify (非必传, 忘记支付密码，并且通过了手机验证后传"true")
 */
const char * SetPayPwdURL = "/user/setPayPassword/";
/**
 验证支付密码  username token payPassword
 */
const char * CheckPayPwdURL = "/user/checkPayPassword/";

#pragma mark - 物流接口

/**
 *  获取物流信息 参数：username  token  快递公司编号： expresscode  运单号：expresssn
 */
const char * GetExpressInfoURL = "/expressInfo/getExpressInfo";

#pragma mark - 消费资产相关
/**
 *  获取消费资产订单 参数：username  token  assetsState
 */

const char * AssetsGetURL = "/assets/get";
/**
 *  申请贴现接口 username   token  orderSn  productId
 */

const char * ApplyAssetsURL = "/assets/applyAssets";

/**
 *  资产详情 POST username   token   assetsSn
 */
const char * AssetsDetailURL = "/assets/getDetail";

#pragma mark - 登录相关和获取用户信息相关
const char * RegisterURL = "/user/regist/";
const char * LoginURL = "/login/";
/** 短信登录 参数:mobile,vcode */
const char * MessageLoginURL = "/messageLogin/";
/**
 *  重置登录密码 username， password
 */
const char * ResetPwdURL = "/user/resetUserPassword/";
/**
 *  更改登录密码 username  token  password nPassword
 */
const char * ChangePwdURL = "/user/modifyPassword/";

/**
 *  获取手机验证码 mobile
 */
const char * GetPhoneAuthCode = "/send/sendMsg";

/**
 *  验证手机验证码 mobile  vcode
 */
const char * CommitePhoneAuthCode = "/send/submitValidate";
/**
 *  更新用户信息详情 Post  (必传) token username
 */
const char * UserUpdateURL = "/user/update";
/**
 *  更新用户手机号 Post  (必传) token username newMobile
 */
const char * UserUpdateMobileURL = "/user/updateMobile";

/**
 *  图片上传
 */
const char * UploadURL = "/file/fileUpload";


typedef NS_ENUM(NSUInteger, KPNetworkingMethod) {
    KPNetworkingMethodGet,
    KPNetworkingMethodPost,
    KPNetworkingMethodUpload,
};


@implementation KPNetworkingTool

/** 获取手机验证码 */
+ (void)getPhoneAuthCodeWithPhoneNumber:(NSString *)phoneNumber
                                success:(void (^)(id result))success
                                failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1];
    dict[@"mobile"] = phoneNumber;
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:GetPhoneAuthCode parameters:dict success:success failure:failure];
}

/** 验证手机验证码 */
+ (void)commitePhoneAuthCodeWithPhoneNumber:(NSString *)phoneNumber
                                       code:(NSString *)code
                                    success:(void (^)(id result))success
                                    failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    dict[@"mobile"] = phoneNumber;
    dict[@"vcode"] = code;
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:CommitePhoneAuthCode parameters:dict success:success failure:failure];
}


/** 重置登录密码 */
+ (void)resetPwdWithParam:(KPLoginRegistParam *)param
                  success:(void (^)(id result))success
                  failure:(void (^)(NSError *error))failure {

    NSDictionary *dict = [param mj_keyValues];
    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:ResetPwdURL parameters:dict success:success failure:failure];
}

/** 京东支付 */
+ (void)jdPayWithParam:(KPOrderPayParam *)param
               success:(void (^)(id result))success
               failure:(void (^)(NSError *error))failure {

    [KPProgressHUD showLoading];
    NSDictionary *dict = [param mj_keyValues];
    NSString *paramters = encryptWithParameter(dict);
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%s?%@", BaseURL, JDPayURL, paramters]]];
    request.HTTPMethod = @"GET";
//    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&token=%@&orderSn=%@&totalFee=%@", dict[@"username"],
//                                                                                                   dict[@"token"],
//                                                                                                   dict[@"orderSn"],
//                                                                                                   dict[@"totalFee"]];
//    request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];

    NSURLSessionDataTask *task = nil;
    task = [session dataTaskWithRequest:request
                      completionHandler:^(NSData * _Nullable data,
                                          NSURLResponse * _Nullable response,
                                          NSError * _Nullable error) {

                          dispatch_async(dispatch_get_main_queue(), ^{
                              [KPProgressHUD hideLoading];
                              if (error) {
                                  failure(error);
                              }else {
                                  success([[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                              }
                          });

                      }];
    [task resume];
}

/** 检查京东订单支付完成实际状态 */
+ (void)checkJDPayCompletionStateWithParam:(KPOrderPayParam *)param
                                   success:(void (^)(id result))success
                                   failure:(void (^)(NSError *error))failure {

    param.payId = @4;
    NSDictionary *dict = [param mj_keyValues];
    NSString *paramters = encryptWithParameter(dict);
    NSString *url = [NSString stringWithFormat:@"%s?%@",CheckJDPayCompletionStateURL, paramters];
//    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:url.UTF8String parameters:nil success:success failure:failure];
}

/** 银联支付 */
+ (void)upPayWithParam:(KPOrderPayParam *)param
                   success:(void (^)(id result))success
                   failure:(void (^)(NSError *error))failure {

    NSDictionary *dict = [param mj_keyValues];
    NSString *paramters = encryptWithParameter(dict);
    NSString *url = [NSString stringWithFormat:@"%s?%@",UpPayURL, paramters];
//    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:url.UTF8String parameters:nil success:success failure:failure];
}

/** 检查银联订单支付完成实际状态 */
+ (void)checkUpPayCompletionStateWithParam:(KPOrderPayParam *)param
                                   success:(void (^)(id result))success
                                   failure:(void (^)(NSError *error))failure {

    param.payId = @2;
    NSDictionary *dict = [param mj_keyValues];
    NSString *paramters = encryptWithParameter(dict);
    NSString *url = [NSString stringWithFormat:@"%s?%@",CheckUpPayCompletionStateURL, paramters];
    //        WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:url.UTF8String parameters:nil success:success failure:failure];
}

/** 检查支付宝订单支付完成实际状态 */
+ (void)checkAliPayCompletionStateWithParam:(KPOrderPayParam *)param
                                    success:(void (^)(id result))success
                                    failure:(void (^)(NSError *error))failure {

    param.payId = @3;
    NSDictionary *dict = [param mj_keyValues];
    NSString *paramters = encryptWithParameter(dict);
    NSString *url = [NSString stringWithFormat:@"%s?%@",CheckAliPayCompletionStateURL, paramters];
    //        WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:url.UTF8String parameters:nil success:success failure:failure];
}

/** 支付宝支付 */
+ (void)aliPayWithParam:(KPOrderPayParam *)param
                   success:(void (^)(id result))success
                   failure:(void (^)(NSError *error))failure {

    NSDictionary *dict = [param mj_keyValues];
    NSString *paramters = encryptWithParameter(dict);
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%s?%@", BaseURL, AliPayURL, paramters]]];
    request.HTTPMethod = @"GET";

    NSURLSessionDataTask *task = nil;
    task = [session dataTaskWithRequest:request
                      completionHandler:^(NSData * _Nullable data,
                                          NSURLResponse * _Nullable response,
                                          NSError * _Nullable error) {

                          dispatch_async(dispatch_get_main_queue(), ^{
                              if (error) {
                                  failure(error);
                              }else {
                                  success([[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                              }
                          });

                      }];
    [task resume];

}

/** 检测是否注册 */
+ (void)checkPhoneWithParam:(NSString *)phone
                    success:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure {

    NSDictionary *dict = @{@"mobilephone" : phone};
    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:CheckPhoneURL parameters:dict success:success failure:failure];
}

/** 微信支付 */
+ (void)weixinPayWithParam:(KPOrderPayParam *)param
                   success:(void (^)(id result))success
                   failure:(void (^)(NSError *error))failure {

    NSDictionary *dict = [param mj_keyValues];
    NSString *paramters = encryptWithParameter(dict);
    NSString *url = [NSString stringWithFormat:@"%s?%@",WeixinPayURL, paramters];
//    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:url.UTF8String parameters:nil success:success failure:failure];
}

/** 检查微信订单支付完成实际状态 */
+ (void)checkWeiPayCompletionStateWithParam:(KPOrderPayParam *)param
                                 success:(void (^)(id result))success
                                 failure:(void (^)(NSError *error))failure {

    param.payId = @1;
    NSDictionary *dict = [param mj_keyValues];
    NSString *paramters = encryptWithParameter(dict);
    NSString *url = [NSString stringWithFormat:@"%s?%@",CheckWeiPayCompletionStateURL, paramters];
    //        WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:url.UTF8String parameters:nil success:success failure:failure];
}

/** 银行卡解绑 */
+ (void)bankCardDeleteWithNumber:(NSInteger)bankCardNumber
                         success:(void (^)(id result))success
                         failure:(void (^)(NSError *error))failure  {

    KPBaseParam *param = [KPBaseParam param];
    NSMutableDictionary *dict = [param mj_keyValues];
    dict[@"cardNo"] = @(bankCardNumber);
    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:BankCardDeleteURL parameters:dict success:success failure:failure];
}

/** 银行卡列表 */
+ (void)bankCardListSuccess:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure {
    
    KPBaseParam *param = [KPBaseParam param];
    NSDictionary *dict = [param mj_keyValues];
//            WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:BankCardListURL parameters:dict success:success failure:failure];
}

/** 添加银行卡 */
+ (void)addBankCardWithParam:(KPAddBankCardParam *)param
                     success:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
    //        WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:AddBankCardURL parameters:dict success:success failure:failure];
}

/** 获取一级分类的商品 */
+ (void)productCategoryIdWithParam:(KPProductCategoryIdParam *)param
                        success:(void (^)(id result))success
                        failure:(void (^)(NSError *error))failure {
    
    NSString *url = [NSString stringWithFormat:@"%s%@", ProductCategoryIdURL, param.pcId];
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:url.UTF8String parameters:[param mj_keyValues] success:success failure:failure];
}

/** 获取一级分类 */
+ (void)productCategoryWithSuccess:(void (^)(id result))success
                        failure:(void (^)(NSError *error))failure {
    
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:ProductCategoryURL parameters:nil success:success failure:failure];
}

/** 更新地址 */
+ (void)updateReceiverWithParam:(KPUpdateRecevierParam *)param
                        success:(void (^)(id result))success
                        failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
//        WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:UpdateAddressURL parameters:dict success:success failure:failure];
}

/** 删除地址 */
+ (void)deleteReceiverWithParam:(KPDeleteReceiverParam *)param
                        success:(void (^)(id result))success
                        failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
//        WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:DeleteAddressURL parameters:dict success:success failure:failure];
}

/** 获取地区 */
+ (void)getAreaWithParam:(KPGetAreaParam *)param
                 success:(void (^)(id result))success
                 failure:(void (^)(NSError *error))failure {
    
    NSString *str = [NSString stringWithFormat:@"%s%@/%@", GetAreaURL, param.parentId, param.deep];
//    WHYNSLog(@"%@", str);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:str.UTF8String parameters:nil success:success failure:failure];
}

/** 新地址 */
+ (void)newReceiverWithParam:(KPNewReceiverParam *)param
                     success:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
    //    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:NewAddressURL parameters:dict success:success failure:failure];
}

/** 设置默认地址 */
+ (void)setDefaultReceiverWithParam:(KPSetDefaultReceiverParam *)param
                            success:(void (^)(id result))success
                            failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
//    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:SetDefaultReceiverURL parameters:dict success:success failure:failure];
}

/** 获取地址列表 */
+ (void)getReceiversWithParam:(KPGetReceiversParam *)param
                      success:(void (^)(id result))success
                      failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:ReceiversURL parameters:dict success:success failure:failure];
    
}

/** 获取发现列表 */
+ (void)discoveryWithSuccess:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure {
    
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:DiscoveryURL parameters:nil success:success failure:failure];
    
}

/** 订单详情 */
+ (void)orderDetailWithParam:(KPOrderDetailParam *)param
                     success:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure {
    
    NSString *url = [NSString stringWithFormat:@"%s%@", OrderDetailURL, param.orderSn];
    NSDictionary *dict = @{@"username" : param.username, @"token" : param.token};
    WHYNSLog(@"%@------%@", dict, param.orderSn);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:url.UTF8String parameters:dict success:success failure:failure];
    
}

/** 创建订单 */
+ (void)orderCreateWithParam:(KPOrderCreateParam *)param
                    success:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:OrderCreateURL parameters:dict success:success failure:failure];
    
}

/** 取消订单 */
+ (void)orderCancelWithParam:(KPOrderDetailParam *)param
                     success:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure {

    NSDictionary *dict = [param mj_keyValues];
    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:OrderCancelURL parameters:dict success:success failure:failure];

}

/** 删除购物车中商品 */
+ (void)cartDeleteWithParam:(KPDeleteSubsidizeParam *)param
                    success:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
//    WHYNSLog(@"%@\n%s", dict, SubsidizeDeleteURL);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:SubsidizeDeleteURL parameters:dict success:success failure:failure];
    
}

/** 加入G库 */
+ (void)cartUpdateWithParam:(KPUpdateSubsidizeParam *)param
                    success:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:SubsidizeUpdateURL parameters:dict success:success failure:failure];
    
}

/** 获取购物车 */
+ (void)cartGetWithSuccess:(void (^)(id result))success
                   failure:(void (^)(NSError *error))failure {
    
    KPBaseParam *param = [KPBaseParam param];
//    WHYNSLog(@"token = %@", param.token);
    
    NSDictionary *dict = [param mj_keyValues];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:SubsidizeURL parameters:dict success:success failure:failure];
    
}

/** 上传图片 */
+ (void)uploadUserIconWithParam:(KPUploadParam *)param
                        success:(void (^)(id result))success
                        failure:(void (^)(NSError *error))failure {

    NSString *url = [NSString stringWithUTF8String:UploadURL];

    [[KPNetworkingTool manager] POST:url
                          parameters:@{@"flag" : @"true", @"type" : @"user_avatar"}
           constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:param. imgData
                                    name:param.name
                                fileName:param.imgFileName
                                mimeType:param.MIMEType];
        
    }
                            progress:nil
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

/** 修改登录密码 */
+ (void)changePwdWithParam:(KPChangePwdParam *)param
                   success:(void(^)(id result))success
                   failure:(void(^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:ChangePwdURL parameters:dict success:success failure:failure];
}

/** 验证支付密码 */
+ (void)checkPayPwdWithParam:(KPChangePayPwdParam *)param
                      success:(void(^)(id result))success
                      failure:(void(^)(NSError *error))failure {
//    param.payPassword = MD5WithStr(param.payPassword);
    NSDictionary *dict = [param mj_keyValues];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:CheckPayPwdURL parameters:dict success:success failure:failure];
}

/** 修改支付密码 */
+ (void)changePayPwdWithParam:(KPChangePayPwdParam *)param
                      success:(void(^)(id result))success
                      failure:(void(^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:SetPayPwdURL parameters:dict success:success failure:failure];
}

/** 短信登录请求 */
+ (void)messageLoginWithParam:(KPLoginRegistParam *)param
                      success:(void(^)(id result))success
                      failure:(void(^)(NSError *error))failure {

    NSDictionary *dict = [param mj_keyValues];
        //    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:MessageLoginURL parameters:dict success:success failure:failure];
}

/** 登录请求 */
+ (void)loginWithParam:(KPLoginRegistParam *)param
               success:(void(^)(id result))success
               failure:(void(^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
//    WHYNSLog(@"%@", dict);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:LoginURL parameters:dict success:success failure:failure];
}

/** 注册请求 */
+ (void)registWithParam:(KPLoginRegistParam *)param
                success:(void (^)(id result))success
                failure:(void (^)(NSError *error))failure {
    
    NSDictionary *dict = [param mj_keyValues];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:RegisterURL parameters:dict success:success failure:failure];
}

/** 首页数据 */
+ (void)homeData:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:HomeURL parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}
/** 产品详情数据 */
+ (void)goodsDetailWithParam:(KPGoodsDetailParam *)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%s/%@", GoodsDetailURL, param.productId];
    NSMutableDictionary *paramDict = [param mj_keyValues];
    [paramDict removeObjectForKey:@"productId"];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:url.UTF8String parameters:paramDict success:success failure:failure];
}
/** 店铺详情数据 */
+ (void)shopDataWithParam:(KPShopDetailParam *)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%s/%@", StoreDetailURL, param.storeId];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:url.UTF8String parameters:[param mj_keyValues] success:success failure:failure];
}


/** 更新用户信息 */
+ (void)userUpdateWithParam:(KPUserUpdateParam *)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:UserUpdateURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 更新用户手机号 */
+ (void)userUpdateMobileWithParam:(KPUserUpdateMobileParam *)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *dict = [param mj_keyValues];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:UserUpdateMobileURL parameters:dict success:success failure:failure];
}

/** 加载更多商家列表 */
+ (void)loadMoreBrandsSuccess:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:LoadMoreBrandsURL parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 加载更多商品列表 */
+ (void)loadMoreProducts:(KPMoreProductsParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"/%@", param.type];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:url.UTF8String parameters:[param mj_keyValues] success:success failure:failure];
}

/** 加载更多精选商品列表 */
//+ (void)loadMoreSelectionGoods:(KPMoreProductsParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
//{
//    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:LoadMoreSelectionGoodsURL parameters:[param mj_keyValues] success:success failure:failure];
//}

/** 收藏/取消收藏店铺 */
+ (void)CollectStore:(KPCollectStoreParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%s/%@", CollectStoreURL, param.storeId];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:url.UTF8String parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 获取所有收藏店铺列表 */
+ (void)GetStoresCollectionListSuccess:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:GetStoreCollectionListURL parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 取消所有收藏店铺 */
+ (void)CancelAllStoreCollectionList:(KPCollectionStoreListParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:cancelAllStoreCollectionURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 收藏/取消收藏商品 */
+ (void)CollectProduct:(KPCollectGoodsParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%s/%@", CollectProductURL, param.productId];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:url.UTF8String parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 获取所有收藏商品列表 */
+ (void)GetProductsCollectionListSuccess:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:GetProductCollectionListURL parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 取消所有收藏商品 */
+ (void)CancelAllProductsCollection:(KPCollectionProductsListParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:cancelAllProductCollectionURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 获取全部消息 */
+ (void)GetAllMessageSuccess:(void (^)(id result))success failure:(void (^)(NSError *))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:MessageURL parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 获取单条消息 */
+ (void)GetOneMessage:(NSString *)messageId Success:(void (^)(id result))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%s/%@", MessageURL, messageId];
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:url.UTF8String parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 获取订单 */
+ (void)orderWithParam:(KPOrderParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    if (param == nil) {
        param = [KPOrderParam param];
    }
    
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:OrderURL parameters:[param mj_keyValues] success:success failure:failure];
}


/** 获取我的页面数据 */
+ (void)GetProfileData:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:profileURL parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 获取广告图 */
+ (void)GetAdvertisements:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:advertisementsURL parameters:nil success:success failure:failure];
}

/** 提交意见反馈 */
+ (void)commitFeedback:(KPFeedbackParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:FeedbackURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 搜索 */
+ (void)search:(KPSearchParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:searchURL parameters:[param mj_keyValues] success:success failure:failure];
}


/** 确认收货 */
+ (void)receiveOrder:(KPconfirmReceiptParam *)param Success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:confirmReceiptURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 获取购物车订单数量 */
+ (void)getCarItemCountSuccess:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:cartItemCountURL parameters:[[KPBaseParam param] mj_keyValues] success:success failure:failure];
}

/** 版本更新提示 */
+ (void)GetNewVersionSuccess:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:NewVersionURL parameters:nil success:success failure:failure];
}


#pragma mark - 消费资产相关请求
/** 获取贴现订单 */
+ (void)GetAssetsOrdersWithParam:(KPPayBackOrderParam *)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
//    NSLog(@"-=-=-=-=%@", [param mj_keyValues]);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:AssetsGetURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 申请补贴 */
+ (void)ApplyAssetsWithParam:(KPApplyForPayBackParam *)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    
    WHYNSLog(@"-=-=-=KPAssetsOrderDetailParam: %@", [param mj_keyValues]);
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:ApplyAssetsURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 消费资产补贴详情 */
+ (void)AssetsDetailWithParam:(KPAssetsOrderDetailParam *)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:AssetsDetailURL parameters:[param mj_keyValues] success:success failure:failure];
}



/** 获取全部商品 */
+ (void)GetAllProductsWithParam:(KPProductCategoryIdParam *)param success:(void (^)(id result))success
                        failure:(void (^)(NSError *error))failure {
    
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:ProductsURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 获取物流信息 */
+ (void)GetExpressInfoWithParam:(KPGetExpressInfoParam *)param success:(void (^)(id result))success
                        failure:(void (^)(NSError *error))failure {
    
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:GetExpressInfoURL parameters:[param mj_keyValues] success:success failure:failure];
}

/** 获取新版本更新状态 */
+ (void)GetNewVersionTypeSuccess:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:NewVersionTypeURL parameters:nil success:success failure:failure];
}

#pragma mark - 支付相关请求

/** 查询用户零钱 */
+ (void)BalanceQueryWithWater:(NSString *)water success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *param = [[KPBaseParam param] mj_keyValues];
    param[@"water"] = water;
    
    [[self manager] requestWithMethod:KPNetworkingMethodPost urlString:BalanceQueryURL parameters:param success:success failure:failure];
}

/** 用零钱支付 */
+ (void)BalancePayParam:(KPBalancePayParam *)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    param.password = MD5WithStr(param.password);
    
    WHYNSLog(@"-=-=-=BalancePayParam : %@", [param mj_keyValues]);
    [[self manager] requestWithMethod:KPNetworkingMethodGet urlString:BalancePayURL parameters:[param mj_keyValues] success:success failure:failure];
}












#pragma mark - 基础内部request请求方法
-(void)requestWithMethod:(KPNetworkingMethod)method
               urlString:(const char *)urlString
              parameters:(id)parameters
                 success:(void(^)(id result))success
                 failure:(void(^)(NSError *error))failure {

    NSString *urlStr = [NSString stringWithUTF8String:urlString];

    [KPProgressHUD showLoading];
    WHYNSLog(@"urlString---%s", urlString);
    void (^successTask)(NSURLSessionDataTask * dataTask, id responseObject) = ^(NSURLSessionDataTask * task, id responseObject) {

        [KPProgressHUD hideLoading];

        if ([responseObject[@"code"] integerValue] == 10002) {

            [KPProgressHUD showErrorWithStatus:@"登录信息过期，请重新登录" completion:^{
                [KPUserManager removeUser];
                NSPostNote(Noti_Relogin, nil)
            }];
        }
        else
        {
            if (success) success(responseObject);
        }

    };

    void (^failureTask)(NSURLSessionDataTask * task, NSError *error) = ^(NSURLSessionDataTask * task, NSError *error) {
        [KPProgressHUD hideLoading];
        if (failure) failure(error);
    };


    if (method == KPNetworkingMethodGet) {
        [[KPNetworkingTool manager] GET:urlStr
                             parameters:parameters
                               progress:nil
                                success:successTask
                                failure:failureTask];

    }else if (method == KPNetworkingMethodPost) {
        [[KPNetworkingTool manager] POST:urlStr
                              parameters:parameters
                                progress:nil
                                 success:successTask
                                 failure:failureTask];
    }
}

+(instancetype)manager {

    static dispatch_once_t onceToken;
    static KPNetworkingTool *manager;
    dispatch_once(&onceToken, ^{
        manager = [[KPNetworkingTool alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithUTF8String:BaseURL]]];
        WHYNSLog(@"BaseURL---%s", BaseURL);
        NSMutableSet *set = [NSMutableSet set];
        set.set = manager.responseSerializer.acceptableContentTypes;
        [set addObject:@"text/html"];
        [set addObject:@"text/plain"];

        manager.responseSerializer.acceptableContentTypes = set;

        manager.requestSerializer.timeoutInterval = 10;
    });

    return manager;
}


@end
