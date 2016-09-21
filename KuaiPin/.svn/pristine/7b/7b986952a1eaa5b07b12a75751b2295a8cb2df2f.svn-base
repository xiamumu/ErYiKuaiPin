//
//  KPNavigationBar.m
//  KuaiPin
//
//  Created by 21_xm on 16/4/29.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPNavigationBar.h"
#import "XMSearchBar.h"

@interface KPNavigationBar ()


@end
@implementation KPNavigationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UINavigationBar *appearance = [UINavigationBar appearance];
        
        // 设置普通状态的文字属性
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = BlackColor;
        textAttrs[NSFontAttributeName] = UIFont_17;
        [appearance setTitleTextAttributes:textAttrs];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    for (KPButton *button in self.subviews) {
        
        if (![button isKindOfClass:[KPButton class]]) continue;
        
        if (button.centerX < self.width * 0.5) { // 左边的按钮
            button.x = 9;
        } else if (button.x > self.width * 0.5) { // 右边的按钮
//            button.x = self.width - button.width - 9;
        }
        if ([button isKindOfClass:[XMSearchBar class]]) {
            XMSearchBar *searchBar = (XMSearchBar *)button;
            if (searchBar.searchBarType == XMSearchBarTypeShop) {
                searchBar.x = 36;
            }
        }
    }
}

@end
