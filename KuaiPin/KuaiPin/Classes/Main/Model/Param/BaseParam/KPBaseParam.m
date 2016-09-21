//
//  KPBaseParam.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/19.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBaseParam.h"
#import "KPUserManager.h"

@implementation KPBaseParam

+ (instancetype)param
{
    return [[self alloc] init];
}

- (NSString *)username {
    if (_username == nil) {
        _username = [KPUserManager sharedUserManager].userModel.username;
    }
    return _username;
}

- (NSString *)token {
    if (_token == nil) {
        _token = [KPUserManager sharedUserManager].userModel.token;
    }
    return _token;
}


@end
