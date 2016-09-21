//
//  KPPayBackDetailRowData.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPOrderItem.h"

@interface KPPayBackOrderDetail : NSObject

/***  订单号  */
@property (nonatomic, copy) NSString *orderSn;
/***  贴现开始时间  */
@property (nonatomic, copy) NSString *payBackBeginTime;
/***  可贴现时间  */
@property (nonatomic, copy) NSString *payBackTime;
/***  贴现金额  */
@property (nonatomic, copy) NSString *payBackMoney;
/***  订单补贴进度 */
@property (nonatomic, copy) NSString *isDiscount;
/***  订单申请补贴未通过原因*/
@property (nonatomic, copy) NSString *isDiscountDetail;
/***  订单申请贴现时间*/
@property (nonatomic, copy) NSString *discountApplicationTime;
/***  订单申请通过时间*/
@property (nonatomic, copy) NSString *discountVerifyTime;


/***  订单状态 */
@property (nonatomic, copy) NSString *orderState;
/***  订单支付时间 */
@property (nonatomic, copy) NSString *paymentTime;
/***  购买人名称  */
@property (nonatomic, copy) NSString *buyerName;
/***  子订单集合  */
@property (nonatomic, strong) NSArray <KPOrderItem *> *orderItems;
/***  订单头像  */
@property (nonatomic, strong) UIImage *img;

@end
