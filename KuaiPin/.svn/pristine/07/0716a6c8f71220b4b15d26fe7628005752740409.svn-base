//
//  KPAddressManageViewController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAddressManageViewController.h"
#import "UINavigationBar+XM.h"
#import "KPNewReceiverParam.h"

#import "KPTextField.h"
#import "KPLocalTextView.h"
#import "KPUpdateRecevierParam.h"
#import "KPLocalPickerController.h"

@interface KPAddressManageViewController ()<KPTextFieldDelegate>

@property (nonatomic, strong) KPButton *saveBtn;

@property (nonatomic, strong) KPLocalPickerController *localPickerController;

@property (nonatomic, strong) KPTextField *nameTF;

@property (nonatomic, strong) KPTextField *phoneTF;

@property (nonatomic, strong) KPLocalTextView *localTF;

@property (nonatomic, strong) KPTextField *detailTF;

@property (nonatomic, assign, getter=isSaved) BOOL saved;

@end

@implementation KPAddressManageViewController

#pragma mark - KPTextFieldDelegate
- (BOOL)textField:(KPTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 0) return YES;
    
    if (string.isEmoji) return NO;
    
    NSInteger maxLength = 11;
    
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        
        if ([textField isEqual:self.nameTF]) {
            [self.phoneTF becomeFirstResponder];
        }else if ([textField isEqual:self.phoneTF]) {
            [self clickLocalPicker];
        }
        
        return NO;
    } else if(textField.text.length >= maxLength) {
        
        if ([textField isEqual:self.phoneTF]) {
            //输入的字符个数大于maxLength，则无法继续输入，返回NO表示禁止输入
            WHYNSLog(@"输入的字符个数大于%zd，忽略输入", maxLength);
            return NO;
        }
        
        return YES;
    } else {
        return YES;
    }
    
}

#pragma mark - 点击事件
- (void)clickSaveButton {

    if (self.nameTF.text.length == 0) {
        [KPProgressHUD showErrorWithStatus:@"请输入收货人姓名"];
        return;
    }
    
    if (!self.phoneTF.text.isPhoneString) {
        [KPProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }

    if (self.localTF.text.length == 0) {
        [KPProgressHUD showErrorWithStatus:@"请选择收货人所在地区"];
        return;
    }

    if (self.detailTF.text.length == 0) {
        [KPProgressHUD showErrorWithStatus:@"请填写收货人详细地址"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;

    if (self.NewCompletion) {

        KPNewReceiverParam *param = [KPNewReceiverParam param];
        param.receiverName = self.nameTF.text;
        param.receiverMobile = self.phoneTF.text;
        param.provinceId = self.localPickerController.provinceId;
        param.cityId = self.localPickerController.cityId;
        param.countryId = self.localPickerController.countryId;
        param.details =self.detailTF.text;
        
        [KPNetworkingTool newReceiverWithParam:param success:^(id result) {
            
            NSInteger code = [result[@"code"] integerValue];
            
            if (code != 0) {
                WHYNSLog(@"%zd -- %@", code, result[@"message"]);
                [KPProgressHUD showErrorWithStatus:@"新增地址失败，请稍后重试"];
                return;
            }
            
//            WHYNSLog(@"%@", result);
            [KPProgressHUD showSuccessWithStatus:@"新增地址成功" completion:^{
                weakSelf.NewCompletion();
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            
        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
            [KPProgressHUD showErrorWithStatus:@"新增地址失败，请稍后重试"];
        }];
        
    }
    
    if (self.EditCompletion) {
        
        KPUpdateRecevierParam *param = [KPUpdateRecevierParam param];
        param.receiverName = self.nameTF.text;
        param.receiverMobile = self.phoneTF.text;
        param.provinceId = self.localPickerController.provinceId;
        param.cityId = self.localPickerController.cityId;
        param.countryId = self.localPickerController.countryId;
        param.details =self.detailTF.text;
        param.receiverId = weakSelf.addressModel.receiverId;
        
        [KPNetworkingTool updateReceiverWithParam:param success:^(id result) {
           
            NSInteger code = [result[@"code"] integerValue];
            
            if (code != 0) {
                WHYNSLog(@"%zd -- %@", code, result[@"message"]);
                [KPProgressHUD showErrorWithStatus:@"修改地址失败，请稍后重试"];
                return;
            }

            [KPProgressHUD showSuccessWithStatus:@"修改地址成功" completion:^{
                weakSelf.EditCompletion();
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            
        } failure:^(NSError *error) {
            WHYNSLog(@"%@", error);
            [KPProgressHUD showErrorWithStatus:@"修改地址失败，请稍后重试"];
        }];
        
    }
    
    self.saved = YES;

}

- (void)clickLocalPicker {

    [self.localPickerController showView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 类方法
+ (instancetype)addressManageViewControllerWithType:(KPAddressManageType)type {
    
    KPAddressManageViewController *manageVC = [KPAddressManageViewController new];
    manageVC.type = type;
    
    return manageVC;
}

#pragma mark - 重写set方法
- (void)setAddressModel:(KPAddressModel *)addressModel {
    _addressModel = addressModel;
    
    self.nameTF.text = addressModel.receiverName;
    self.phoneTF.text = addressModel.receiverMobile;
    self.localTF.text = addressModel.addressLocal;
    self.detailTF.text = addressModel.details;

    self.localPickerController.addressModel = addressModel;
    
}

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupNavigationBar];
    
    [self.nameTF becomeFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    KPStatisticsBeginWithViewName(SelfClassStr)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KPStatisticsEndWithViewName(SelfClassStr)
}

- (void)dealloc {
    
    WHYNSLog(@"KPAddressManageViewController dealloc");
    
    if (!self.isSaved) {
        NSPostNote(Noti_AddressListVcReloadData, nil)
    }
    
}

#pragma mark - 私有方法
- (void)setupUI {
    
    self.view.backgroundColor = ViewBgColor;
    
    KPSeparatorView *sepTop = [KPSeparatorView new];
    KPSeparatorView *sepMid = [KPSeparatorView new];
    KPSeparatorView *sepBottom = [KPSeparatorView new];
    
    [self.view addSubview:self.nameTF];
    [self.view addSubview:self.phoneTF];
    [self.view addSubview:self.localTF];
    [self.view addSubview:self.detailTF];
    [self.view addSubview:sepTop];
    [self.view addSubview:sepMid];
    [self.view addSubview:sepBottom];

    __weak typeof(self) weakSelf = self;
    CGFloat top = [self checkNavigationBarBackgrounImage] ? 12 : 76;
    CGFloat textFieldH = 56;
    CGFloat leftRight = 9;
    CGFloat sepH = 1;

    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(top);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(textFieldH);
    }];
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameTF.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.nameTF);
    }];
    
    [self.localTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneTF.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.phoneTF);
    }];
    
    [self.detailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.localTF.mas_bottom);
        make.left.right.height.mas_equalTo(weakSelf.localTF);
    }];
    
    [sepTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(leftRight);
        make.right.mas_equalTo(weakSelf.view);
        make.centerY.mas_equalTo(weakSelf.nameTF.mas_bottom);
        make.height.mas_equalTo(sepH);
    }];
    
    [sepMid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(sepTop);
        make.centerY.mas_equalTo(weakSelf.phoneTF.mas_bottom);
    }];
    
    [sepBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(sepTop);
        make.centerY.mas_equalTo(weakSelf.localTF.mas_bottom);
    }];

}

