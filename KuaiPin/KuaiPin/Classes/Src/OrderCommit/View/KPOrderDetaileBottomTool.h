//
//  KPOrderDetaileBottomTool.h
//  KuaiPin
//
//  Created by 王洪运 on 16/5/10.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommitHandler)(NSNumber *state);

typedef void(^CancelHandler)();

@interface KPOrderDetaileBottomTool : UIView

@property (nonatomic, strong) NSNumber *addTime;

@property (nonatomic, strong) NSNumber *state;

@property (nonatomic, copy) void (^commitHandler)();

@property (nonatomic, copy) void (^cancelHandler)();

+ (instancetype)orderDetailBottomToolWithCommitHandler:(CommitHandler)commitHandler cancelHandler:(CancelHandler)cancelHandler;

+ (CGFloat)orderDetailBottomToolHeight;

- (void)stopTimer;

@end
