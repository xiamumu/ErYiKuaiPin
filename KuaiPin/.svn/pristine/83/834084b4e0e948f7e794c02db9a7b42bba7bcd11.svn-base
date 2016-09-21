//
//  KPBankCardPickerController.m
//  KuaiPin
//
//  Created by 王洪运 on 16/8/19.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPBankCardPickerController.h"
#import "KPBankCardModel.h"
#import "KPSeparatorView.h"


const NSInteger pickerViewY = 104;
const NSTimeInterval animationDuration = 0.3;

@interface KPBankCardPickerController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *pickerView;

@property (nonatomic, strong) KPButton *cancelBtn;

@property (nonatomic, strong) UILabel *pickerTitle;

@property (nonatomic, strong) UITableView *bankCardList;

@property (nonatomic, strong) KPButton *addBankCardBtn;

@property (nonatomic, strong) NSArray<KPBankCardModel *> *cards;

@end

@implementation KPBankCardPickerController

#pragma mark - 触摸,点击事件
- (void)clickCancelButton {
    [self hideBankCardPickerController];
}

- (void)clickAddButton {

    [self hideBankCardPickerController];

    if (self.addBankCardHandler) {
        self.addBankCardHandler();
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideBankCardPickerController];
}

#pragma mark - 类方法
+ (void)showBankCardPickerController {
    KPBankCardPickerController *picker = [KPBankCardPickerController sharedController];
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:picker.view];

    [KPNetworkingTool bankCardListSuccess:^(id result) {
        
        NSInteger code = [result[@"code"] integerValue];

        if (code != 0) {
            WHYNSLog(@"%zd -- %@",code, result[@"message"]);
            return;
        }

        picker.cards = [KPBankCardModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"cards"]];

        [picker.bankCardList reloadData];

        [UIView animateWithDuration:animationDuration animations:^{
            picker.bgView.alpha = 0.4;
            picker.pickerView.y = pickerViewY;
        }];

    } failure:^(NSError *error) {
        WHYNSLog(@"%@", error);
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.cards.count) {
        return 1;
    }
    return self.cards.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellId = @"BankCardListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

    NSString *cellText = @"";
    if (self.cards.count) {
        KPBankCardModel *bankCardModel = self.cards[indexPath.section];
        cellText = [NSString stringWithFormat:@"%@（%@）", bankCardModel.bankName, bankCardModel.trailNumber];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        cellText = @"请先添加银行卡";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.textLabel.text = cellText;
    cell.textLabel.font = UIFont_14;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (!self.cards.count) return;

    [self hideBankCardPickerController];

    if (self.selectedBankCardHnadler) {
        KPBankCardModel *bankCardModel = self.cards[indexPath.section];
        self.selectedBankCardHnadler(bankCardModel.bankCardId);
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [KPSeparatorView new];
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }

    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [KPSeparatorView new];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}


#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
- (void)hideBankCardPickerController {

    KPBankCardPickerController *picker = [KPBankCardPickerController sharedController];

    [UIView animateWithDuration:animationDuration animations:^{
        picker.bgView.alpha = 0.0;
        picker.pickerView.y = SCREEN_H;
    } completion:^(BOOL finished) {
        [picker.view removeFromSuperview];
    }];

}

#pragma mark - set up UI 
- (void)setupUI {

    [self.view addSubview:self.bgView];
    [self.view addSubview:self.pickerView];
    [self.pickerView addSubview:self.cancelBtn];
    [self.pickerView addSubview:self.pickerTitle];
    [self.pickerView addSubview:self.bankCardList];
    [self.pickerView addSubview:self.addBankCardBtn];

    __weak typeof(self) weakSelf = self;

    CGFloat leftRight = 15;
    CGFloat topCenterY = 25;
    CGFloat top = 50;
    CGFloat bottomCenterY = 28;
    CGFloat addBtnH = 56;

    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.pickerView).offset(leftRight);
        make.centerY.mas_equalTo(weakSelf.pickerView.mas_top).offset(topCenterY);
    }];

    [self.pickerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.pickerView.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.cancelBtn);
    }];

    [self.addBankCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.pickerView.mas_bottom).offset(-bottomCenterY);
        make.left.mas_equalTo(weakSelf.pickerView).offset(leftRight);
        make.right.mas_equalTo(weakSelf.pickerView).offset(-leftRight);
        make.height.mas_equalTo(addBtnH);
    }];

    [self.bankCardList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.pickerView);
        make.top.mas_equalTo(weakSelf.pickerView).offset(top);
        make.bottom.mas_equalTo(weakSelf.addBankCardBtn.mas_top);
    }];

}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:self.view.frame];
        _bgView.backgroundColor = BlackColor;
        _bgView.alpha = 0.0;
    }
    return _bgView;
}

- (UIView *)pickerView {
    if (_pickerView == nil) {
        CGFloat x = 47;
        CGFloat y = SCREEN_H;
        CGFloat w = 281;
        CGFloat h = 254;
        _pickerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _pickerView.backgroundColor = WhiteColor;
        _pickerView.layer.cornerRadius = 6;
    }
    return _pickerView;
}

- (KPButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [KPButton new];
        [_cancelBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)pickerTitle {
    if (_pickerTitle == nil) {
        _pickerTitle = [UILabel new];
        _pickerTitle.font = UIFont_18;
        _pickerTitle.text = @"请选择银行卡";
        _pickerTitle.textColor = BlackColor;
    }
    return _pickerTitle;
}

- (UITableView *)bankCardList {
    if (_bankCardList == nil) {
        _bankCardList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _bankCardList.backgroundColor = WhiteColor;
        _bankCardList.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bankCardList.rowHeight = 50;
        _bankCardList.bounces = NO;
        _bankCardList.dataSource = self;
        _bankCardList.delegate = self;
    }
    return _bankCardList;
}

- (KPButton *)addBankCardBtn {
    if (_addBankCardBtn == nil) {
        _addBankCardBtn = [KPButton new];
        [_addBankCardBtn setImage:[UIImage imageNamed:@"plusIcon"] forState:UIControlStateNormal];
        [_addBankCardBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [_addBankCardBtn setTitleColor:OrangeColor forState:UIControlStateNormal];
        _addBankCardBtn.titleLabel.font = UIFont_17;
        [_addBankCardBtn addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
        _addBankCardBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _addBankCardBtn.adjustsImageWhenHighlighted = NO;
    }
    return _addBankCardBtn;
}

singleton_implementation(Controller)

@end