- (void)setupNavigationBar {
    
    self.navigationItem.title = (self.type == KPAddressManageTypeAdd) ? @"新增收货地址" : @"编辑收货地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveBtn];
    
}

- (BOOL)checkNavigationBarBackgrounImage {
    return !![self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 懒加载
- (KPButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [[KPButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        _saveBtn.backgroundColor = OrangeColor;
        _saveBtn.layer.cornerRadius = 6;
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (KPLocalPickerController *)localPickerController {
    if (_localPickerController == nil) {
        __weak typeof(self) weakSelf = self;
        _localPickerController = [KPLocalPickerController localPickerControllerWithFinishedHandler:^(NSString *addressLocation) {
            if (addressLocation) {
                weakSelf.localTF.text = addressLocation;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.detailTF becomeFirstResponder];
                });
            }
        }];
        
    }
    return _localPickerController;
}

- (KPTextField *)nameTF {
    if (_nameTF == nil) {
        _nameTF = [KPTextField textFieldWithTitle:@"收货人" placeHolder:@"请输入收货人姓名"];
    }
    return _nameTF;
}

- (KPTextField *)phoneTF {
    if (_phoneTF == nil) {
        _phoneTF = [KPTextField textFieldWithTitle:@"联系方式" placeHolder:@"请输入手机号"];
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.delegate = self;
    }
    return _phoneTF;
}

- (KPLocalTextView *)localTF {
    if (_localTF == nil) {
        _localTF = [KPLocalTextView localTextWithTitle:@"所在地区" placeHolder:@"请选择地区"];
        [_localTF addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLocalPicker)]];
    }
    return _localTF;
}

- (KPTextField *)detailTF {
    if (_detailTF == nil) {
        _detailTF = [KPTextField textFieldWithTitle:@"详细地址" placeHolder:@"请输入详细地址"];
    }
    return _detailTF;
}
















@end
