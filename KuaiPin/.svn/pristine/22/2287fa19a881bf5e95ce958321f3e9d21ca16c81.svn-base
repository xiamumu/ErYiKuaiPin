//
//  KPGetExpressInfoCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/7/21.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPGetExpressInfoCell.h"
#import "KPGetExptessInfoCellContentView.h"

@interface KPGetExpressInfoCell ()

@property (nonatomic, weak) KPGetExptessInfoCellContentView *getExptessInfoCellContentView;

@end

@implementation KPGetExpressInfoCell

+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *getExpressInfoCell = @"getExpressInfoCell";
    KPGetExpressInfoCell *cell = [table dequeueReusableCellWithIdentifier:getExpressInfoCell];
    if (cell == nil) {
        cell = [[KPGetExpressInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:getExpressInfoCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KPGetExptessInfoCellContentView *getExptessInfoCellContentView = [[KPGetExptessInfoCellContentView alloc] init];
        [self.contentView addSubview:getExptessInfoCellContentView];
        self.getExptessInfoCellContentView = getExptessInfoCellContentView;
        
        __weak typeof (self) weakSelf = self;
        [self.getExptessInfoCellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (void)setExpressInfoCellFrame:(KPExpressInfoCellFrame *)expressInfoCellFrame
{
    _expressInfoCellFrame = expressInfoCellFrame;
    self.getExptessInfoCellContentView.expressInfoCellFrame = expressInfoCellFrame;
}

- (void)setExpressInfoCellFrameCount:(NSUInteger)expressInfoCellFrameCount
{
    _expressInfoCellFrameCount = expressInfoCellFrameCount;
    self.getExptessInfoCellContentView.expressInfoCellFrameCount = expressInfoCellFrameCount;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    self.getExptessInfoCellContentView.indexPath = indexPath;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
