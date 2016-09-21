//
//  KPChangeUsernameViewController.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPChangeUsernameViewController.h"
#import "UIBarButtonItem+XM.h"
#import "KPCommonTextField.h"
#import "KPUserUpdateParam.h"

@interface KPChangeUsernameViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *textField;
@end

@implementation KPChangeUsernameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改昵称";
    self.view.backgroundColor = BaseColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 70, SCREEN_W, 40);
    bgView.backgroundColor = WhiteColor ;
    [self.view addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.delegate = self;
    textField.frame = CGRectMake(CommonMargin, 0, SCREEN_W - CommonMargin * 2, 40);
    textField.backgroundColor = WhiteColor;
    textField.placeholder = @"请输入昵称";
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.returnKeyType = UIReturnKeyDone;
    [bgView addSubview:textField];
    self.textField = textField;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"提交" titleColor:OrangeColor hightLightColor:GrayColor targe:self action:@selector(submitAction:)];
    
}

- (void)submitAction:(KPButton *)submit
{
    [self submitWithNickName:self.textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self submitWithNickName:textField.text];
    return YES;
}

- (void)submitWithNickName:(NSString *)nickname
{
    KPUserUpdateParam *param = [KPUserUpdateParam param];
    param.nickName = nickname;
    
    __weak typeof (self) weakSelf = self;
    [KPNetworkingTool userUpdateWithParam:param success:^(id result) {
        if ([result[@"code"] integerValue] == 0) {
            
            [KPUserManager sharedUserManager].userModel.nickname = nickname;
            [KPUserManager updateUser];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            WHYNSLog(@"请求数据失败：%@",result[@"message"]);
        }
    } failure:^(NSError *error) {
        
        WHYNSLog(@"请求数据失败%@",error);
    }];
}

- (BOOL)willDealloc
{
    [self.textField removeFromSuperview];
    self.textField = nil;
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}
@end
