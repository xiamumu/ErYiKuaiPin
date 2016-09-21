//
//  KPOrderCommitAddressInfoCell.m
//  KuaiPin
//
//  Created by 王洪运 on 16/4/27.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPOrderCommitAddressInfoCell.h"
#import "KPAddressModel.h"

@interface KPOrderCommitAddressInfoCell ()

@property (nonatomic, strong) UILabel *nameLB;

@property (nonatomic, strong) UILabel *phoneLB;

@property (nonatomic, strong) UILabel *addressLB;

@property (nonatomic, strong) UIImageView *indicatorIcon;

@end

@implementation KPOrderCommitAddressInfoCell

- (void)setIndicatorHidden:(BOOL)indicatorHidden {
    _indicatorHidden = indicatorHidden;
    
    self.indicatorIcon.hidden = indicatorHidden;
}

- (void)setModel:(__kindof KPBaseModel *)model {
    
    super.model = model;
    
    KPAddressModel *defaultReceiver = (KPAddressModel *)model;
    
    self.nameLB.text = defaultReceiver.receiverName;
    self.phoneLB.text = defaultReceiver.receiverMobile.phoneSecurityString;
    self.addressLB.text = defaultReceiver.address;
        
}

+(instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPOrderCommitAddressCell";
    
    KPOrderCommitAddressInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KPOrderCommitAddressInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

+ (CGFloat)cellHeight {
    return 65;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 私有方法
-(void)setupUI {
    
    self.backgroundColor = WhiteColor;
    
    [self addSubview:self.nameLB];
    [self addSubview:self.phoneLB];
    [self addSubview:self.addressLB];
    [self addSubview:self.indicatorIcon];
    
    __weak typeof(self) weakSelf = self;
    CGFloat verticalMargin = 12;
    CGFloat leftRightMargin = 9;
    CGFloat midMargin = 23;
    CGFloat nameH = 16;
    CGFloat addressH = 14;
    CGSize indicatorSize = self.indicatorIcon.image.size;
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(leftRightMargin);
        make.top.mas_equalTo(weakSelf).offset(verticalMargin);
        make.height.mas_equalTo(nameH);
    }];
    
    [self.phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLB.mas_right).offset(midMargin);
        make.top.mas_equalTo(weakSelf.nameLB);
        make.height.mas_equalTo(weakSelf.nameLB);
    }];
    
    [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLB);
        make.top.mas_equalTo(weakSelf.nameLB.mas_bottom).offset(verticalMargin);
        make.height.mas_equalTo(addressH);
    }];
    
    [self.indicatorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf).offset(-leftRightMargin);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(indicatorSize);
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
        _addressLB.textColor = BlackColor;
    }
    return _addressLB;
}

- (UIImageView *)indicatorIcon {
    if (_indicatorIcon == nil) {
        _indicatorIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orderCommit_nextIcon"]];
    }
    return _indicatorIcon;
}







@end
