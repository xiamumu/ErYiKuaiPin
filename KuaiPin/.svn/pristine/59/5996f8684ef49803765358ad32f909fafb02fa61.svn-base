//
//  KPSelecteGoodButton.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/4.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSelecteGoodButton.h"



@implementation KPSelecteGoodButton

#pragma mark - 类方法
+ (instancetype)selecteGoodButtonWithType:(KPSelecteGoodButtonType)selecteType {
    KPSelecteGoodButton *btn = [KPSelecteGoodButton new];
    btn.selecteType = selecteType;
    return btn;
}

#pragma mark - 重写set方法
- (void)setSelecteType:(KPSelecteGoodButtonType)selecteType {
    _selecteType = selecteType;
    
    switch (selecteType) {
        case KPSelecteGoodButtonTypeSelectedAll:
        {
            [self setBackgroundColor:HexColor(#ffffff)];
            self.titleLabel.font = UIFont_15;
            [self setTitleColor:HexColor(#191919) forState:UIControlStateNormal];
            [self setTitle:@"全选" forState:UIControlStateNormal];
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0);
        }
            break;
        case KPSelecteGoodButtonTypeSelectedGood:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 9);
            break;
        case KPSelecteGoodButtonTypeVendorSelectedAll:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 6);
            break;
        default:
            break;
    }
    
}
 
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self setImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"cart_select"] forState:UIControlStateSelected];
}

@end
