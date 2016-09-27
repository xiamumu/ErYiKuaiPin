//
//  KPMySelfCommonView.m
//  KuaiPin
//
//  Created by 21_xm on 16/8/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPMySelfCommonView.h"
#import "KPProfileItem.h"

@interface KPMySelfCommonView ()

@property (nonatomic, strong) NSMutableArray *items;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@end

@implementation KPMySelfCommonView


- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

+ (instancetype)commonView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"KPMySelfCommonView" owner:nil options:nil] objectAtIndex:0];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        
        CGFloat X = 0;
        CGFloat W = SCREEN_W / 4;
        CGFloat H = 69;
        
        for (int i = 0; i < 4 ; i++) {
            
            X = W * i;
            KPProfileItem *item = [[KPProfileItem alloc] init];
            item.frame = CGRectMake(X, 40, W, H);
            [self addSubview:item];
            [self.items addObject:item];
        }
        
    }
    return self;
}

- (void)setItemNames:(NSArray *)itemNames
{
    _itemNames = itemNames;
    
    for (int i = 0; i < itemNames.count ; i++) {
        KPProfileItem *item = self.items[i];
        item.imgView.image = [UIImage imageNamed:itemNames[i]];
        item.title.text = itemNames[i];
    }
    
    CGFloat margin = 28;
    CGFloat W = 50;
    CGFloat H = 98;
    
    if (itemNames.count == 3) {
        for (int i = 0; i < itemNames.count ; i++) {
            CGFloat X =  ScaleWidth(margin) + (W + ScaleWidth(margin) * 2) * i;
            KPProfileItem *item = self.items[i];
//            item.backgroundColor = RandomColor;
            item.frame = CGRectMake(X, 40, W, H);
            
            KPProfileItem *lastItem = self.items[3];
            lastItem.hidden = YES;
        }
        
        
    }
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.titleLab.text = title;
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = [subTitle copy];
    self.subTitleLab.text = subTitle;
}

- (void)setUnPayOrderNum:(NSString *)unPayOrderNum
{
    _unPayOrderNum = [unPayOrderNum copy];
    KPProfileItem *item = self.items[0];
    item.badgeValue = unPayOrderNum;
}

- (void)setUnReceiveOrderNum:(NSString *)unReceiveOrderNum
{
    _unReceiveOrderNum = [unReceiveOrderNum copy];
    KPProfileItem *item = self.items[1];
    item.badgeValue = unReceiveOrderNum;
}
@end
