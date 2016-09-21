//
//  KPMessaageTableViewCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/5.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPMessaageTableViewCell.h"
#import "KPMessageTableViewCellContentView.h"
#import "KPMessage.h"

@interface KPMessaageTableViewCell()

@property (nonatomic, weak) KPMessageTableViewCellContentView *messageContentView;

@end

@implementation KPMessaageTableViewCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *messaageTableViewCell = @"messaageTableViewCell";
    KPMessaageTableViewCell *cell = [table dequeueReusableCellWithIdentifier:messaageTableViewCell];
    if (cell == nil) {
        cell = [[KPMessaageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messaageTableViewCell];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPMessageTableViewCellContentView *messageContentView = [[KPMessageTableViewCellContentView alloc] init];
        [self.contentView addSubview:messageContentView];
        self.messageContentView = messageContentView;
    }
    
    return self;
}

- (void)setMessage:(KPMessage *)message
{
    _message = message;
    self.messageContentView.message = message;
}

- (void)layoutSubviews
{
    __weak typeof (self) weakSelf = self;
    [self.messageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}

@end
