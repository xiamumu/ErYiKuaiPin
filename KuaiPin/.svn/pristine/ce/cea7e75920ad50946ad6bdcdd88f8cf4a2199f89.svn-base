//
//  KPUserManager.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPBaseModel.h"
#import "Singleton.h"


@interface KPUserModel : KPBaseModel

@property (nonatomic, strong, getter=isLogin) NSNumber *login;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, strong) NSNumber *userID;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) NSNumber *hasPayPassword;

@property (nonatomic, copy) NSString *realname;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, strong) UIImage *avatarImg;

@property (nonatomic, strong) NSNumber *birthday;

@property (nonatomic, strong) NSNumber *loginTime;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, strong) NSNumber *points;

@property (nonatomic, strong) NSNumber *availablePredeposit;

@property (nonatomic, strong) NSNumber *freezePredeposit;

@property (nonatomic, strong) NSNumber *availableRcBalance;

@property (nonatomic, strong) NSNumber *freezeRcBalance;

@end

@interface KPUserManager : NSObject

#pragma mark - 单例方法
singleton_interface(UserManager)

@property (nonatomic, strong) KPUserModel *userModel;

+ (void)updateUser;

+ (void)removeUser;

@end



