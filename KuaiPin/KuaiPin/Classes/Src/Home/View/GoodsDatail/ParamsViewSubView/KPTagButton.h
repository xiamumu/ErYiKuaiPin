//
//  KPTagButton.h
//  buttonTest
//
//  Created by 21_xm on 16/8/31.
//  Copyright © 2016年 sean.xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPTagButton : KPButton

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *nameId;


- (CGFloat)nextBtnWidthWithNextTitle:(NSString *)nextTitle;

@end
