//
//  KPBankCardModel.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBankCardModel.h"

@implementation KPBankCardModel

- (void)setCardNo:(NSString *)cardNo {
    _cardNo = [cardNo copy];
    self.trailNumber = [cardNo substringFromIndex:cardNo.length-4];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"bankCardId" : @"id"};
}

@end
