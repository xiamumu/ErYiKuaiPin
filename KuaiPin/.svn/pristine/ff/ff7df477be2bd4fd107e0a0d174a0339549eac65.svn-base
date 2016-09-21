//
//  KPSeparatorSectionFooterView.m
//  KuaiPin
//
//  Created by 王洪运 on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPSeparatorSectionFooterView.h"

@implementation KPSeparatorSectionFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"KPSeparatorSectionFooterView";
    KPSeparatorSectionFooterView *sepView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (sepView == nil) {
        sepView = [[KPSeparatorSectionFooterView alloc] initWithReuseIdentifier:ID];
    }
    
    return sepView;
}

+ (CGFloat)footerViewHeight {
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
            make.left.right.top.mas_equalTo(weakSelf);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

@end
