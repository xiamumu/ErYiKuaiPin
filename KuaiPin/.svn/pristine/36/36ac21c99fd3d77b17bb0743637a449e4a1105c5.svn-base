//
//  KPExpressInfoCellFrame.m
//  KuaiPin
//
//  Created by 21_xm on 16/7/22.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPExpressInfoCellFrame.h"
#import "KPExpressInfo.h"

@implementation KPExpressInfoCellFrame

- (void)setExpressInfo:(KPExpressInfo *)expressInfo
{
    _expressInfo = expressInfo;
    
    CGFloat base_W = (SCREEN_W - 55 - 20);
    
    CGFloat titleLab_W = [expressInfo.context sizeWithAttributes:@{NSFontAttributeName: UIFont_15}].width;
    CGFloat titleLab_H = [expressInfo.context sizeWithAttributes:@{NSFontAttributeName: UIFont_15}].height;
    
    NSUInteger count = (NSUInteger)titleLab_W / base_W;
    titleLab_H = titleLab_H * (count + 1);
    
    self.titleLabFrame = CGRectMake(55, CommonMargin, base_W, titleLab_H);
    
    self.timeFrame = CGRectMake(55, CGRectGetMaxY(self.titleLabFrame) + 5, base_W, 15);
    
    self.cellHeight = CGRectGetMaxY(self.timeFrame) + CommonMargin;
}

@end
