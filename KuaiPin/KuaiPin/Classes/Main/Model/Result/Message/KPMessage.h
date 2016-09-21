//
//  KPMessageResult.h
//  KuaiPin
//
//  Created by 21_xm on 16/6/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    KPMessageTypeShopingMessage,
    KPMessageTypeReceiveOrderMessage,
    KPMessageTypePayBack,
} KPMessageType;

@interface KPMessage : NSObject

@property (nonatomic, copy) NSString *messageId;
@property (nonatomic, copy) NSString *sn;
@property (nonatomic, copy) NSString *imgStr;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *status;

/**   0:购物消息  1:收货消息  2:贴现消息 */
@property (nonatomic, assign) KPMessageType messageType;
@end
