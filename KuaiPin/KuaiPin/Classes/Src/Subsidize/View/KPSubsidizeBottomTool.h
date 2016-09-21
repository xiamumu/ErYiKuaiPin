//
//  KPSubsidizeBottomTool.h
//  KuaiPin
//
//  Created by 王洪运 on 16/4/26.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPSubsidizeBottomTool;

@protocol KPSubsidizeBottomToolDelegate <NSObject>

- (void)didBottomToolClickCommitOrderButton:(KPSubsidizeBottomTool *)bottomTool;

@end

@interface KPSubsidizeBottomTool : UIView

@property (nonatomic, assign) BOOL selectedAll;

@property (nonatomic, assign) BOOL selectedAllEnable;

@property (nonatomic, weak) id<KPSubsidizeBottomToolDelegate> bottomToolDelegate;

@property (nonatomic, assign) BOOL commitEnable;

@property (nonatomic, assign) CGFloat price;

+ (CGFloat)subsidizeBottomToolHeight;

@end
