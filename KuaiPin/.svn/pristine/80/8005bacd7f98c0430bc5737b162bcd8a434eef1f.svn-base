//
//  KPSMSTool.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//




/**
 *  @brief 验证码获取回调
 *  @param error 当error为空时表示成功
 */
typedef void (^SMSResultHandler) (NSError *error);

@interface KPSMSTool : NSObject

#pragma mark - 支持获取验证码和提交验证码 (get the verification code and commit verifacation code)
/**
 *  @brief                   获取验证码(Get verification code)
 *
 *  @param phoneNumber       电话号码(The phone number)
 *  @param result            请求结果回调(Results of the request)
 */
+(void)getVerificationCodeByPhoneNumber:(NSString *)phoneNumber
                            result:(SMSResultHandler)handler;


/**
 * @brief              提交验证码(Commit the verification code)
 *
 * @param code         验证码(Verification code)
 * @param phoneNumber  电话号码(The phone number)
 * @param result       请求结果回调(Results of the request)
 */
+(void)commitVerificationCode:(NSString *)code
                  phoneNumber:(NSString *)phoneNumber
                       result:(SMSResultHandler)handler;

@end
