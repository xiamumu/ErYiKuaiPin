//
//  KPOrderCreateParam.h
//  KuaiPin
//
//  Created by 王洪运 on 16/6/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseParam.h"

@interface KPOrderCreateParam : KPBaseParam

@property (nonatomic, copy) NSString *ids;

@property (nonatomic, strong) NSNumber *receiverId;

@property (nonatomic, copy) NSString *orderMessage;

@end
