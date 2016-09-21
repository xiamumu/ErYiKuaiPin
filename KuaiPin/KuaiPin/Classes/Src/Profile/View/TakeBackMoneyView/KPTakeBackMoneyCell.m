//
//  KPTakeBackMoneyCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/13.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPTakeBackMoneyCell.h"
#import "KPTakeBackMoneyCellContentView.h"
#import "KPBankCardModel.h"

@interface KPTakeBackMoneyCell ()
@property (nonatomic, weak) KPTakeBackMoneyCellContentView *takeBackMoneyCellContentView;

@end
@implementation KPTakeBackMoneyCell


+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *takeBackMoneyCell = @"takeBackMoneyCell";
    KPTakeBackMoneyCell *cell = [table dequeueReusableCellWithIdentifier:takeBackMoneyCell];
    if (cell == nil) {
        cell = [[KPTakeBackMoneyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:takeBackMoneyCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPTakeBackMoneyCellContentView *takeBackMoneyCellContentView = [[KPTakeBackMoneyCellContentView alloc] init];
        [self.contentView addSubview:takeBackMoneyCellContentView];
        self.takeBackMoneyCellContentView = takeBackMoneyCellContentView;
        
        __weak typeof (self) weakSelf = self;
        [self.takeBackMoneyCellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.takeBackMoneyCellContentView.selected = selected;
}

- (void)setCard:(KPBankCardModel *)card
{
    _card = card;
    self.takeBackMoneyCellContentView.card = card;
}
@end
