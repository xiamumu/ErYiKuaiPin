//
//  KPProfileOtherTableViewCell.m
//  KuaiPin
//
//  Created by 21_xm on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPProfileOtherTableViewCell.h"
#import "KPProfileItem.h"
#import "KPProfileItemData.h"

@interface KPProfileOtherTableViewCell ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *lines;

@end

@implementation KPProfileOtherTableViewCell

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}
- (NSMutableArray *)lines
{
    if (_lines == nil) {
        _lines = [[NSMutableArray alloc] init];
    }
    return _lines;
}
+ (instancetype)cellWithTable:(UITableView *)table
{
    static NSString *profileOtherTableViewCell = @"profileOtherTableViewCell";
    KPProfileOtherTableViewCell *cell = [table dequeueReusableCellWithIdentifier:profileOtherTableViewCell];
    if (cell == nil) {
        cell = [[KPProfileOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:profileOtherTableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (int i = 0; i < 3 ; i++) {
            KPProfileItem *item = [[KPProfileItem alloc] init];
            [self.contentView addSubview:item];
            [self.items addObject:item];
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = SeperatorColor;
            [self.contentView addSubview:line];
            [self.lines addObject:line];
        }
    }
    
    return self;
}


- (void)setRowData:(KPProfileRowData *)rowData
{
    _rowData = rowData;
    NSUInteger count = rowData.items.count;
    for (int i = 0; i < count ; i++) {
        KPProfileItemData *itemData = rowData.items[i];
        KPProfileItem *item = self.items[i];
        item.imgView.image = [UIImage imageNamed:itemData.img];
        item.title.text = itemData.title;
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.items.count;
    CGFloat itemW = SCREEN_W / count;
    CGFloat itemH = 116;
    for (int i = 0; i < count; i++) {
        KPProfileItem *item = self.items[i];
        item.frame = CGRectMake(i * itemW, 0, itemW, itemH);
        
        if (i < count - 1) {
            UIView *line = self.lines[i];
            line.frame = CGRectMake(itemW * (i + 1), 0, 1, itemH);
        }
        else
        {
            UIView *line = self.lines[i];
            line.frame = CGRectMake(0, itemH - 1, SCREEN_W, 1);
        }
    }
}

@end
