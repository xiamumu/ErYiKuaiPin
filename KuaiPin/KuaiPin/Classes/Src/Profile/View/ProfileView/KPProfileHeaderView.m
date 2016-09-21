//
//  KPProfileHeaderView.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/3.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPProfileHeaderView.h"
#import "KPMessageButton.h"
#import "KPUserManager.h"
#import <UIButton+WebCache.h>

@interface KPProfileHeaderView ()

@property (nonatomic, weak) UIView *imgBackView;
@property (nonatomic, weak) KPButton *iconBtn;
@property (nonatomic, weak) KPButton *userNameBtn;
@property (nonatomic, weak) KPMessageButton *messageBtn;
@end

@implementation KPProfileHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"my_bg"];
        
        
        UIView *imgBackView = [[UIView alloc] init];
        imgBackView.layer.masksToBounds = YES;
        imgBackView.backgroundColor = WhiteColor;
        [self addSubview:imgBackView];
        self.imgBackView = imgBackView;
        
        KPUserManager *userManager = [KPUserManager sharedUserManager];
        
        KPButton *iconBtn = [[KPButton alloc] init];
        iconBtn.layer.masksToBounds = YES;
        [iconBtn sd_setImageWithURL:[NSURL URLWithString:userManager.userModel.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userDefaultAvtor"]];
        [iconBtn addTarget:self action:@selector(changeIcon:) forControlEvents:UIControlEventTouchUpInside];
        [imgBackView addSubview:iconBtn];
        self.iconBtn = iconBtn;
        
        
        KPButton *userNameBtn = [[KPButton alloc] init];
        [userNameBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        userNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        userNameBtn.titleLabel.font = UIFont_17;
        [userNameBtn setTitle:userManager.userModel.nickname forState:UIControlStateNormal];
        [userNameBtn addTarget:self action:@selector(userNameAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:userNameBtn];
        self.userNameBtn = userNameBtn;
        
        KPButton *accountBtn = [[KPButton alloc] init];
//        accountBtn.backgroundColor = RandomColor;
        [accountBtn setTitle:@"账户管理" forState:UIControlStateNormal];
        [accountBtn setTintColor:WhiteColor];
        accountBtn.titleLabel.font = UIFont_13;
        [accountBtn setImage:[UIImage imageNamed:@"my_edit"] forState:UIControlStateNormal];
        accountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        accountBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        accountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -accountBtn.currentImage.size.width, 0, 0);
        CGFloat titltW = [accountBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: accountBtn.titleLabel.font}].width;
        accountBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titltW + 10, 0, 0);
        [accountBtn addTarget:self action:@selector(accountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:accountBtn];
        self.accountBtn = accountBtn;
        
        KPMessageButton *messageBtn = [KPMessageButton messageButton];
        [messageBtn addTarget:self action:@selector(messageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:messageBtn];
        self.messageBtn = messageBtn;
    }
    return self;
}

- (void)userNameAction:(KPButton *)userNameBtn
{
    if (self.registAndLogin) {
        self.registAndLogin();
    }
}

// 登出
- (void)setIsLogout:(BOOL)isLogout
{
    _isLogout = isLogout;
    if (isLogout) {
        [self.iconBtn setImage:[UIImage imageNamed:@"userDefaultAvtor"] forState:UIControlStateNormal];
        [self.userNameBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    }
}
// 接收修改用户名的通知
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    [self.userNameBtn setTitle:title forState:UIControlStateNormal];
}

// 接收修改用户头像的通知
- (void)setIcon:(UIImage *)icon
{
    _icon = icon;
    [self.iconBtn setImage:icon forState:UIControlStateNormal];
}

// 修改消息提醒标记
- (void)setMessageBadgeValue:(NSString *)messageBadgeValue
{
    _messageBadgeValue = [messageBadgeValue copy];
    self.messageBtn.badgeValue = messageBadgeValue;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    CGFloat imgBackViewW = ScaleHeight(87);
    self.imgBackView.layer.cornerRadius = imgBackViewW * 0.5;
    CGSize imgBackSize = CGSizeMake(imgBackViewW, imgBackViewW);
    [self.imgBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(25);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(imgBackSize);
    }];
    
    CGFloat iconBtnW = imgBackViewW - 8;
    CGSize iconBtnSize = CGSizeMake(iconBtnW, iconBtnW);
    self.iconBtn.layer.cornerRadius = iconBtnW * 0.5;
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.imgBackView);
        make.size.mas_equalTo(iconBtnSize);
    }];
    
    CGSize userNameBtnSize = CGSizeMake(100, 20);
    [self.userNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imgBackView.mas_right).offset(15);
        make.bottom.mas_equalTo(weakSelf.imgBackView.mas_centerY);
        make.size.mas_equalTo(userNameBtnSize);
    }];
    
    CGSize accountBtnSize = CGSizeMake(100, 35);
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.userNameBtn);
        make.top.mas_equalTo(weakSelf.imgBackView.mas_centerY).offset(5);
        make.size.mas_equalTo(accountBtnSize);
    }];
    
    CGSize messageBetSize = CGSizeMake(35, 35);
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).offset(30);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-18);
        make.size.mas_equalTo(messageBetSize);
    }];
}
// 头像点击事件
- (void)changeIcon:(KPButton *)iconBtn
{
    NSPostNote(Noti_UserIconImageDidClick, nil)
}
// 点击账户管理
- (void)accountBtnAction:(KPButton *)accountBtn
{
    NSPostNote(Noti_AccountManagerAction, nil)
}

// 点击消息按钮
- (void)messageBtnAction:(KPButton *)messageBtn
{
  NSPostNote(Noti_MessageBtnAction, nil)
}

// 移除通知
- (void)dealloc
{
    NSRemoveObserver
}
@end
