//
//  KPLocalTextView.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/11.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPLocalTextView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, copy) NSString *text;

+ (instancetype)localTextWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder;

@end
