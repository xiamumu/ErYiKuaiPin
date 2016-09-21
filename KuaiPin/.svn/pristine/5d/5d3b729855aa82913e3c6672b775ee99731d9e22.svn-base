//
//  XMSearchBar.m
//  KP
//
//  Created by 21_xm on 16/3/9.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "XMSearchBar.h"
#import "KPSearchController.h"

@interface XMSearchBar()


@end

@implementation XMSearchBar

- (void)searchBarAction
{
    WHYNSLog(@"搜索");
    
    if (self.searchBarType == XMSearchBarTypeHome) {
       [KPSearchController startSearchWithType:KPSearchTypeALL];
    }else if (self.searchBarType == XMSearchBarTypeShop) {
        [KPSearchController startSearchWithType:KPSearchTypeVendor];
    }

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = HexColor(#e6e7e9);
        self.alpha = 0.8;
        self.height = 28;
        [self setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [self setTitleColor:RGBColor(138, 138, 143) forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = UIFont_14;
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = HexColor(#f8f8f8).CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self addTarget:self action:@selector(searchBarAction) forControlEvents:UIControlEventTouchDown];
        
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setTitle:placeholder forState:UIControlStateNormal];
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}
@end
