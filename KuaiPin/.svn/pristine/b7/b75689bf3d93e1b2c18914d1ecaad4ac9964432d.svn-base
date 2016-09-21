//
//  KPIDCardInputView.h
//  KuaiPin
//
//  Created by 王洪运 on 16/8/25.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPIDCardInputView;

@protocol KPIDCardInputViewDelegate <NSObject>
/// 当inputView输入了一个字符
///
/// @param inputView inputView
/// @param string    string
- (void)inputView:(KPIDCardInputView *)inputView didInputWithNewString:(NSString *)string;

@end

@interface KPIDCardInputView : UIView

@property (nonatomic, weak) id<KPIDCardInputViewDelegate> delegate;

+ (instancetype)IDCardInputViewWithDelegate:(id<KPIDCardInputViewDelegate>) delegate;

@end
