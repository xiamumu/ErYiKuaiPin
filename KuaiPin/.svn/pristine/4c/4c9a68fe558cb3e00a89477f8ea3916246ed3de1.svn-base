//
//  KPSeparatorSectionHeaderView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSeparatorSectionHeaderView.h"

@implementation KPSeparatorSectionHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPSeparatorSectionHeaderView";
    KPSeparatorSectionHeaderView *sepView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (sepView == nil) {
        sepView = [[KPSeparatorSectionHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return sepView;
}

+ (CGFloat)headerViewHeight {
    return 10;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ViewBgColor;
        KPSeparatorView *sep = [KPSeparatorView new];
        [self addSubview:sep];
        
        __weak typeof(self) weakSelf = self;
        [sep mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

@end
