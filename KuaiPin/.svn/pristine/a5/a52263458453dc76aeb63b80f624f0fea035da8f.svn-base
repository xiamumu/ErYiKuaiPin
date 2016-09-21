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

@property (nonatomic, weak) KPButton *iconBtn;

@property (nonatomic, weak) KPButton *userNameBtn;

@property (nonatomic, weak) KPButton *editImage;

@property (nonatomic, weak) KPMessageButton *messageBtn;

@property (nonatomic, weak) UIView *line;

@end

@implementation KPProfileHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"my_bg"];
        
        KPUserManager *userManager = [KPUserManager sharedUserManager];
        
        KPButton *iconBtn = [[KPButton alloc] init];
        iconBtn.layer.masksToBounds = YES;
        
        if (userManager.userModel.avatarImg) {
            [iconBtn setBackgroundImage:userManager.userModel.avatarImg forState:UIControlStateNormal];
        } else {
            [iconBtn sd_setImageWithURL:[NSURL URLWithString:userManager.userModel.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userDefaultAvtor"]];
        }
        [iconBtn addTarget:self action:@selector(changeIcon:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iconBtn];
        self.iconBtn = iconBtn;
        
        
        KPButton *userNameBtn = [[KPButton alloc] init];
        [userNameBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        userNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        userNameBtn.titleLabel.font = UIFont_17;
        [userNameBtn setTitle:userManager.userModel.nickname forState:UIControlStateNormal];
        [userNameBtn addTarget:self action:@selector(userNameAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:userNameBtn];
        self.userNameBtn = userNameBtn;
        
        KPButton *editImage = [[KPButton alloc] init];
        [editImage setImage:[UIImage imageNamed:@"my_edit"] forState:UIControlStateNormal];
        [editImage addTarget:self action:@selector(userNameAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editImage];
        self.editImage = editImage;
        
        KPMessageButton *messageBtn = [KPMessageButton messageButton];
        [messageBtn setImage:[UIImage imageNamed:@"message-dark"] forState:UIControlStateNormal];
        [messageBtn addTarget:self action:@selector(messageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        messageBtn.selected = YES;
        [self addSubview:messageBtn];
        self.messageBtn = messageBtn;
        
        UIView *line = [UIView line];
        [self addSubview:line];
        self.line = line;
        
    }
    return self;
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
// 修改用户名
- (void)setUsername:(NSString *)username
{
    _username= [username copy];
    [self.userNameBtn setTitle:username forState:UIControlStateNormal];
}

// 修改用户头像
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
    
    
    CGFloat iconBtnW = 83;
    CGSize iconBtnSize = CGSizeMake(iconBtnW, iconBtnW);
    self.iconBtn.layer.cornerRadius = iconBtnW * 0.5;
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).offset(60);
        make.centerX.mas_equalTo(weakSelf);
        make.size.mas_equalTo(iconBtnSize);
    }];
    
    [self.userNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf).offset(-5);
        make.top.mas_equalTo(weakSelf.iconBtn.mas_bottom).offset(12);
    }];
    
    [self.editImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.userNameBtn);
        make.left.mas_equalTo(weakSelf.userNameBtn.mas_right).offset(CommonMargin);
        make.size.mas_equalTo(weakSelf.editImage.currentImage.size);
    }];
    
    CGSize messageBetSize = CGSizeMake(35, 35);
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).offset(30);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-18);
        make.size.mas_equalTo(messageBetSize);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
}
// 点击用户名事件
- (void)userNameAction:(KPButton *)userNameBtn
{
    if (self.accountManager) {
        self.accountManager();
    }
}
// 头像点击事件
- (void)changeIcon:(KPButton *)iconBtn
{
    if (self.changeUserIcon) {
        self.changeUserIcon();
    }
}

// 点击消息按钮
- (void)messageBtnAction:(KPButton *)messageBtn
{
    if (self.messageBtnBlock) {
        self.messageBtnBlock();
    }
}

// 移除通知
- (void)dealloc
{
    NSRemoveObserver
}
@end
