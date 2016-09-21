//
//  KPSecretCodeView.h
//  KuaiPin
//
//  Created by 21_xm on 16/5/17.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPSecretCodeView : UIView

@property (nonatomic, copy) void (^completion)();

@property (nonatomic, assign, getter=isTakeBackVc) BOOL takeBackVc;


@end
