//
//  KPAddressListCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPAddressListCell.h"



@interface KPAddressListCell ()

@property (nonatomic, strong) UILabel *nameLB;

@property (nonatomic, strong) UILabel *phoneLB;

@property (nonatomic, strong) UILabel *addressLB;

@property (nonatomic, strong) KPButton *defaultAddressBtn;

@property (nonatomic, strong) KPButton *editBtn;

@property (nonatomic, strong) KPButton *deleteBtn;

@property (nonatomic, strong) KPAddressModel *addresModel;

@end

@implementation KPAddressListCell

- (void)dealloc {
    WHYNSLog(@"KPAddressListCell dealloc");
}

- (BOOL)willDealloc {
    return NO;
}

#pragma mark - 点击事件
- (void)clickDefaultAddressButton {
    NSPostNoteWithUserInfo(Noti_AddressManagerClickDefaultAddressButton, self.addresModel, @{ReceiverIdKey : self.addresModel.receiverId})
}

- (void)clickEditButton {
    NSPostNote(Noti_AddressManagerClickEditButton, self.addresModel)
}

- (void)clickDeleteButton {
    NSPostNoteWithUserInfo(Noti_AddressManagerClickDeleteButton, self.addresModel, @{ReceiverIdKey : self.addresModel.receiverId})
}

#pragma mark - 重写set方法
- (void)setModel:(__kindof KPBaseModel *)model {
    super.model = model;
    self.addresModel = model;
    
    self.nameLB.text = self.addresModel.receiverName;
    self.phoneLB.text = self.addresModel.receiverMobile.phoneSecurityString;
    self.addressLB.text = self.addresModel.address;
    self.defaultAddressBtn.selected = !self.addresModel.isDefault.boolValue;
    
}


#pragma mark - 类方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPAddressListCell";
    
    KPAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPAddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

+ (CGFloat)cellHeight {
    return 130;
}

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = WhiteColor;
    
    KPSeparatorView *sep = [KPSeparatorView new];
    
    [self addSubview:self.nameLB];
    [self addSubview:self.phoneLB];
    [self addSubview:self.addressLB];
    [self addSubview:self.defaultAddressBtn];
    [self addSubview:self.editBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:sep];
    
    __weak typeof(self) weakSelf = self;
    CGFloat leftright = 9;
    CGFloat top = 16;
    CGFloat nameH = 16;
    CGFloat phoneLeft = 40;
    CGFloat addressTop = 12;
    CGFloat addressH = 34;
    CGFloat deleteCenterY = 20;
    CGFloat editRight = 34;
    CGFloat sepTop = 90;
    CGFloat sepH = 1;
    CGFloat defaultAddressW = 90;
    
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftright);
        make.top.mas_equalTo(weakSelf).offset(top);
        make.height.mas_equalTo(nameH);
    }];
    
    [self.phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLB.mas_right).offset(phoneLeft);
        make.top.mas_equalTo(weakSelf.nameLB);
        make.height.mas_equalTo(weakSelf.nameLB);
    }];
    
    [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLB);
        make.right.mas_equalTo(weakSelf).offset(-leftright);
        make.top.mas_equalTo(weakSelf.nameLB.mas_bottom).offset(addressTop);
        make.height.mas_equalTo(addressH);
    }];
    
    [self.defaultAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLB);
        make.centerY.mas_equalTo(weakSelf.deleteBtn);
        make.width.mas_equalTo(defaultAddressW);
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.deleteBtn.mas_left).offset(-editRight);
        make.centerY.mas_equalTo(weakSelf.deleteBtn);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-leftright);
        make.centerY.mas_equalTo(weakSelf.mas_bottom).offset(-deleteCenterY);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLB);
        make.top.mas_equalTo(weakSelf).offset(sepTop);
        make.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(sepH);
    }];
    
}

#pragma mark - 懒加载
- (UILabel *)nameLB {
    if (_nameLB == nil) {
        _nameLB = [UILabel new];
        _nameLB.font = UIFont_16;
        _nameLB.textColor = BlackColor;
    }
    return _nameLB;
}

- (UILabel *)phoneLB {
    if (_phoneLB == nil) {
        _phoneLB = [UILabel new];
        _phoneLB.font = UIFont_16;
        _phoneLB.textColor = BlackColor;
    }
    return _phoneLB;
}

- (UILabel *)addressLB {
    if (_addressLB == nil) {
        _addressLB = [UILabel new];
        _addressLB.font = UIFont_14;
        _addressLB.textColor = GrayColor;
        _addressLB.numberOfLines = 2;
    }
    return _addressLB;
}

- (KPButton *)defaultAddressBtn {
    if (_defaultAddressBtn == nil) {
        _defaultAddressBtn = [KPButton new];
        _defaultAddressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _defaultAddressBtn.titleLabel.font = UIFont_14;
        _defaultAddressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
        [_defaultAddressBtn setTitleColor:HexColor(#8a8a8a) forState:UIControlStateNormal];
        [_defaultAddressBtn setTitle:@"默认地址" forState:UIControlStateNormal];
        [_defaultAddressBtn setImage:[UIImage imageNamed:@"Check"] forState:UIControlStateSelected];
        [_defaultAddressBtn setImage:[UIImage imageNamed:@"circular"] forState:UIControlStateNormal];
        [_defaultAddressBtn addTarget:self
                               action:@selector(clickDefaultAddressButton)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultAddressBtn;
}

- (KPButton *)editBtn {
    if (_editBtn == nil) {
        _editBtn = [KPButton new];
        [_editBtn setImage:[UIImage imageNamed:@"address_edit"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(clickEditButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (KPButton *)deleteBtn {
    if (_deleteBtn == nil) {
        _deleteBtn = [KPButton new];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end


