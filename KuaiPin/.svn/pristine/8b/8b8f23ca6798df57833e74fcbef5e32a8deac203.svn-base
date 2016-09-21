//
//  KPMessageResult.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/6.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPMessage.h"

@implementation KPMessage

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"messageId": @"id", @"messageType": @"type"};
}

- (void)setMessageType:(KPMessageType)messageType
{
    _messageType = messageType;
    switch (messageType) {
        case KPMessageTypeShopingMessage:
        {
            self.imgStr = @"购物消息";
            self.titleText = @"购物消息";
        }
            break;
        case KPMessageTypeReceiveOrderMessage:
        {
            self.imgStr = @"收货消息";
            self.titleText = @"收货消息";
        }
            break;
        case KPMessageTypePayBack:
        {
            self.imgStr = @"贴现消息";
            self.titleText = @"贴现消息";
        }
            break;
            
        default:
            break;
    }
}
@end
